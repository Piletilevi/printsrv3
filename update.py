# coding: utf-8

from os import environ, path, chdir
import github3
from json import load as loadJSON
from json import loads as loadsJSON
from json import dumps as dumpsJSON
from sys import argv, stdout

print(argv)
# LANGUAGE = environ['plp_language']
GH_OWNER = 'Piletilevi'
GH_UPDATE_PROJECT = 'printsrv'

if (not 'plp_update_to_version' in environ):
    raise IndexError('Missing "plp_update_to_version" in environment variables.')
UPDATE_TO_TAG = environ['plp_update_to_version']

if ('gh_token' in environ):
    gh_token = environ['gh_token']
    print('Access GitHub3 API via token {0}.'.format(gh_token))
    gh3 = github3.login(token = gh_token)
else:
    gh3 = github3
print('Rate limit remaining: {0}'.format(gh3.ratelimit_remaining))
PRINTSRV_REPO = gh3.repository(GH_OWNER, GH_UPDATE_PROJECT)

UPDATE_SHA = ''
for tag in PRINTSRV_REPO.tags():
    if (tag.as_dict()['name'] == UPDATE_TO_TAG):
        UPDATE_SHA = tag.as_dict()['commit']['sha']
if (UPDATE_SHA == ''):
    raise ValueError('No tag under name "{0}" in GitHub.'.format(UPDATE_TO_TAG))

def version_info():
    with open('package.json', 'rU') as package_file:
        local_package_json = loadJSON(package_file)
    contents = PRINTSRV_REPO.file_contents('package.json', UPDATE_SHA).decoded
    try:
        remote_package_json = loadsJSON(contents)
    except ValueError:
        raise Exception('package.json not valid at {0}.'.format(UPDATE_TO_TAG))
    return (local_package_json['version'], remote_package_json['version'], remote_package_json)
L_VER, R_VER, REMOTE_PACKAGE = version_info()

if (L_VER == R_VER):
    print('Already at {0} (tag:"{1}")'.format(L_VER, UPDATE_TO_TAG))
    exit(0)


chdir('..')

def update_files(repository):
    repo_name = repository['repository']
    commit_sha = repository['sha']
    print('Updating {0}'.format(repo_name))
    gh_repo = gh3.repository(GH_OWNER, repo_name)
    for f in repository['files']:
        if (f['local'] == False):
            continue
        # local_file = path.join(repo_name, f['local'])
        local_file = path.realpath(path.join(repo_name, f['local']))
        stdout.write('Updating {0}'.format(f))
        with open(local_file, 'w+b') as write_file:
            try:
                f_contents = gh_repo.file_contents(f['remote'], commit_sha)
            except github3.exceptions.ForbiddenError:
                print('File too big. Up to 1MB is supported for syncing through API3.')
            else:
                write_file.write(f_contents.decoded)
                print('ok.')

print('Update required: local:"{0}" <= remote: "{1}".'.format(L_VER, R_VER))
for repository in REMOTE_PACKAGE['updateFiles']:
    update_files(repository)
    continue
    stdout.write('RasoASM: update %s ...' % filename)
    with open(filename,'w') as package_file:
        package_file.write(PRINTSRV_REPO.file_contents(filename).decoded)
        print(' done.')

# As everything finished successfully, update package.json from requested tag.
with open('printsrv\package.json', 'w') as write_file:
    print(REMOTE_PACKAGE)
    write_file.write(dumpsJSON(REMOTE_PACKAGE, indent = 2))

print('printsrv update finished.')

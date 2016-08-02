# coding: utf-8

import os
import github3
from json import load as loadJSON
from json import loads as loadsJSON
from sys import stdout

# LANGUAGE = os.environ['plp_language']
GH_OWNER = 'Piletilevi'
GH_UPDATE_PROJECT = 'printsrv'

if (not 'plp_update_to_version' in os.environ):
    raise IndexError('Missing "plp_update_to_version" in environment variables.')

UPDATE_TO_TAG = os.environ['plp_update_to_version']

if ('gh_token' in os.environ):
    gh_token = os.environ['gh_token']
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

l_ver, r_ver, remote_package = version_info()

if (l_ver == r_ver):
    print('Allready at {0} (tag:"{1}")'.format(l_ver, UPDATE_TO_TAG))
    exit(0)

def update_files(repository):
    print('Updating {0}'.format(repository['repository']))
    gh_repo = gh3.repository(GH_OWNER, repository['repository'])
    gh_sha = ''
    for tag in gh_repo.tags():
        if (tag.as_dict()['name'] == repository['tag']):
            gh_sha = tag.as_dict()['commit']['sha']
    if (gh_sha == ''):
        raise ValueError('No tag under name "{0}" in GitHub.'.format(repository['tag']))
    for f in repository['files']:
        stdout.write('Updating {0}'.format(f))
        with open(f['local'], 'w+b') as write_file:
            f_contents = gh_repo.file_contents(f['remote'])
            write_file.write(f_contents.decoded)
            print('ok.')

print('Update required: local:"{0}" <= remote: "{1}".'.format(l_ver, r_ver))
for repository in remote_package['updateFiles']:
    update_files(repository)
    continue
    stdout.write('RasoASM: update %s ...' % filename)
    with open(filename,'w') as package_file:
        package_file.write(PRINTSRV_REPO.file_contents(filename).decoded)
        print(' done.')

print('printsrv update finished.')

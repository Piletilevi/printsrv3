# coding: utf-8

from os import environ, path, chdir, remove
from urllib2 import urlopen, URLError, HTTPError

from json import load as loadJSON
from json import loads as loadsJSON
from sys import argv, stdout, exit

from zipfile import ZipFile

if not 'plp_update_to_version' in environ:
    raise IndexError('Missing "plp_update_to_version" in environment variables.')

UPDATE_TO_TAG = environ['plp_update_to_version']
REMOTE_PLEVI = 'https://github.com/Piletilevi/printsrv/releases/download/{0}/plevi_update_{0}.zip'.format(UPDATE_TO_TAG)
LOCAL_PLEVI = path.join(path.dirname(path.abspath(argv[0])), path.basename(REMOTE_PLEVI))
print 'path.abspath(argv[0]): {0}'.format(path.abspath(argv[0]))
print 'LOCAL_PLEVI: {0}'.format(LOCAL_PLEVI)

def dlfile(remote_filename, local_filename):
    print remote_filename, '-->', local_filename
    # Open the remote_filename
    try:
        remote_file = urlopen(remote_filename)
        print 'downloading', remote_filename

        # Open our local file for writing
        with open(local_filename, 'wb') as local_file:
            local_file.write(remote_file.read())

    #handle errors
    except HTTPError, err:
        print 'Can not update to', UPDATE_TO_TAG, 'HTTP Error:', err.code, remote_filename
        return False
    except URLError, err:
        print 'Can not update to', UPDATE_TO_TAG, 'URL Error:', err.reason, remote_filename
        return False
    except IOError, err:
        print 'Can not update to', UPDATE_TO_TAG, 'IO Error:', err, local_filename
        return False

    return True


def version_info():
    with open(path.join(path.dirname(argv[0]), 'printsrv', 'package.json'), 'rU') as package_file:
        try:
            local_package_json = loadJSON(package_file)
        except ValueError:
            print 'WARNING: local package.json is damaged.'
            local_package_json = {'version': 'N/A'}
    return local_package_json['version']


L_VER = version_info()
if L_VER == UPDATE_TO_TAG:
    print 'Already at {0} (tag:"{1}")'.format(L_VER, UPDATE_TO_TAG)
    exit(0)


print 'Update required: local:"{0}", remote: "{1}".'.format(L_VER, UPDATE_TO_TAG)


chdir('..')

if dlfile(REMOTE_PLEVI, LOCAL_PLEVI):
    with ZipFile(LOCAL_PLEVI, 'r') as z:
        z.extractall(path.join(path.dirname(LOCAL_PLEVI)))
    remove(LOCAL_PLEVI)
else:
    exit(1)

print 'Drivers updated.'

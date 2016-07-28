from json import load as loadJSON
from os import path
from sys import argv

basedir = path.realpath(path.dirname(argv[0]))
package_file_name = path.join(basedir, 'package.json')

with open(package_file_name, 'r') as package_json_file:
    package_json = loadJSON(package_json_file)

VERSION = package_json['version']

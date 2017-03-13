import json
import os

print 'Account is ' + os.environ['ACCOUNT']

# File stuff
templateFile = open("/root/keyExporter/genesis.template").read()
jsonFile = open("/root/keyExporter/genesis.json","w")

jsonObject = json.loads(templateFile)
jsonObject['coinbase'] = '0x' + os.environ['ACCOUNT']
alloc = dict()
alloc['0x' + os.environ['ACCOUNT']] = jsonObject['alloc']['[DefaultAccount]']
jsonObject['alloc'] = alloc
json.dump(jsonObject, jsonFile)
/**
 * Created by maior on 01/02/2017.
 */

var keythereum = require('keythereum');
var fs = require('fs');
var config = require('../configuration/config.js');
var keydir = config.keyfolder;
var Web3 = require('web3');

var web3 = new Web3(new Web3.providers.IpcProvider('geth.ipc', require('net')))
console.log("Keydir is " + keydir);

const importKey = function (address) {
    console.log(keydir)

    var rawobj = keythereum.importFromFile(address,keydir);

    fs.readdir(keydir + "/keystore" , (err,files) => {
        files.forEach(file => {
           if (file.indexOf(address) > -1){
               fs.unlink(keydir + '/keystore/' + file, (err) => {
                   if (err) console.log(err);
                   console.log("Deleted keyfile");
               })
        }
        });
    });

    return rawobj;
};

const accounts = function () {
    var accounts = web3.personal.listAccounts();
    console.log(accounts);
    return accounts;
}

module.exports = {importKey,accounts};
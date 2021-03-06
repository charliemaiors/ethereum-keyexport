/**
 * Created by maior on 01/02/2017.
 */

var keythereum = require('keythereum');
var fs = require('fs');
var config = require('../configuration/config.js');
var keydir = config.keyfolder;
var personal = require('./personal.js');

console.log("Keydir is " + keydir);

var options = {
    port: '8545',
    host: 'localhost',
    path: '/',
    strict: true
}


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

function accounts() {
    console.log("Retrieving accounts")
    var pers = new personal.Personal(options)
    return pers.list_accounts();
}

module.exports = {importKey,accounts};

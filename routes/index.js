var express = require('express');
var keyexport= require('../keyth/keyexport');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
  res.send('hello from keyth');
});

router.get('/address/:address', function (req, res, next) {
    var address = req.params.address;

    if (address.indexOf("0x") > -1){
        address = address.replace('0x','');
    }

    var rawobj = keyexport.importKey(address);

    res.json(rawobj);
})

router.get('/accounts', function (req, res, next) {
    Promise.resolve(keyexport.accounts()).then(p => res.json(p));
})

module.exports = router;

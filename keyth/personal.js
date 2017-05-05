/**
 * Created by maior on 05/05/2017.
 */

var json_rpc = require('jayson/promise')

class RpcClient{

    constructor(options){
        this.client = new json_rpc.client.http(options);
    }

    execute_method(method_name, params){
        return this.client.request(method_name,params)
    }
}

class Personal extends RpcClient{

    constructor(options){
        super(options)
    }

    list_accounts(){
        console.log("Listing accounts")
        return super.execute_method("personal_listAccounts",[])
    }
}

module.exports = {Personal};
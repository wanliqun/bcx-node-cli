let _bcx=require('../vendor/cocosbcx/bcx.node.js');

let bcxSDK=_bcx.createBCX({
    default_ws_node:"ws://127.0.0.1:41346",
    ws_node_list:[	
         {url:"ws://127.0.0.1:41346",name:"privatenet"}   	
    ],
    networks:[
        {
            core_asset:"COCOS",
            chain_id:"5c7782cfd10c81222670a3beae843048a2c39aa672a3ef81588e32232d1035a0" 
        }
    ], 
    faucet_url:"",
    auto_reconnect:true,
    real_sub:true,
    check_cached_nodes_data:false                 
});

exports.bcxSDK=bcxSDK
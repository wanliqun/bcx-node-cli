--[[ 初始化操作
参数:
    world_view: nft 资产所在的世界观
--]] 
function init(world_view)
    assert(chainhelper:is_owner(),'必须是合约所有者才能调用')
    assert(world_view,'未指定世界观')

    -- 读取参数
    read_list={public_data={is_init=true}}
    chainhelper:read_chain()
    assert(public_data.is_init==nil,'合约已被初始化过')

    -- 保存初始化数据
    public_data.is_init=true
    public_data.world_view=world_view
    write_list={public_data={is_init=true,world_view=true}}
    chainhelper:write_chain()
end

--[[ 发行 NFT 卡密
参数:
    price_amount: 购买价格
    price_symbol: 购买资产符号

--]] 
function issue(name,description,icon,redeem_code,price_amount,price_symbol,memo)
    assert(chainhelper:is_owner(),'必须是合约所有者才能发行卡密')

    read_list={public_data={is_init=true,world_view=true}}
    chainhelper:read_chain()
    assert(public_data.is_init==true,'合约尚未初始化')

    local world_view=public_data.world_view
    assert(world_view,'NFT所属世界观尚未初始化')
    
    local owner=contract_base_info.owner
    local nft_card_id=create_nh_asset(owner,'COCOS',world_view, string base_describe, bool enable_logger)

    commissions=cjson.decode(commissions_json)

    name: 卡密名称
    description: 卡密描述
    icon: 卡密图标地址
    redeem_code: 兑换码
    memo: 卡密备注

    local nft_card_id=chainhelper:create_nft_asset(game_user,world_view,item_desc_json,true,true)
    -- 创建 nft 资产，由合约 owner 持有代理权
    local asset_id=chainhelper:create_nft_asset(game_user,world_view,item_desc_json,true,true)

    write_list=read_list
    chainhelper:write_chain()
end

--[[ 购买 NFT 卡密
参数:
    world_view: nft 资产所在的世界观
--]] 
function buy()
end

--[[ NFT 卡密订单确认
参数:
    world_view: nft 资产所在的世界观
--]] 
function confirm()
end

--[[ NFT 申请退款（仅限订单未确认之前）
参数:
    world_view: nft 资产所在的世界观
--]] 
function refund()
end

--[[ 获取兑换码
参数:
    world_view: nft 资产所在的世界观
--]] 
function redeem()
end

--[[ 中止合约
参数:
    world_view: nft 资产所在的世界观
--]] 
function halt()
end

-- 从例如 '2019-09-12T05:23:30' 的日期字符串获取日期时间对象
func_datetime_from_string=function(dt_str)
    local y, m, d, h, mt, s = string.match(dt_str, '(%d%d%d%d)-(%d%d)-(%d%d)T(%d%d):(%d%d):(%d%d)$')
    return {year=y+0, month=m+0, day=d+0, hour=h+0, minute=mt+0, second=s+0}
end
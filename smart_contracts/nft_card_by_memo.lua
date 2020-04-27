local tbl_nft_orders
local tbl_nft_deals

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
    props_json: 卡密属性，如名称、描述、icon等
    price_amount: 购买价格
    price_symbol: 购买资产符号
--]] 
function issue(props_json,price_amount,price_symbol)
    assert(chainhelper:is_owner(),'必须是合约所有者才能发行卡密')

    read_list={public_data={is_init=true,world_view=true}}
    chainhelper:read_chain()
    assert(public_data.is_init==true,'合约尚未初始化')

    local world_view=public_data.world_view
    assert(world_view,'NFT所属世界观尚未初始化')
    
    assert(props_json,'属性描述不能为空')
    local owner=contract_base_info.owner
    local nft_card_id=create_nh_asset(owner,'COCOS',world_view,props_json,true)

    read_list={public_data={tbl_nft_orders=true}}
    chainhelper:read_chain()
    tbl_nft_orders=public_data.tbl_nft_orders
    if (not tbl_nft_orders) then
        tbl_nft_orders={}
        public_data.tbl_nft_orders=tbl_nft_orders
    end
    
    

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
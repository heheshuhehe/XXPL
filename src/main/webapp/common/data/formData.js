var store_khgf = new Ext.data.SimpleStore({
        fields: ['value', 'name'],
        data : [
                ['0','合规'],
                ['1','不合规'],
                ['2','特殊']]
});

var store_wyhmc= new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['A','投资银行委员会'],
            ['B','资产管理委员会'],
            ['C','固定收益委员会'],
            ['D','交易委员会'],
            ['E','互联网业务委员会'],
            ['F','营销委员会'],
            ['G','风险管理委员会'],
            ['H','信息与运营委员会'],
            ['I','综合服务委员会']]
});
var store_gxlx = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['','——请选择——'],
            ['1','低效客户开发关系'],
            ['2','异地开发关系'],
            ['3','投顾服务关系'],
            ['4','开发关系'],
            ['5','服务关系'],
            ['6','产品签约关系']]
});

var store_khzt = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['0','正常'],
            ['1','冻结'],
            ['2','挂失'],
            ['4','不合格'],
            ['5','休眠'],
            ['7','预存管销户'],
            ['9','销户'],
            ['10','失效有效户']]
});
var comp_reason = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['1','我在3s 7模块内做了维护'],
            ['2','我在3s 其他模块做了维护'],
            ['3','我在3s 7模块、其他模块都做了维护'],
            ['4','']]
});
var yg_status = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['0','正常'],
            ['1','离职'],
            ['3','']]
});
var cyfs_store = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['1','承揽'],
            ['2','承做'],
            ['3','销售']]
});

var store_khgf = new Ext.data.SimpleStore({
        fields: ['value', 'name'],
        data : [
                ['0','合规'],
                ['1','不合规'],
                ['2','特殊']]
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
var order_status = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','待审核'],
	        ['02','审核通过'],
	        ['03','审核不通过'],
	        ['04','取消']]
});
var order_direct = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','签约'],
	        ['02','变更'],
	        ['03','续签'],
	        ['04','退订']]
});
var contr_status = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','有效'],
	        ['02','续签'],
	        ['03','退订'],
	        ['04','到期'],
	        ['05','欠费终止'],
	        ['06','无效']]
});
var charge_status = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','待收'],
	        ['02','已收'],
	        ['03','欠费']]
});
var apay_status = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','待收费'],
	        ['02','扣费成功'],
	        ['03','扣费失败'],
	        ['00','扣费中']]
});
var store_obj_type=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['1','01'],
	        ['2','02'],
	        ['3','03'],
	        ['4','04']]
});
var store_call_type=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['1','01'],
	        ['2','02'],
	        ['3','03'],
	        ['4','04']]
});
var store_exe_status=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['1','01'],
	        ['2','02'],
	        ['3','03'],
	        ['4','04']]
});
var store_policy_status=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','全部'],
	        ['01','有效'],
	        ['02','无效']]
});
var store_contr_cycle_num=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [
	        ['1','一个月'],
	        ['3','三个月'],
	        ['6','六个月'],
	        ['12','一年']]
});
var store_charge_way=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [
	        ['01','按月'],
	        ['02','按季']]
});
var store_check_mark=new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [
	        ['01','是'],
	        ['02','否']]
});


var sendMsgType = new Ext.data.SimpleStore({
    fields: ['value', 'name'],
    data : [['','--请选择--'],
            ['1','注册'],
            ['2','找回密码'],
            ['3','投资成功']]
});
var sendStatus = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','--请选择--'],
	        ['00','发送失败'],
	        ['01','发送成功']]
});
var sendMsgKey = new Ext.data.SimpleStore({
	fields: ['value', 'name'],
	data : [['','--请选择--'],
	        ['1001','宏源视点'],
	        ['872','测试套餐-热股追击']]
});

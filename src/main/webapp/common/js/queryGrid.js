var queryGrid_win_js;
var allCheckFlag = true;
var checkedAllMap={};
var pageclickednumber_;
var begin_;
var end_;
Array.prototype.indexOf=function(val){
	for(var i=0;i<this.length;i++){
		if(this[i]==val) return i;
	}
}
//删除index的操作
//Array.prototype.removeIndex = function(dx) {
//	if (isNaN(dx) || dx > this.length) {
//		return false;
//	}
//	for ( var i = 0, n = 0; i < this.length; i++) {
//		if (this[i] != this[dx]) {
//			this[n++] = this[i];
//		}
//	}
//	this.length = this.length - 1;
//};

Array.prototype.remove = function(val) {
	var index=this.indexOf(val);
	if(index>-1){
		this.splice(index,1);
	}
}
$(function(){
	/*表单全选和全不选控制*/
	$("#allcheck").click(function(){ 
//		  $("input[name='checkbox_queryGrid']").each(function(){
//		   $(this).attr("checked",allCheckFlag);
//		   if(allCheckFlag){
//			   value_checked.push("'"+$(this).val()+"'");
//		   }else{
//			   value_checked.remove("'"+$(this).val()+"'");
//		   }
//		  });
//		  allCheckFlag = !allCheckFlag;
		alert('haha');
		if($("#allcheck".attr("checked")=="checked")){
			for(var i=begin_;i<=end_;i++){
				if(value_checked.indexOf(store[i].col1)==-1){
					value_checked.push(store[i].col1);					
				}
			}			
		}else{
			for(var i=begin_;i<=end_;i++){
				//if(value_checked.indexOf(store[i])==-1){
					value_checked.remove(store[i].col1);					
				//}
			}
		}
		//console,log(store);
		pageClick(pageclickednumber_);
	});

});

PageClick = function(pageclickednumber) { 
	$("#pager_queryGrid").pager({ 
		pagenumber: pageclickednumber,//当前页数
		pagecount: totalpages_, //页面显示的页数
		buttonClickCallback: PageClick
	});
	pageClick(pageclickednumber);
};

function pageClick(pageclickednumber) {
	$("#allcheck").attr("checked",false);
	  var ths='';
		pageclickednumber_ = pageclickednumber;
	   var begin =(pageclickednumber-1)*defaultPageSize_;
	   var end =pageclickednumber*defaultPageSize_;
	   begin_=begin;
	   end_=end;
	   if(q_flag==0){
			for(var i=begin;i<end&&i<store.length;i++){
				var ch_flag="";
				if(value_checked.indexOf("'"+store[i].col1+"'")>-1){
					ch_flag="checked";
				}
			    ths+='<tr style="height:15px;padding:0;margin:0">';
				ths+='<td style="text-align:center"><input type="checkbox"  onclick=insertData(this); value='+store[i].col1+' name="checkbox_queryGrid"'+ch_flag+'/></td>';
				for(var j=0;j<store_header.length;j++){
					var tt="col"+(j+1);
					eval("var rt=store[i]."+tt);
					if(j==0&&q_flag==0){
						ths+="<td>'"+rt+"'</td>";
						
					}else{
						ths+="<td>"+rt+"</td>";
					}
					//ths+='<td style="height:15px;padding:0;margin:0">'+store[i].name+'</td>';
				}
				ths+="</tr>";
			}
			   var hh=$('#table_result');
			   hh.html(ths);
			   getCheckValue();

	   }else if(q_flag==1){
		   var dataPara = {
				   v_page_size:defaultPageSize_,
				   v_page:pageclickednumber,
				   v_type:q_type,
				   v_length:store_header.length
			  };
		   if(store.length==0){
			   
			   $.ajax({
				   url : 'QueryFormHandel.action?mathid='+Math.random(),
				   type : 'post',
				   data : dataPara,
				   dataType:'json',//接受数据格式 
				   success : function(data) {
					   var d_length=data.length;
					   var d_total=getPagecount(d_length,defaultPageSize_);
					   $("#pager_queryGrid").pager({ 
						   pagenumber: pageclickednumber, 
						   pagecount: d_total,
						   buttonClickCallback: PageClick 
					   });
					   for(var i=begin;i<end&&i<data.length;i++){
						   var oneCol = data[i];
						   store=data;
						   store_temp=data;
						   if(q_type=='fzjg'||q_type=='tdbh'){
							   ths+='<tr style="height:15px;padding:0;margin:0" onclick=insertfzjgData('+oneCol['col1']+',this) onmouseover="colorChange(this)" onmouseout="colorChangeback(this)" style="height:15px;padding:0;margin:0">';
							   //ths+='<td style="text-align:center"><input type="checkbox"  onclick=insertfzjgData(this); value='+oneCol['col1']+' name="checkbox_queryGrid"/></td>';					    	
						   }else{
							   ths+='<tr style="height:15px;padding:0;margin:0">';
							   ths+='<td style="text-align:center"><input type="checkbox"  onclick=insertData(this); value='+oneCol['col1']+' name="checkbox_queryGrid"/></td>';
						   }
						   for(var key in oneCol){
							   ths +='<td>'+oneCol[key]+'</td>';
						   }
						   ths += '</tr>';
					   }
					   var hh=$('#table_result');
					   hh.html(ths);
				   },
				   failure : function(data) {
					   alert('gaga');
					   window.clearInterval(print);
				   }
			   });
		   }else{
			   var d_length=store.length;
			   var d_total=getPagecount(d_length,defaultPageSize_);
			   $("#pager_queryGrid").pager({ 
				   pagenumber: pageclickednumber, 
				   pagecount: d_total,
				   buttonClickCallback: PageClick 
			   });
			   for(var i=begin;i<end&&i<store.length;i++){
				   var oneCol = store[i];
				   if(q_type=='fzjg'||q_type=='tdbh'){
					   ths+='<tr style="height:15px;padding:0;margin:0" onclick=insertfzjgData('+oneCol['col1']+',this) onmouseover="colorChange(this)" onmouseout="colorChangeback(this)" style="height:15px;padding:0;margin:0">';
					   //ths+='<td style="text-align:center"><input type="checkbox"  onclick=insertfzjgData(this); value='+oneCol['col1']+' name="checkbox_queryGrid"/></td>';					    	
				   }else{
					   ths+='<tr style="height:15px;padding:0;margin:0">';
					   ths+='<td style="text-align:center"><input type="checkbox"  onclick=insertData(this); value='+oneCol['col1']+' name="checkbox_queryGrid"/></td>';
				   }
				   for(var key in oneCol){
					   ths +='<td>'+oneCol[key]+'</td>';
				   }
				   ths += '</tr>';
			   }
			   var hh=$('#table_result');
			   hh.html(ths);
		   }
		
	   }
}
function getCheckValue(){  
			var t=$("input[name='checkbox_queryGrid']");
			for(var j=0;j<t.length;j++){
				for(var i=0;i<value_checked.length;i++){
					if($(t[j]).val()==value_checked[i]){
						$(t[j]).attr("checked",'true');
						break;
					}
				}
			}
}
function insertData(ele1){
	var ele=$(ele1);
	if(q_flag==0){
		if("checked"==ele.attr("checked")){
			if("tjfs"==q_type){
				value_checked.push(ele.val());						
			}else{
				value_checked.push("'"+ele.val()+"'");						
			}
		}else if(typeof(ele.attr("checked"))=='undefined'){
			//value_checked.remove("'"+ele.val()+"'");	 
			if("tjfs"==q_type){
				value_checked.remove(ele.val());					
			}else{
				value_checked.remove("'"+ele.val()+"'");					
			}
		}
	}else{
		if("checked"==ele.attr("checked")){
			 value_checked.push(ele.val());			
		 }else if(typeof(ele.attr("checked"))=='undefined'){
			 value_checked.remove(ele.val());	
		 }
	}
}
function insertfzjgData(ele1,ele){
	if(value_checked_ele.length>0){
		var g=value_checked_ele[0];
		g.onmouseover=colorChange(g) ;
		g.onmouseout=colorChangeback(g);
		g.style.backgroundColor="";
	}
	value_checked=[];
	value_checked_ele=[];
	value_checked.push(ele1);
	value_checked_ele.push(ele);
	ele.style.backgroundColor="#97CBFF";
	ele.onmouseover=function(){} ;
	ele.onmouseout=function(){};
	//pageClick(pageclickednumber_);

}

function colorChange(ele){
	ele.style.backgroundColor="#97CBFF";
}
function colorChangeback(ele){
	ele.style.backgroundColor="";
}



function getInnerQuery(){
	//内层查询
	var p=new Ext.Panel({
		id:"panel222",
		title:"查询条件",
		renderTo:"inner_query_id_222",
		closable:true,
		width:300,
		height:250,
		html:'haha'
		
	});
}



function getInnerQueryt(){
	var w=new Ext.Window({
		x:50,
		y:50,
		title:"设置查询条件",
		closable:true,
		width:300,
		height:80,
		items:[{xtype:"textfield",fieldLabel:"营业部编号",name:"yybbh"}],
		buttons:[{text:"查询"}]
	});
	w.show();
}


function innerQueryWin(val){
	//console.log("val="+val);
	if(val==null||val==''){
		store=store_temp;
	}else{
		
		store=[];
		for(var i=0;i<store_temp.length;i++){
			var f_exists=false;
			for(var j=0;j<store_header.length;j++){
				var tt="col"+(j+1);
				eval("var rt=store_temp[i]."+tt);
				if(rt.indexOf(val)>-1){
					f_exists=true;
				}	
			}
			if(f_exists){
				store.push(store_temp[i]);
			}
		}
	}
	size=store.length;
	totalpages_ = getPagecount(size,defaultPageSize_);
	$("#pager_queryGrid").pager({ 
	    pagenumber: 1, 
	    pagecount: totalpages_,
	    buttonClickCallback: PageClick 
    });
	  pageClick(1);
}

function allgaga(){
		if($("#allcheck").attr("checked")=="checked"){
			for(var i=begin_;i<end_;i++){
				if(value_checked.indexOf(store[i].col1)==-1||typeof(value_checked.indexOf(store[i].col1))=='undefined'){
					value_checked.push(store[i].col1);					
				}
			}	
			  $("input[name='checkbox_queryGrid']").each(function(){
			   $(this).attr("checked",true);
			  
			  });
		}else{
			for(var i=begin_;i<end_;i++){
					value_checked.remove(store[i].col1);					
			}
			  $("input[name='checkbox_queryGrid']").each(function(){
				   $(this).attr("checked",false);  
				});
		}
		
}
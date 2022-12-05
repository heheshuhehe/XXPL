// excel比较 
function excel_comparison() { 
    var id = $("div[class='tabs-panels']").find("div[class='panel']").eq(4)
				.find("input[name='ck']:checked").val();
}
// 下载excel比较结果
function download_compar_result() { 
} 
// 添加需要替换的excel页签  
function replace_add_sheet(){ 
   let replace_sheets = document.getElementById("replace_sheets"); 
   let test = document.getElementById("test"); 
   let s_html =  replace_sheets.innerHTML ;
   s_html = s_html + '<input class="easyui-textbox textbox-f" id="sheet1" style="width: 400px; display: none;" textboxname="sheet1"><span class="textbox" style="width: 398px; height: 20px;"><input type="text" class="textbox-text validatebox-text textbox-prompt" autocomplete="off" placeholder="" style="margin-left: 0px; margin-right: 0px; padding-top: 3px; padding-bottom: 3px; width: 390px;"><input type="hidden" class="textbox-value" name="sheet1" value=""></span><p>';
   test.innerText = s_html; 
   replace_sheets.innerHTML  = s_html ;
}
// 替换excel中的某些页签  
function excel_replase(){ 
}

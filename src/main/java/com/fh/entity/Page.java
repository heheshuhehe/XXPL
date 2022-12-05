package com.fh.entity;


import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;


public class Page {
	
	private int showCount; //每页显示记录数
	private int totalPage;		//总页数
	private int totalResult;	//总记录数
	private int currentPage;	//当前页
	private int currentResult;	//当前记录起始索引
	private boolean entityOrField;	//true:需要分页的地方，传入的参数就是Page实体；false:需要分页的地方，传入的参数所代表的实体拥有Page属性
	private String pageStr;		//最终页面显示的底部翻页导航，详细见：getPageStr();
	private PageData pd = new PageData();
	
	
	public Page(){
		try {
			this.showCount = Integer.parseInt(Tools.readTxtFile(Const.PAGE));
		} catch (Exception e) {
			this.showCount = 15;
		}
	}
	
	public int getTotalPage() {
		if(totalResult%showCount==0)
			totalPage = totalResult/showCount;
		else
			totalPage = totalResult/showCount+1;
		return totalPage;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	public int getTotalResult() {
		return totalResult;
	}
	
	public void setTotalResult(int totalResult) {
		this.totalResult = totalResult;
	}
	
	public int getCurrentPage() {
		if(currentPage<=0)
			currentPage = 1;
		if(currentPage>getTotalPage())
			currentPage = getTotalPage();
		return currentPage;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public String getPageStr() {
		StringBuffer sb = new StringBuffer();
		if(totalResult>0){
			sb.append("<div class=\"pull-right\">");
			if(currentPage==1){
				sb.append("<span class=\"total-page\">每页"+showCount+"条，共"+totalResult+"条</span>");
				sb.append(" <select  onchange=\"changeCount(this,value)\">\n");
				sb.append("	<option value='"+showCount+"'>"+showCount+"</option>\n");
				sb.append("	<option value='10'>10</option>\n");
				sb.append("	<option value='20'>20</option>\n");          
				sb.append("	</select>\n");
				sb.append("<span class=\"first-page\">首页</span>");
				sb.append(" <img src=\"static/assetsNew/css/images/icon-22.png\" width=\"10\" height=\"13\">");
				sb.append("<input class=\"input-page-number\" type=\"text\" readonly='true'  value='"+currentPage+"'   aria-label=\"页码输入框\">");
			}else{
				sb.append("<span class=\"total-page\">每页"+showCount+"条，共"+totalResult+"条</span>");
				sb.append(" <select onchange=\"changeCount(this,value)\">\n");
				sb.append("	<option value='"+showCount+"'>"+showCount+"</option>\n");
				sb.append("	<option value='10'>10</option>\n");
				sb.append("	<option value='20'>20</option>\n");          
				sb.append("	</select>\n");
				sb.append("<span style=\"cursor:pointer;\"  class=\"first-page\" onclick=\"nextPage(this,1)\">首页</span>");
				sb.append(" <img style=\"cursor:pointer;\" src=\"static/assetsNew/css/images/icon-22.png\" width=\"10\" height=\"13\"  onclick=\"nextPage(this,"+(currentPage-1)+")\">");
				sb.append("<input class=\"input-page-number\"  type=\"text\" readonly='true'  value='"+currentPage+"'  min=\"1\" aria-label=\"页码输入框\">");
			}
			//如果总页数就一页
			if(currentPage==totalPage){
				sb.append("<img src=\"static/assetsNew/css/images/icon-21.png\" width=\"10\" height=\"13\">");
                sb.append("<span>尾页</span>");
			}else{
				sb.append("<img style=\"cursor:pointer;\" src=\"static/assetsNew/css/images/icon-21.png\" width=\"10\" height=\"13\" onclick=\"nextPage(this,"+(currentPage+1)+")\">");
                sb.append("<span style=\"cursor:pointer;\" onclick=\"nextPage(this,"+totalPage+")\">尾页</span>");
			}
			
			sb.append("<input type=\"number\"  id=\"toGoPage\" min='1' /></li>\n");
			sb.append("<img src=\"static/assetsNew/css/images/icon-23.png\" width=\"15\" height=\"13\" onclick=\"toTZ(this);\">");
			sb.append("</div>");
	 
		
			sb.append("<script type=\"text/javascript\">\n");
			//换页函数
			sb.append("function nextPage(obj,page){\n");
			sb.append("		var reqstr = getParamJson(obj);\n");
			sb.append("	   if(reqstr!=\"\"){");
			sb.append("		 reqstr = reqstr.substring(0,reqstr.length-1);\n");
			sb.append("       reqstr +=\",currentPage:'\"+page+\"'}\";\n ");
			sb.append("       }\n");
			sb.append("    if(reqstr!=\"\"){\n");
			sb.append("          reqstr = strToJson(reqstr);\n");
			sb.append("      }\n");
			sb.append("      ajaxQuery(reqstr);\n");
			sb.append(" };\n");
			
			
			//调整每页显示条数
			sb.append("function changeCount(obj,value){");
			sb.append("		var reqstr = getParamJson(obj);\n");
			sb.append("	   if(reqstr!=\"\"){");
			sb.append("		 reqstr = reqstr.substring(0,reqstr.length-1);\n");
			sb.append("       reqstr +=\",currentPage:'1',showCount:'\"+value+\"'}\";\n ");
			sb.append("       }\n");
			sb.append("    if(reqstr!=\"\"){\n");
			sb.append("          reqstr = strToJson(reqstr);\n");
			sb.append("      }\n");
			sb.append("      ajaxQuery(reqstr);\n");
			sb.append("}\n");
			
			//跳转函数 
			sb.append("function toTZ(obj){");
			sb.append("var toPaggeVlue = document.getElementById(\"toGoPage\").value;");
			sb.append("if(toPaggeVlue == ''){document.getElementById(\"toGoPage\").value=1;return;}");
			sb.append("if(isNaN(Number(toPaggeVlue))){document.getElementById(\"toGoPage\").value=1;return;}");
			sb.append("nextPage(obj,toPaggeVlue);");
			sb.append("}\n");
			sb.append("</script>\n");
		}
		pageStr = sb.toString();
		return pageStr;
	}
	
	public void setPageStr(String pageStr) {
		this.pageStr = pageStr;
	}
	
	public int getShowCount() {
		return showCount;
	}
	
	public void setShowCount(int showCount) {
		
		this.showCount = showCount;
	}
	
	public int getCurrentResult() {
		currentResult = (getCurrentPage()-1)*getShowCount();
		if(currentResult<0)
			currentResult = 0;
		return currentResult;
	}
	
	public void setCurrentResult(int currentResult) {
		this.currentResult = currentResult;
	}
	
	public boolean isEntityOrField() {
		return entityOrField;
	}
	
	public void setEntityOrField(boolean entityOrField) {
		this.entityOrField = entityOrField;
	}
	
	public PageData getPd() {
		return pd;
	}

	public void setPd(PageData pd) {
		this.pd = pd;
	}
	
}

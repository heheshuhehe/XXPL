<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 
   <%
    String cp = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp+"/";
%>
	
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href='<%=basePath%>calendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='<%=basePath%>calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <script src='<%=basePath%>calendar/lib/moment.min.js'></script>
    <script src='<%=basePath%>calendar/lib/jquery.min.js'></script>
    <script src='<%=basePath%>calendar/fullcalendar.min.js'></script>
    
    <script src='<%=basePath%>calendar/locale-all.js'></script>
    
<script>
	$(document).ready(function() {
		var initialLocaleCode = 'zh-cn';

		$('#calendar').fullCalendar({
			height:530,
			defaultDate: '2017-09-12',
			editable: false,
			eventLimit: true, // allow "more" link when too many events
			locale: initialLocaleCode,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicDay'
			},
			dayClick: function(date) {
				
				var view =$('#calendar').fullCalendar('getView');

				if(view.name=='month'){
				$('#calendar').fullCalendar('changeView','basicDay',date);
			
				
				};
			},
			viewRender : function(view,element){//在视图被渲染时触发（切换视图也触发） 参数view为视图对象，参数element为Jquery的视图Dom

             	 if(view.name=='month'){
            		
            		 var datasss='';
            		

            	 }else if(view.name=='basicDay'){
            		 $.ajax({url:'<%=basePath%>guzhidz/getfundOpeninfodetail',dataType:'text',success:function(data){
            			
 						
            		 }
            		 });
            	 } 
               
             } , 
             
     		eventOrder:function(e1,e2){
     			 var n1=parseInt( e1.id);
     			 var n2=parseInt( e2.id);
     			 if(n1>n2)
     				 return 1;
     				 else return -1;
     		},
			events: {
				url: '<%=basePath%>guzhidz/getfundOpeninfodetail',
				error: function() {
					$('#script-warning').show();
				}
		}
             
		});

		
	});

</script>
<style>

	body {
		margin: 40px 0px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>
</head>
<body>

<div id='calendar'  style="" ></div>
</body>

</html>






<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DesignReport.aspx.cs" Inherits="DesignReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>应用报表设计器设计报表</title>
	<script src="../JavaScript/CreateControl.js" language="javascript" type="text/javascript"></script>
    <style type="text/css">
        html,body {
            margin:0;
            height:100%;
        }
    </style>
</head>
<script language="JavaScript" FOR="ReportDesigner" EVENT="SaveReport()"  type="text/javascript">
<!--
	//alert("为了保护报表的正常演示，这里放弃了对报表设计的保存！");
	//ReportDesigner.DefaultAction = false;
-->
</script>
<body style="margin:0">
	<script language="javascript" type="text/javascript"> 
	    CreateDesigner("../GridReport/<%=Request.QueryString["Report"]%>", "DesignReportSave.aspx?Report=<%=Request.QueryString["Report"]%>", "<%=Request.QueryString["data"]%>");
	    //CreateDesigner("post::ReadReport.aspx?Report=<%=Request.QueryString["Report"]%>", "DesignReportSave.aspx?Report=<%=Request.QueryString["Report"]%>", "<%=Request.QueryString["data"]%>");
	</script>
</body>
</html>
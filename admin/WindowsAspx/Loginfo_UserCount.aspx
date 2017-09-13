<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Loginfo_UserCount.aspx.cs" Inherits="WindowsAspx_Loginfo_UserCount" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>按用户访问情况查询</title>
     <script src="../scripts/boot.js" type="text/javascript"></script>
     <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;
    } 
        </style>  
</head>
<body>
 <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
              <a class="mini-button" iconCls="icon-close" onClick="CloseWindow()" plain="true">关闭</a>
 </div>
    <div class="mini-fit" >
    <div id="datagrid1" class="mini-datagrid" allowresize="true" style="width:100%;height:100%;" 
        url="AspxDate.aspx?method=getUserLoginfo" idfield="CZSJ" multiselect="true" sizeList=[50,100,300,500] pagesize="50" allowAlternating="true" showColumnsMenu="true">
        <div property="columns">
            <div field="ZH" width="100" allowsort="true" headerAlign = "center">
                登录账号</div>
            <div field="XX" width="120" allowsort="true" headerAlign = "center">
                登录信息</div>
            <div field="TS" width="120" allowsort="true" headerAlign = "center">
                访问次数</div>
        </div>
    </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    grid.load();
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
     </script>
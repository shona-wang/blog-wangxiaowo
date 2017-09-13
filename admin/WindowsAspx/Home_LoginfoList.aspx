<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home_LoginfoList.aspx.cs" Inherits="WindowsAspx_Home_LoginfoList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="../scripts/boot.js" type="text/javascript"></script>
     <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;
    } 
        </style> 
</head>
<body>
    <div class="mini-fit" >
    <div id="datagrid1" class="mini-datagrid" allowresize="false" showPager="false" style="width:100%;height:100%;" 
        url="AspxDate.aspx?method=LoginfoGet" idfield="CZSJ" multiselect="true" sizeList=[50,100,300,500] pagesize="50" allowAlternating="true" showColumnsMenu="true">
        <div property="columns">
          <div field="XX" width="100" allowsort="true">
                操作账户</div>
            <div field="CZBZ" width="120" allowsort="true">
                操作动作</div> 
            <div field="CZSJ" width="120" allowsort="true" dateFormat="yyyy-MM-dd">
                操作日期</div>
        </div>
    </div>
    </div>
    <div style="width:100%; text-align:right; height:20px;"><a href="#" onclick="Dispose()" style="text-decoration: none;">更多...</a></div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    grid.load();
    grid.sortBy("CZSJ", "desc");
    function Dispose() {
        var winMenu = top["winMenu"];
        var Dm_Url = "Loginfo_Edit.aspx?";
        var tab = { powerid: '250507', text: '最新文件', Url: Dm_Url, icon: 'icon-edit' };  //首先模拟一个tab
        winMenu.AddshowTab(tab);
    }
</script>
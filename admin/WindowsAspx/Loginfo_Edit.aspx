<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Loginfo_Edit.aspx.cs" Inherits="WindowsAspx_Loginfo_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>操作日志管理</title>
    
    <script src="../scripts/boot.js" type="text/javascript"></script>
     <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;
    } 
        </style>  
</head>
<body>
        <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
            开始日期:
                        <input id="K_Date" class="mini-datepicker"  style="width: 150px;" format"yyyy-MM-dd" allowInput="false"/>
                        至<input id="J_Date" class="mini-datepicker"  style="width: 150px;" format="yyyy-MM-dd" allowInput="false"/>
                        <a class="mini-button" onclick="search()" plain="true">查询</a>
                          <span class="separator"></span>
                         <a class="mini-button" iconcls="icon-remove" onclick="removeDel()" plain="true">删除</a>
                          <span class="separator"></span>
                        <a class="mini-button" iconCls="icon-close" onClick="CloseWindow()" plain="true">关闭</a> 
        </div>
    <div class="mini-fit" >
    <div id="datagrid1" class="mini-datagrid" allowresize="true" style="width:100%;height:100%;" 
        url="AspxDate.aspx?method=LoginfoGet" idfield="CZSJ" multiselect="true" pagesize="50" allowAlternating="true" showColumnsMenu="true">
        <div property="columns">
          <div field="XX" width="100" allowsort="true" headerAlign = "center">
                操作账户</div>
            <div field="IP" width="120" allowsort="true" headerAlign = "center">
                Ip</div>
            <div field="MAC" width="120" allowsort="true" headerAlign = "center">
                MAC</div>
            <div field="CZBZ" width="120" allowsort="true" headerAlign = "center">
                操作动作</div>
              <div field="CZGN" width="120" allowsort="true" headerAlign = "center">
                操作信息</div>  
            <div field="CZSJ" width="120" allowsort="true" dateFormat="yyyy-MM-dd" headerAlign = "center">
                操作日期</div>
            <div field="MinName" width="120" allowsort="true" headerAlign = "center">
                调用函数</div>
        </div>
    </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    grid.load();
    grid.sortBy("CZSJ", "desc");

    function search() {
        var K_Date = mini.get("K_Date").getFormValue();
        var J_Date = mini.get("J_Date").getFormValue();
        grid.load({ KDate: K_Date, JDate: J_Date });
    }
    function removeDel() {
        var K_Date = mini.get("K_Date").getFormValue();
        var J_Date = mini.get("J_Date").getFormValue();
        if (K_Date != "" && J_Date != "") {
            if (K_Date < J_Date) {
                mini.confirm("确定删除时间段记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=LoginfoDel&KDate=" + K_Date + "&JDate=" + J_Date,
                        success: function(text) {
                            var o = mini.decode(text);
                            var cou = o.messageid;
                            if (o.messageid >= 0) {

                            } else {
                                mini.alert("删除失败,请查看日志信息!");
                            }
                            search();
                        },
                        error: function() {
                        }
                    });
                }
            });
            }
            else {
                mini.alert("开始日期不能大于截止日期!");
            }
        }
        else {
            mini.alert("开始日期与截止日期不能为空!");
        }
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
     </script>
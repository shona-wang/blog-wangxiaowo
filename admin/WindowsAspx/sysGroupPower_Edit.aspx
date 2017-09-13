<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysGroupPower_Edit.aspx.cs" Inherits="WindowsAspx_sysGroupPower_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>权限设置</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>
    <style type="text/css">
        html, body
        {
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: visible;
        }
    </style>
</head>
<body>
   <div class="mini-toolbar" style="text-align:left;" borderstyle="border-left:0;border-top:0;border-right:0;">
        <a class="mini-button" iconCls="icon-save" onclick="saveData()" plain="true">保存</a>
        <a class="mini-button" iconCls="icon-cancel" onclick="CloseWindow()" plain="true">关闭</a>
        <input id="RoleID" name="RoleID" class="mini-hidden"/>
    </div>
    <div class="mini-fit">
       
         <ul id="tree1" class="mini-tree"   style="width: 200px; padding: 5px;"
        showTreeIcon="true" textField="powertext" idField="powerid" parentField="parentid" resultAsTree="false"  
        allowSelect="false" enableHotTrack="false" expandOnLoad="true"
        showCheckBox="true" checkRecursive="false" autoCheckParent="true">
        </ul>
    </div>
    
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    function SetData(data) {
        tree.load("AspxDate.aspx?method=sysGroupPowerGet&RoleID=" + data.RoleID);
        var hidden = mini.get("RoleID");
        hidden.setValue(data.RoleID);
        expandAll();
    }
    //展开所有节点
    function expandAll() {
        tree.expandAll();
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    //保存
    function saveData() {
        var CheckNodes = tree.getCheckedNodes();
        var data = tree.getValue();
        var json = mini.encode(data);
        //alert(json);
        //tree.loading("保存中，请稍后......");
        $.ajax({
            url: "AspxDate.aspx?method=sysGroupPowerSave&RoleID=" + mini.get("RoleID").getValue(),
            data: { data: json },
            type: "post",
            success: function(text) {
                var o = mini.decode(text);
                mini.alert(o.messageContent);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
    </script>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysGroupPower_ChaKan.aspx.cs"
    Inherits="WindowsAspx_sysGroupPower_ChaKan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色权限查预览</title>

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
    <div class="mini-fit">
        <%--<ul id="tree1" class="mini-tree" style="width: 200px; padding: 5px;" showtreeicon="true"
            textfield="powertext" idfield="powerid" parentfield="parentid" resultastree="false"
            allowselect="false"  showcheckbox="true" >
        </ul>--%>
         <ul id="tree1" class="mini-tree"   style="width: 200px; padding: 5px;"
         textField="powertext" idField="powerid" parentField="parentid" resultAsTree="false"  
        allowSelect="false" enableHotTrack="false" expandOnLoad="true"
        showCheckBox="true" checkRecursive="false" autoCheckParent="true" checkedField="checked">
        </ul>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    function SetData(data) {
       // debugger;
        tree.load("AspxDate.aspx?method=sysGroupPowerGet&RoleID=" + data.RoleID);
        //var hidden = mini.get("RoleID");
        //hidden.setValue(data.RoleID);
        expandAll();
        
        tree.disable();
    }
    tree.on("beforenodecheck", function(e) {//点击节点事件
        e.cancel = true;//变成只读状态
    });
    //展开所有节点
    function expandAll() {
        tree.expandAll();
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
        
</script>


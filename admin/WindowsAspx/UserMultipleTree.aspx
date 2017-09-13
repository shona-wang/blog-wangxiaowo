<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserMultipleTree.aspx.cs" Inherits="WindowsAspx_UserMultipleTree" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户组织机构多选</title>
       <script src="../scripts/boot.js" type="text/javascript"></script>
         <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
    </style>
</head>
<body>
     <div class="mini-fit">
       
         <ul id="tree1" class="mini-tree"   style="width: 200px; padding: 5px;"
        showTreeIcon="true" textField="BRANCHNAME" idField="JDDM" parentField="FJDDM" resultAsTree="false"  
        allowSelect="false" enableHotTrack="false" expandOnLoad="0" 
        showCheckBox="true" checkRecursive="false" autoCheckParent="true">
        </ul>
    </div>
    <div class="mini-toolbar" style="text-align: center; padding-top: 8px; padding-bottom: 8px;"
        borderstyle="border-left:0;border-bottom:0;border-right:0;">
        <a class="mini-button" style="width: 60px;" onclick="onOk">确定</a> <span style="display: inline-block;
            width: 25px;"></span><a class="mini-button" style="width: 60px;" onclick="onCancel()">
                取消</a>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    tree.load("AspxDate.aspx?method=UserTree");
    //tree.expandLevel(0);
    function GetData() {
        var rows = tree.getCheckedNodes();
        var ids = [], texts = [];
        for (var i = 0, l = rows.length; i < l; i++) {
            var row = rows[i];
            if (row.bz == "Yes") {
                ids.push(row.JDDM);
                texts.push(row.BRANCHNAME);
            }
        }
        var data = {};
        data.yhm = ids.join(",");
        data.xx = texts.join(",");
        return data;
    }
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }

    function onOk() {
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("cancel");
    }
</script>
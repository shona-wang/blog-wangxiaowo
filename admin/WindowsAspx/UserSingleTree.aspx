<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserSingleTree.aspx.cs" Inherits="WindowsAspx_UserSingleTree" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户组织机构单选</title>
      <script src="../scripts/boot.js" type="text/javascript"></script>
         <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
    </style>
</head>
<body>
    <div class="mini-fit">
        <ul id="tree1" class="mini-tree" style="width:100%;height:100%;" 
            showTreeIcon="true" textField="BRANCHNAME" idField="JDDM" parentField="FJDDM" resultAsTree="false"  
            expandOnLoad="1" onnodedblclick="onNodeDblClick" expandOnDblClick="false" 
            >
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
    function GetData() {
        //debugger;
        var node = tree.getSelectedNode();
        if (node.bz == "Yes") {
            var data = {};
            data.yhm = node.JDDM;
            data.xx = node.BRANCHNAME;
            return data;
        }
        else {
            mini.alert("请注意:您只能选择人员！");
        }
    }
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function onNodeDblClick(e) {
        onOk();
    }
    function onOk() {
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("cancel");
    }
</script>
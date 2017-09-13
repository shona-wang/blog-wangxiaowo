<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuIndex.aspx.cs" Inherits="WeiXinAspx_MenuIndex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <div class="mini-splitter" style="width: 100%; height: 100%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" iconfield="IMAGE" url="Menu_Text.txt" style="width: 100%;"
                    showtreeicon="true" textfield="TEXT" idfield="POWERID" parentfield="PARENTID"
                    resultastree="false" onnodeselect="onNodeSelect">
                </ul>
            </div>
        </div>
        <div>
            <iframe src="" id="mainframe"  style="width: 100%; height: 100%;"
                border="0" frameborder="0"></iframe>
        </div>
    </div>
     <input id="WeiXinCode" name="WeiXinCode" class="mini-hidden" />
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var tree = mini.get("tree1");
    $(window).load(function() {
        var Request = new QueryString();
        mini.get("WeiXinCode").setValue(Request["WeiXinCode"]);
      
    });
    tree.expandLevel(0); //展开一级节点
    function onNodeSelect(e) {
        var node = e.node;
        var isLeaf = e.isLeaf;
        var URL = node.URL + "?WeiXinCode=" + mini.get("WeiXinCode").getValue();
        $("#mainframe").attr("src", URL);
    }
</script>


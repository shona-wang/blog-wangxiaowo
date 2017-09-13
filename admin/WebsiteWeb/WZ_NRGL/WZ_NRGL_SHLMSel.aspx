<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_NRGL_SHLMSel.aspx.cs" Inherits="WZ_NRGL_WZ_NRGL_SHLMSel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>栏目选择</title>
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <style type="text/css">
        html, body
        {
            font-size: 12px;
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
     <!--按钮菜单功能-->
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <label for="textbox1$text">栏目名称</label>
                        <input id="key" class="mini-textbox" emptyText="请输入栏目信息" style="width:150px;" onenter="onKeyEnter"/>
                        <a class="mini-button" onclick="search()">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
         <div class="mini-fit">
             <ul id="tree1" class="mini-tree" url="../WZ_DealData/DataProcess.aspx?method=LoadSHLMListTree" style="width:100%;height:100%;" 
            showTreeIcon="true" textField="LMMC" idField="LMBH" parentField="FLMBH" resultAsTree="false"  
            expandOnLoad="false" onnodedblclick="onNodeDblClick" expandOnDblClick="false" 
            >
        </ul>
          </div> 
                         
            <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
            <a class="mini-button" style="width:60px;" onclick="onOk()">确定</a>
            <span style="display:inline-block;width:25px;"></span>
            <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
            </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    tree.expandLevel(0); //展开一级节点
    function GetData() {
        var node = tree.getSelectedNode();
        return node;
    }
    function search() {
        var key = mini.get("key").getValue();
        if (key == "") {
            tree.clearFilter();
        } else {
            key = key.toLowerCase();
            tree.filter(function(node) {
                var text = node.xx ? node.xx.toLowerCase() : "";
                if (text.indexOf(key) != -1) {
                    return true;
                }
            });
        }
    }
    function onKeyEnter(e) {
        search();
    }
    function onNodeDblClick(e) {
        onOk();
    }
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function onOk() {
        var node = tree.getSelectedNode();
//        if (node && tree.isLeaf(node) == false) {
//            alert("不能选中父节点");
//            return;
//        }
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("cancel");
    }
</script>
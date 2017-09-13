<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_NRGL_LR.aspx.cs" Inherits="WZ_NRGL_WZ_NRGL_LR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网站文章管理</title>

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
    <div class="mini-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0;">
        <a class="mini-button" iconcls="icon-add" plain="true" onclick="add()">新增</a><span
            class="separator"></span> <a class="mini-button" iconcls="icon-edit" plain="true"
                onclick="edit()">修改</a><span class="separator"></span> <a class="mini-button" iconcls="icon-reload"
                    plain="true" onclick="show()">刷新</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
            plain="true">关闭</a>
    </div>
    <div class="mini-splitter" style="width: 100%; height: 94%;">
        <div size="20%" showcollapsebutton="true" style="padding: 1px;">
            <div class="mini-toolbar" style="padding: 1px; border-top: 0; border-left: 0; border-right: 0;">
                <a class="mini-button" iconcls="icon-reload" plain="true" onclick="refreshNode()">刷新</a>
                <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()">
                    展开</a> <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()">
                        折叠</a>
            </div>
            <div class="mini-fit">
                <!--树-->
                <ul id="tree1" class="mini-tree" url="../WZ_DealData/DataProcess.aspx?method=LoadLMTree_NRGL"
                    style="width: 100%; height: 100%; padding: 5px;" showtreeicon="true" resultastree="false"
                    textfield="LMMC" idfield="LMBH" parentfield="FLMBH" expandonload="0" onbeforeload="onBeforeTreeLoad"
                    allowdrag="false" allowdrop="false" allowleafdropin="false">
                </ul>
            </div>
        </div>
        <div class="mini-fit">
            <div id="grid1" class="mini-datagrid" idfield="XWBH" style="width: 100%; height: 100%;"
                borderstyle="border:0;" url="../WZ_DealData/DataProcess.aspx?method=GetDocInfo"
                multiselect="false">
                <div property="columns">
                    <div type="checkcolumn">
                    </div>
                    <div field="XWZBT" width="120" headeralign="center" allowsort="true">
                        主标题</div>
                    <div field="LMMC" width="120" headeralign="center" allowsort="true">
                        栏目名称</div>
                    <div field="XWFBZ" width="120" headeralign="center" allowsort="true">
                        发布者</div>
                    <div field="CJSJ" width="120" headeralign="center" allowsort="true" dateformat="yyyy-MM-dd">
                        撰写时间</div>
                           <div field="ZY" width="120" headeralign="center" allowsort="true">
                        摘要</div>
                    <div field="LMBH" width="120" headeralign="center" allowsort="true" visible="false">
                        栏目编号</div>
                 
                    <%--<div field="XWBH" width="120" headerAlign="center" allowSort="true" visible="false">新闻编号</div>
                        <div field="AccountNum" width="120" headerAlign="center" allowSort="true" visible="false">AccountNum</div>      --%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    /*--查询--*/
    var tree = mini.get("tree1");
    var grid = mini.get("grid1");
    grid.load();
    tree.on("nodeselect", function(e) {
        var tree = e.sender;
        var node = e.node;
        grid.load({ LMBH: node.LMBH });
    });
    function onKeyEnter(e) {
        search();
    }
    function onBeforeTreeLoad(e) {
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        //可以传递自定义的属性
        params.myField = node.LMBH; //后台：request对象获取"myField"
    }
    /*--刷新节点--*/
    function refreshNode() {
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        if (node) {
            tree.loadNode(node);
        }
    }
    function onBeforeOpen(e) {
        var menu = e.sender;
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        if (!node) {
            e.cancel = true;
            return;
        }
    }
    /*--按钮事件--*/
    function add() {
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        if (!node || node.FLMBH == "0") {
            mini.alert("根节点不能添加内容!");
            return;
        }
        mini.open({
            url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_LR_AM.aspx",
            title: "新增文档", width: 860, height: 550,
            onload: function() {
                var iframe = this.getIFrameEl();
                if (!node || node.FLMBH == "0") { //没有选中节点
                    return;
                }
                else {
                    var data = { action: "new", LMBH: node.LMBH, LMMC: node.LMMC };
                }
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.load({ LMBH: node.LMBH });
            }
        });
    }
    function edit() {
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_LR_AM.aspx",
                title: "修改文档", width: 860, height: 550,
                onload: function() {
                    // debugger;
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", XWBH: row.XWBH };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    if (node) {
                        grid.load({ LMBH: node.LMBH });
                    }
                    else {
                        grid.load({ LMBH: "" });
                    }
                }
            });
        }
        else {
            mini.alert("请选择要编辑的记录!");
        }
    }
    function show() {
        grid.load({ LMBH: "" });
    }
    function expandLevel() {
        tree.expandAll();
    }
    function collapseLevel() {
        tree.collapseLevel(1);
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


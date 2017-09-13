<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_LMGL_LMWH.aspx.cs" Inherits="WZ_LMGL_WZ_LMGL_LMWH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网站栏目信息维护</title>

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
                onclick="edit()">修改</a><span class="separator"></span> <a class="mini-button" iconcls="icon-remove"
                    plain="true" onclick="del()">删除</a><span class="separator"></span> <a id="sy" class="mini-button"
                        iconcls="icon-upload" onclick="moveUp" plain="true">上移</a> <span class="separator">
        </span><a id="xy" class="mini-button" iconcls="icon-download" onclick="moveDown"
            plain="true">下移</a>
            <span class="separator">
        </span><a id="px" class="mini-button" iconcls="icon-save" plain="true" onclick="SaveDataOrder()">排序保存</a> 
         <span class="separator">
                        </span>
                        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">
                            关闭</a>
    </div>
    <div class="mini-splitter" style="width: 100%; height: 97%;">
        <div size="20%" showcollapsebutton="true" style="padding:1px;">
            <div class="mini-toolbar" style="padding: 0px; border-top: 0; border-left: 0; border-right: 0;">
                <a class="mini-button" iconcls="icon-reload" plain="true" onclick="refreshNode()">刷新</a>
                  <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()" >展开</a>
                     <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()" >折叠</a>
            </div>
            <div class="mini-fit">
                <!--树-->
                <ul id="tree1" class="mini-tree" url="../WZ_DealData/DataProcess.aspx?method=LoadLMTree"
                    style="width: 100%; height: 100%; padding: 5px;" showtreeicon="true" resultastree="false"
                    textfield="LMMC" idfield="LMBH" parentfield="FLMBH" expandonload="0" onbeforeload="onBeforeTreeLoad"
                    allowdrag="false" allowdrop="false" allowleafdropin="false">
                </ul>
            </div>
        </div>
        <div class="mini-fit">
            <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                url="../WZ_DealData/DataProcess.aspx?method=GetLMInfo" multiselect="false" idfield="LMBH"
                sizeList=[50,100,300,500] pagesize="50">
                <div property="columns">
                    <div type="checkcolumn">
                    </div>
                    <div field="AccountNum" width="120" headeralign="center" allowsort="true" visible="false">
                        AccountNum</div>
                    <div field="LMBH" width="120" headeralign="center" allowsort="true">
                        栏目编号</div>
                    <div field="FLMBH" width="120" headeralign="center" allowsort="true" visible="false">
                        FLMBH</div>
                    <div field="LMXH" width="120" headeralign="center" allowsort="true">
                        栏目序号</div>
                    <div field="LMMC" width="120" headeralign="center" allowsort="true">
                        栏目名称</div>
                    <div field="SFYC" width="120" headeralign="center" allowsort="true">
                        是否导航</div>
                    <div field="ZTBZ" width="120" headeralign="center" allowsort="true">
                        是否专题</div>
                    <div field="TZDZ" width="120" headeralign="center" allowsort="true">
                        跳转地址</div>
                    <div field="DYMB" width="120" headeralign="center" allowsort="true" visible="false">
                        调用模板</div>
                    <div field="SFJT" width="120" headeralign="center" allowsort="true" visible="false">
                        是否静态化</div>
                    <div field="DelBS" width="120" headeralign="center" allowsort="true" visible="false">
                        DelBS</div>
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
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    tree.selectNode(node); //选中第一个根节点
    var grid = mini.get("grid1");
    grid.load({ LMBH: node.LMBH });
    tree.on("nodeselect", function(e) {
        if (e.isLeaf) {//子节点：子节点不检索
            grid.setData([]);
            grid.setTotalCount(0);
        }
        else {
            var tree = e.sender;
            var node = e.node;
            grid.load({ LMBH: node.LMBH });
        }
    });
    grid.on("drawcell", function(e) {
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
        if (field == "SFYC") {//是否导航
            if (value == 1) {
                e.cellHtml = "是";
            } else {
                e.cellHtml = "否";
            }
        }
        if (field == "ZTBZ") {//是否专题
            if (value == 1) {
                e.cellHtml = "是";
            } else {
                e.cellHtml = "否";
            }
        }

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
        mini.open({
            url: "../WebsiteWeb/WZ_LMGL/WZ_LMGL_LMWH_AM.aspx",
            title: "新增网站栏目", width: 580, height: 250,
            onload: function() {
                var iframe = this.getIFrameEl();
                if (!node) { //没有选中节点
                    var data = { action: "new", FLMBH: "01", FLMMC: "栏目树" };
                }
                else {
                    var data = { action: "new", FLMBH: node.LMBH, FLMMC: node.LMMC };
                }
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.load({ LMBH: "01" });
            }
        });
    }
    function edit() {
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "../WebsiteWeb/WZ_LMGL/WZ_LMGL_LMWH_AM.aspx",
                title: "修改网站栏目", width: 580, height: 250,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    if (!node) {
                        var data = { action: "edit", LMBH: row.LMBH };
                    }
                    else {
                        var data = { action: "edit", FLMBH: node.LMBH, FLMMC: node.LMMC, LMBH: row.LMBH };
                    }
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    grid.load({ LMBH: "01" });
                }
            });
        }
        else {
            mini.alert("请先选中要编辑的记录!");
        }
    }
    function show() {
        grid.load({ LMBH: "" });
    }
    function del() {
        //debugger;
        var tree = mini.get("tree1");
        var node = tree.getSelectedNode();
        var row = grid.getSelected();
        var lmbh = row.FLMBH;
        if (lmbh == "0") {
            alert("顶级节点不能删除!");
            return;
        }
        if (row) {
            mini.confirm("确定要删除选中的记录吗?", "确定?",
            function(action) {
                if (action == "ok") {
                    //grid.loading("操作中,请稍后……");
                    //先判断此栏目是否有子栏目如果有子栏目不能删除
                    $.ajax({
                        url: "../WZ_DealData/DataProcess.aspx?method=FindZLMCount&LMBH=" + row.LMBH,
                        success: function(text) {
                            if (text == "0") { //没有子栏目
                                $.ajax({
                                    url: "../WZ_DealData/DataProcess.aspx?method=DelLMInfo&LMBH=" + row.LMBH,
                                    success: function(text) {
                                        var mes = mini.decode(text);
                                        if (mes.messageid > 0) {
                                            mini.alert("删除成功!");
                                        }
                                        else {
                                            mini.alert("删除失败!");
                                        }
                                        grid.load({ LMBH: node.LMBH });
                                    }
                                })
                            }
                            else {
                                mini.alert("栏目下含有子栏目不能删除!");
                            }
                            grid.load({ LMBH: node.LMBH });
                        }
                    })
                }
            });
        }
        else {
            alert("请选择要删除的记录!");
        }
    }
    function moveUp() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index - 1);
        }
    }
    function moveDown() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);

            grid.moveRow(row, index + 2);
        }
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
    function SaveDataOrder() {
        var GridData = grid.getData();
        var GridJson = mini.encode(GridData);
        grid.loading("保存中，请稍后......");
        $.ajax({
        url: "../WZ_DealData/DataProcess.aspx?method=OrderSave",
            data: { data: GridJson },
            type: "post",
            success: function(text) {
                if (text != -1) {
                    grid.reload();

                }
                else {
                    mini.alert("数据操作出现问题!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
</script>


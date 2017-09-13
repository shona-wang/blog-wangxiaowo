<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_LMQX_LMWH.aspx.cs" Inherits="WZ_LMQX_WZ_LMQX_LMWH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>栏目权限</title>

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
        <a class="mini-button" iconcls="icon-save" plain="true" onclick="saveNodeQX()">保存</a><span class="separator">
            </span>
        <a class="mini-button" iconcls="icon-ok" plain="true" onclick="all()">全选</a> <span class="separator">
            </span><a class="mini-button"
            iconcls="icon-redo" plain="true" onclick="cancel()">取消全选</a> <span class="separator">
            </span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">
                关闭</a>
    </div>
    <div class="mini-splitter" style="width: 100%; height: 94%;">
        <div size="20%" showcollapsebutton="true" style="padding: 1px;">
            <div class="mini-fit">
                <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                    url="../WZ_DealData/DataProcess.aspx?method=GetRYInfo" multiselect="false" idfield="YHM" sizeList=[50,100,300,500] pagesize="50"
                    onrowclick="rowclick1">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <%-- <div field="AccountNum" width="120" headerAlign="center" allowSort="true" visible="false">AccountNum</div>      --%>
                        <%--<div field="YHM" width="120" headerAlign="center" allowSort="true" >登录账号</div>--%>
                        <div field="XX" width="120" headeralign="center" allowsort="true">
                            登录人员</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="mini-fit">
            <!--树-->
            <div class="mini-toolbar" style="padding: 12px; border-top: 0; border-left: 0; border-right: 0;">
            </div>
            <ul id="tree1" class="mini-tree" url="../WZ_DealData/DataProcess.aspx?method=LoadLMTree_NRGL"
                style="width: 100%; height: 100%; padding: 5px;" showtreeicon="true" resultastree="false"
                textfield="LMMC" idfield="LMBH" parentfield="FLMBH" expandonload="0" allowdrag="false"
                allowdrop="false" allowleafdropin="false" showcheckbox="true">
            </ul>
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
    tree.load();
    tree.on("nodeselect", function(e) {
        if (e.isLeaf) {//子节点：子节点不检索
        }
        else {
            var tree = e.sender;
            var node = e.node;
        }
    });
    /*--全选--*/
    function all() {
        var tree = mini.get("tree1");
        var nodes = tree.getAllChildNodes(tree.getRootNode());
        tree.checkNodes(nodes);
    }
    /*--取消全选--*/
    function cancel() {
        var tree = mini.get("tree1");
        var nodes = tree.getAllChildNodes(tree.getRootNode());
        tree.uncheckNodes(nodes);
    }
    /*--行选择事件--*/
    function rowclick1(e) {
        debugger;
        var tree = mini.get("tree1");
        var data = e.row;
        var yhm = data.YHM;
        if (yhm) {
            var url = "../WZ_DealData/DataProcess.aspx?method=LoadLMQXTree&yhm=" + yhm;
            tree.load(url);
        }
    }
    /*--按钮事件--*/
    function saveNodeQX() {
        var tree = mini.get("tree1");
        var node = tree.getValue();
        var data = mini.encode([grid.getSelected()]);
        if (data == "[]") {
            return mini.alert("提示:请选择人员！");
        }
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveLMQX",
            data: { data: data, node: node },
            type: "post",
            cache: false,
            success: function(text) {
                //成功
                debugger;
                if (text == "OK") {
                    var tree = mini.get("tree1");
                    var row = grid.getSelected()
                    var yhm = row.YHM;
                    if (yhm) {
                        var url = "../WZ_DealData/DataProcess.aspx?method=LoadLMQXTree&yhm=" + yhm;
                        tree.load(url);
                    }
                    mini.alert("保存成功!");
                }
                else {
                    mini.alert(text);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


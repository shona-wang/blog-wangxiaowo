<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErpDataBase_index.aspx.cs" Inherits="WindowsAspx_ErpDataBase_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>系统数据库操作</title>
      <script src="../scripts/boot.js" type="text/javascript"></script>
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
 <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                 <a id="reload" class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true"
                        >刷新</a> <span class="separator"></span>
                        <a id="del" class="mini-button" iconcls="icon-remove" onclick="del()" plain="true"
                        >删除字段</a> <span class="separator"></span>
                        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
                </td>
               
            </tr>
        </table>
    </div>
 <div class="mini-splitter" style="width: 100%; height: 93%;">
        <div size="250" showcollapsebutton="true">
              <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                     <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()" >刷新</a>
                     <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()" >展开</a>
                     <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()" >折叠</a>
             </div>
            <div class="mini-fit">
                <ul id="tree1" iconfield="IMAGE" class="mini-tree" url="../WindowsAspx/AspxDate.aspx?method=SelectDataBase"
                    style="width: 100%;" showtreeicon="true" textfield="NAME" idfield="PARENTID" parentfield="POWERID"
                    resultastree="false"  contextMenu="#treeMenu">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
                    url="../WindowsAspx/AspxDate.aspx?method=SelectDataBaseField" sizeList=[50,100,300,500] pagesize="100" idfield="字段名"
                    multiselect="true" allowalternating="true" showcolumnsmenu="true">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="字段序号" width="60" allowsort="true" headerAlign = "center">
                            字段序号</div>
                            <div field="字段名" width="120" allowsort="true" headerAlign = "center">
                            字段名</div>
                        <div field="标识" width="40" allowsort="true" headerAlign = "center">
                            标识
                        </div>
                        <div field="主键" width="40" allowsort="true" headerAlign = "center">
                            主键</div>
                        <div field="类型" width="100" allowsort="true" headerAlign = "center">
                            类型</div>
                        <div field="占用字节数" width="70" allowsort="true" headerAlign = "center">
                            占用字节数</div>
                        <div field="长度" width="60" allowsort="true" headerAlign = "center">
                            长度</div>
                        <div field="小数位数" width="70" allowsort="true" headerAlign = "center">
                            小数位数</div>
                        <div field="允许空" width="60" allowsort="true" headerAlign = "center">
                            允许空</div>
                        <div field="默认值" width="60" allowsort="true" headerAlign = "center">
                            默认值</div>
                        <div field="字段说明" width="120" allowsort="true" headerAlign = "center">
                            字段说明</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <ul id="treeMenu" class="mini-contextmenu"  onbeforeopen="onBeforeOpen">        
	<li name="get" iconCls="icon-collapse" onclick="onGetDate">查看表数据</li>
	<li name="add" iconCls="icon-add" onclick="onAddFile">添加表字段</li>        
</ul>
<input id="BM" name="BM" class="mini-hidden" />
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    var grid = mini.get("datagrid1");
    tree.on("nodeselect", function(e) {//点击节点事件
        if (e.node.PARENTID != "01") {
            mini.get("BM").setValue(e.node.NAME);
            grid.load({ TableName: e.node.NAME }); //按节点查询
        }
    });
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    
    function expandLevel() {
        tree.expandAll();
    }
    function collapseLevel() {
        tree.collapseLevel(0);
    }
    function reload() {
        grid.reload();
    }
    function treereload() {
        tree.load("AspxDate.aspx?method=SelectDataBase");
    }
    function onGetDate(e) {
        var node = tree.getSelectedNode();
        var tablename = node.NAME;
        mini.open({
        url: "ErpDataBase_getData_index.aspx?DataTableName="+tablename,
            showMaxButton: false,
            title: "查看数据",
            width: 1100,
            height: 500
        });
    }
    function onAddFile(e) {
        var node = tree.getSelectedNode();
        var tablename = node.NAME;
        mini.open({
        url: "ErpDataBase_Edit.aspx?DataTableName=" + tablename,
        showMaxButton: false,
            title: "["+tablename+"]添加字段",
            width: 350,
            height: 250
        });
    }
    function del() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中字段吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.字段名);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=ColmDel&id=" + id+"&&DataTableName="+ mini.get("BM").getValue(),
                        success: function(text) {
                            mini.alert("操作成功!");
                            grid.reload();
                        },
                        error: function() {
                        }
                    });
                }
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
    function onBeforeOpen(e) {
        var menu = e.sender;

        var node = tree.getSelectedNode();
        if (!node) {
            e.cancel = true;
            return;
        }
        if (node && node.NAME == "DataBaseName") {
            e.cancel = true;
            //阻止浏览器默认右键菜单
            e.htmlEvent.preventDefault();
            return;
        }

        ////////////////////////////////
        var editItem = mini.getbyName("get", menu);
        var removeItem = mini.getbyName("add", menu);
        editItem.show();
        removeItem.enable();

        if (node.id == "forms") {
            editItem.hide();
        }
        if (node.id == "lists") {
            removeItem.disable();
        }
    }
</script>


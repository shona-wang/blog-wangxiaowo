<%@ Page Language="C#" AutoEventWireup="true" CodeFile="column_content.aspx.cs" Inherits="cms_column_column_content" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>栏目内容维护</title>
    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

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
                    <a id="add" class="mini-button" iconcls="icon-add" plain="true" onclick="addRow()"
                        >增加</a> <span class="separator"></span><a id="edit" class="mini-button"
                            iconcls="icon-edit" plain="true" onclick="edit()">编辑</a>
                    <span class="separator"></span><a id="del" class="mini-button" iconcls="icon-remove"
                        plain="true" onclick="removeRow()" >删除</a> <span class="separator">
                    </span><a class="mini-button" iconcls="icon-close"
                            onclick="CloseWindow()" plain="true">关闭</a>
                </td>
            </tr>
        </table>
    </div>
 <div class="mini-splitter" style="width: 100%; height: 94%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" iconfield="IMAGE" url="../service/column.aspx?method=tree_query"
                   style="width: 100%; height:100%" showtreeicon="true" textfield="name" valuefield="id" idfield="id" parentfield="pid"
                    resultastree="false">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                    url="../service/column_content.aspx?method=query" showfilterrow="false" allowcellselect="true"
                    pagesize="20" allowcelledit="true" multiselect="true" allowalternating="true"
                    showcolumnsmenu="true">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="id" width="120" headeralign="center" allowsort="true" visible = "false">
                            栏目编号
                        </div>
                        <div field="name" width="120" headeralign="center" allowsort="true">
                            名称
                        </div>
                        <div field="title" width="120" headeralign="center" allowsort="true">
                            内容主标题
                        </div>
                        <div field="status" renderer="onGenderRenderer" width="120" headeralign="center" allowsort="true" >
                            状态
                        </div>
                        <div field="ctime" width="120" headeralign="center" allowsort="true" dateformat = "yyyy-MM-dd">
                            创建时间
                        </div>
                          <div field="creator" width="120" headeralign="center" allowsort="true">
                            创建人
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
//    $(window).load(function() {
//        var Request = new QueryString();
//        ButtonRoles(Request["MenuBh"]);
//    })
//    function ButtonRoles(MenuBh) {

//        //按钮权限管理
//        var ButtonObject;
//        var add = mini.get("add");
//        var edit = mini.get("edit");
//        var del = mini.get("del");
//        $.ajax({
//            url: "../WindowsAspx/AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
//            success: function(text) {
//                debugger;
//                ButtonObject = mini.decode(text);
//                for (var i = 0; i < ButtonObject.length; i++) {
//                    var zt = true;
//                    if (ButtonObject[i].ZT == "flase") {
//                        zt = false;
//                    }
//                    if (add.getText() == ButtonObject[i].POWERTEXT) {
//                        add.setEnabled(zt);
//                    }
//                    if (edit.getText() == ButtonObject[i].POWERTEXT) {
//                        edit.setEnabled(zt);
//                    }
//                    if (del.getText() == ButtonObject[i].POWERTEXT) {
//                        del.setEnabled(zt);
//                    }
//                }
//            },
//            error: function() {
//            }
//        });
//    }
    
    var Genders = [{ id: '0', text: '未发布' }, { id: '1', text: '已发布'}];
    function onGenderRenderer(e) {
        for (var i = 0, l = Genders.length; i < l; i++) {
            var g = Genders[i];
            if (g.id == e.value) return g.text;
        }
        return "";
    }
    var tree = mini.get("tree1");
    var grid = mini.get("grid1");
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    debugger;
    tree.selectNode(node); //选中第一个根节点
    grid.load({ columnid: node.id });

    tree.on("nodeselect", function(e) {
        if (e.node.id != "1") {
            grid.load({ columnid: e.node.id });
        }
        else {
            grid.clearRows();
        }
    });
    tree.expandLevel(0); //展开一级节点


    //新增
    function addRow() {
        debugger;
        var node = tree.getSelectedNode();
        var url = "";
        var height = "";
        var width = "";
        if (node.id == '01') {//主节点下不能新增内容
            return;
        }
        url = "../cms/column/add-column_content.aspx";
        width = "850";
        height = "650";
        mini.open({
            url: url,
            title: "新增栏目内容", width: width, height: height,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "add", columnid: node.id };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }

    //修改
    function edit() {
        debugger;
        var row = grid.getSelected();
        var url = "";
        var height = "";
        var width = "";
        url = "../cms/column/add-column_content.aspx";
        width = "850";
        height = "650";
        if (row) {
            mini.open({
                url: url,
                title: "编辑栏目内容", width: width, height: height,
                onload: function() {
                    debugger;
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", id: row.id};
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                },
                ondestroy: function(action) {
                    grid.reload();
                }
            });
        } else {
            mini.alert("请选择要修改的内容！");
            return;
        }
    }

    //删除
    function removeRow() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.id);
                    }
                    var id = ids.join(',');
                    //grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "../service/column_content_data.aspx?method=deletes&ids=" + id,
                        success: function(text) {
                            if (text == "1") {
                                mini.alert("删除成功！");
                                grid.reload();
                            }
                            else {
                                mini.alert("删除数据出错!"+text);
                            }
                        },
                        error: function() {
                        }
                    });
                }
            });
        } else {
            mini.alert("请选中一条记录!");
        }
    }


    //关闭
    function CloseWindow() {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow();
        else window.close();
    }
</script>
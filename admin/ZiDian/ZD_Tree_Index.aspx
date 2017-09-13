<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZD_Tree_Index.aspx.cs" Inherits="ZiDian_ZD_Tree_Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tree字典示例</title>

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
       <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
        <a id="add" class="mini-button" iconcls="icon-add" onclick="addRow()" plain="true" enabled="false">增加</a>
        <span class="separator"></span><a id="edit" class="mini-button" iconcls="icon-edit" onclick="edit()"
            plain="true" enabled="false">编辑</a> <span class="separator"></span><a id="del" class="mini-button" iconcls="icon-remove"
                onclick="removeRow()" plain="true" enabled="false">删除</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    </div>
    <div id="treegrid1" class="mini-treegrid" style="width: 100%; height: 94%;" url="../WindowsAspx/AspxDate.aspx?method=getTreeData&&YWLX=HYLB"
        showtreeicon="true" treecolumn="taskname" idfield="JDDM" parentfield="FJDDM"
        resultastree="false" allowresize="true" expandonload="true" allowcelledit="true"
        allowcellselect="true" frozenstartcolumn="0" frozenendcolumn="1">
        <div property="columns">
            <div type="indexcolumn">
            </div>
            <div name="taskname" field="JDMC" width="600">
                名称
            </div>
            <div field="DM" width="80">
                代码
            </div>
            <%--<div field="BZ" width="60" align="right">
                备注
            </div>--%>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("treegrid1");
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var add = mini.get("add");
        var edit = mini.get("edit");
        var del = mini.get("del");
        $.ajax({
            url: "../WindowsAspx/AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {
                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (add.getText() == ButtonObject[i].POWERTEXT) {
                        add.setEnabled(zt);
                    }
                    if (edit.getText() == ButtonObject[i].POWERTEXT) {
                        edit.setEnabled(zt);
                    }
                    if (del.getText() == ButtonObject[i].POWERTEXT) {

                        del.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    function addRow() {
        var a = grid.getSelected();
        var JDDM = "",JDMC="";
        if (a != undefined) {
            JDDM = a.JDDM;
            JDMC = a.JDMC;
        }
        mini.open({
        url: "../ZiDian/ZD_Tree_Edit.aspx",
            title: "新增-行业字典", width: 400, height: 180,
            onload: function() {
            var iframe = this.getIFrameEl();
                var data = { action: "Add", YWLX: 'HYLB',JDDM:JDDM,JDMC:JDMC };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }
    //编辑
    function edit() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
            url: "../ZiDian/ZD_Tree_Edit.aspx",
            title: "修改-行业字典", width: 400, height: 180,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", YWLX: 'HYLB', JDDM: row.JDDM };
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                },
                ondestroy: function(action) {
                    grid.reload();
                }
            });

        } else {
            mini.alert("请选中一条记录");
        }
    }
    //删除
    function removeRow() {
        var rows = grid.getSelected();
        if (rows) {
            var a = grid.isLeaf(rows);
            var ts = "";
            if (a == false) {
                ts = "您要删除的节点下面有子节点,将会连同子节点一起删除?";
            } else {
            ts = "确定删除选中记录吗？"
            }
            mini.confirm(ts, "确定？",
            function(action) {
                if (action == "ok") {
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                    url: "../WindowsAspx/AspxDate.aspx?method=KY_ZD_Tree_Delete&&JDDM=" + rows.JDDM + "&&YWLX=HYLB",
                        success: function(text) {
                            if (text > 0) {
                                grid.reload();
                            } else {
                                mini.aler("删除数据出现错误!");
                            }
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
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>
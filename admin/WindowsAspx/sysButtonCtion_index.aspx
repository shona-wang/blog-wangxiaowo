<%@ Page Language="VB" AutoEventWireup="false" CodeFile="sysButtonCtion_index.aspx.vb"
    Inherits="WindowsAspx_sysButtonCtion_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>按钮操作</title>

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
        <a id="add" class="mini-button" iconcls="icon-add" onclick="addRow()" plain="true"
            enabled="false">增加</a> <span class="separator"></span><a id="edit" class="mini-button"
                iconcls="icon-edit" onclick="edit()" plain="true" enabled="false">编辑</a>
        <span class="separator"></span><a id="del" class="mini-button" iconcls="icon-remove"
            onclick="removeRow()" plain="true" enabled="false">删除</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">
            关闭</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height:100%;" url="AspxDate.aspx?method=get_sysButtonCtion"
            idfield="GUID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="BUTTONICONNAME" width="120" headeralign="center" allowsort="true">
                    按钮图标
                </div>
                <div field="BUTTONNAME" width="120" headeralign="center" allowsort="true">
                    按钮名称
                </div>
                <div field="BUTTONTITLE" width="120" headeralign="center" allowsort="true">
                    按钮标题
                </div>
                <div field="BUTTONMIN" width="120" headeralign="center" allowsort="true">
                    执行函数
                </div>
                <div field="BUTTONIREMAK" width="120" headeralign="center" allowsort="true">
                    备注
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    //加载绑定
    mini.parse();
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
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
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
    var grid = mini.get("datagrid1");
    grid.load();
    grid.on("drawcell", function(e) {
        //debugger;
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
        if (column.field == "BUTTONICONNAME") {
            e.cellHtml = "<img src='../scripts/miniui/themes/icons/" + value + "' />";
        }
    });
    //添加
    function addRow() {
        mini.open({
            url: "sysButtonCtion_Edit.aspx",
            title: "新增按钮", width: 350, height: 220,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add" };
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

                url: "sysButtonCtion_Edit.aspx",
                title: "编辑按钮", width: 350, height: 220,
                onload: function() {
                    //debugger;
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", Guid: row.GUID };
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
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.GUID);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=Delete_sysButtonCtion&Guid=" + id,
                        success: function(text) {
                            var o = mini.decode(text);
                            if (o.messageid == -1) {
                                mini.alert(o.messageContent);
                            }
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

    //查询
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SysRoles_User_Index.aspx.cs"
    Inherits="WindowsAspx_SysRoles_User_Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色权限管理</title>

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
        <a id="upqx" class="mini-button" iconcls="icon-unlock" onclick="edit()" plain="true"
            enabled="false">设置权限</a> <span class="separator"></span><a id="upyh" class="mini-button"
                iconcls="icon-unlock" onclick="usersetup()" plain="true" enabled="false">设置用户</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
            plain="true">关闭</a>
        <input id="key" class="mini-textbox" emptytext="请输入角色名称" style="width: 150px;" onenter="onKeyEnter" />
        <a id="cx" class="mini-button" iconcls="icon-search" onclick="search()" plain="true"
            enabled="false">查询</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="ROLEID"
            allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true" allowalternating="true"
            showcolumnsmenu="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    //加载绑定
    mini.parse();
    var grid = mini.get("datagrid1");
    var TableName = "sysRolesDic";
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
        ColumnData();
    });
    grid.setUrl("AspxDate.aspx?method=sysRolesDicindex");
    grid.load({ TableName: TableName });
    function ColumnData() {
        var columns = grid.getColumns();
        var lenght = 0;
        $.ajax({
            url: "../DynamicForm/KY_Modes/KY_ModesData.aspx?method=KY_Modes_Json_getSelectWhere&TableName=" + TableName,
            type: "post",
            success: function(text) {
                var V = mini.decode(text);
                var data = [];
                if (V.length > 0) {
                    for (var i = 0; i < V.length; i++) {
                        data = [];
                        data.field = V[i].KJID;
                        data.header = V[i].KJMS;
                        data.width = 100;
                        data.headerAlign = 'center';
                        data.allowsort = 'true';
                        if (V[i].KJLX == 4) {
                            data.dateFormat = 'yyyy-MM-dd';
                        }
                        lenght = columns.length;
                        columns[lenght] = data;
                    }
                    data = [];
                    data.field = "LRRYXM";
                    data.header = "录入人员姓名";
                    data.width = 100;
                    data.headerAlign = 'center';
                    data.allowsort = "true";
                    lenght = columns.length;
                    columns[lenght] = data;
                    data = [];
                    data.field = "LRSJ";
                    data.header = "录入时间";
                    data.width = 100;
                    data.headerAlign = 'center';
                    data.allowsort = "true";
                    data.dateFormat = "yyyy-MM-dd";
                    lenght = columns.length;
                    columns[lenght] = data;
                    grid.setColumns(columns);
                }
            }
        });
    }
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var upqx = mini.get("upqx");
        var upyh = mini.get("upyh");
        var cx = mini.get("cx");
        $.ajax({
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {

                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (upqx.getText() == ButtonObject[i].POWERTEXT) {
                        upqx.setEnabled(zt);
                    }
                    if (upyh.getText() == ButtonObject[i].POWERTEXT) {
                        upyh.setEnabled(zt);
                    }
                    if (cx.getText() == ButtonObject[i].POWERTEXT) {
                        cx.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    
    //添加
    function addRow() {
        mini.open({
            url: "sysRolesDic_AddEdit.aspx",
            title: "新增角色", width: 300, height: 230,
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
    function addedit() {
        var row = grid.getSelected();
        if (row) {
            mini.open({

                url: "sysRolesDic_AddEdit.aspx",
                title: "编辑角色", width: 300, height: 230,
                onload: function() {
                    //debugger;
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", RoleID: row.RoleID };
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
                        ids.push(r.ROLEID);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=sysRolesDic_Deletes&RoleID=" + id,
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
    //保存
    function saveData() {
        grid.cancelEdit();
        var data = grid.getChanges();
        var json = mini.encode(data);
        grid.loading("保存中，请稍后......");
        $.ajax({
            url: "AspxDate.aspx?method=sysRolesDicSave",
            data: { data: json },
            type: "post",
            success: function(text) {
                var Mes = mini.decode(text);
                if (Mes.messageid == "1") {
                    grid.reload();
                } else {
                    mini.alert(Mes.messageContent);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
    //查询
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    function onKeyEnter() {
        search();
    }

    //设置权限
    //编辑
    function edit() {

        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "sysGroupPower_setup.aspx?RoleID=" + row.ROLEID, //sysGroupPower_Edit.aspx
                title: "设置-[" + row.ROLENAME + "]角色组权限", width: 1000,
                height: 600,
                ondestroy: function(action) {
                    grid.reload();
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
    function usersetup() {
        //
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "sysRolesDic_usersetup.aspx?RoleID=" + row.ROLEID + "&&RoleName=" + row.ROLENAME,
                title: "设置-[" + row.ROLENAME + "]角色组用户", width: 600, height: 500,
                onload: function() {
                },
                ondestroy: function(action) {
                    grid.reload();
                }
            });

        } else {
            mini.alert("请选中一条记录");
        }
    }
</script>


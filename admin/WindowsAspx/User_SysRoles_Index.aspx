﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="User_SysRoles_Index.aspx.cs"
    Inherits="WindowsAspx_User_SysRoles_Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户权限管理</title>

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
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a id="userpl" class="mini-button" iconcls="icon-add" onclick="UserSysRoles()" plain="true"
            enabled="false">用户权限批量设置</a> <span class="separator"></span><a id="userjs" class="mini-button"
                iconcls="icon-user" onclick="sysrolessetup" plain="true" enabled="false">用户角色设置</a>
        <span class="separator"></span><a id="userqx" class="mini-button" iconcls="icon-user"
            onclick="usersysrolessetup" plain="true" enabled="false">用户权限设置</a> <span class="separator">
            </span><a id="userfw" class="mini-button" iconcls="icon-user" onclick="userdatarolessetup"
                plain="true" enabled="false">管理范围设置</a> <span class="separator"></span><a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a> <span class="separator">
                    </span>
        <input id="key" class="mini-textbox" emptytext="请输入姓名" style="width: 150px;" onenter="onKeyEnter" />
        <a id="cx" class="mini-button" iconcls="icon-search" onclick="search()" plain="true"
            enabled="false">查询</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
            url="../WindowsAspx/AspxDate.aspx?method=SearchEmployees" sizeList=[50,100,300,500] pagesize="50" idfield="yhm"
            multiselect="true" allowalternating="true" showcolumnsmenu="true" showfilterrow="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="SRM" width="50" allowsort="true" headerAlign = "center">
                            序号</div>
                        <div field="YHM" width="100" allowsort="true" headerAlign = "center">
                            账号</div>
                            <div field="RELATEDYHM" width="100" allowsort="true" headerAlign = "center">
                            关联账号</div>
                        <div field="XX" width="120" allowsort="true" headerAlign = "center">
                            姓名
                            <input id="nameFilter" property="filter" class="mini-textbox" onvaluechanged="onNameFilterChanged"
                                style="width: 100%;" />
                        </div>
                         <div field="DELETEBS" width="50" allowsort="true" headerAlign = "center">
                            状态</div>
                        <div field="DWMC" width="120" allowsort="true" headerAlign = "center">
                            所属部门</div>
                        <div field="ZWMC" width="120" allowsort="true" headerAlign = "center">
                            职位</div>
                        <div field="ZW" width="120" allowsort="true" headerAlign = "center">
                            手机号</div>
                        <div field="MACID" width="120" allowsort="true" headerAlign = "center">
                            网卡号</div>
                       
                        <div field="SFBD" width="60" allowsort="true" headerAlign = "center">
                            绑定状态</div>
                        <div field="SF" width="60" allowsort="true" headerAlign = "center">
                            是否领导</div>
                        <div field="SF_1" width="60" allowsort="true" headerAlign = "center">
                            首要职位</div>
                        <div field="SF_2" width="70" allowsort="true" headerAlign = "center">
                            领导的主管</div>
                        <div field="SF_3" width="70" allowsort="true" headerAlign = "center">
                            员工的主管</div>
            </div>
        </div>
        <%--   <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
            <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> <span
                class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()"
                    plain="true">编辑</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                        onclick="remove()" plain="true">删除</a> <span class="separator"></span>
            <a class="mini-button" iconcls="icon-unlock" onclick="CshMM" plain="true">设置密码</a>
            <span class="separator"></span><a class="mini-button" iconcls="icon-user" onclick="CshMM"
                plain="true">设置部门</a>
        </div>--%>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var userpl = mini.get("userpl");
        var userjs = mini.get("userjs");
        var userqx = mini.get("userqx");
        var userfw = mini.get("userfw");
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
                    if (userpl.getText() == ButtonObject[i].POWERTEXT) {
                        userpl.setEnabled(zt);
                    }
                    if (userjs.getText() == ButtonObject[i].POWERTEXT) {
                        userjs.setEnabled(zt);
                    }
                    if (userqx.getText() == ButtonObject[i].POWERTEXT) {

                        userqx.setEnabled(zt);
                    }
                    if (userfw.getText() == ButtonObject[i].POWERTEXT) {
                        userfw.setEnabled(zt);
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
    var grid = mini.get("datagrid1");
    grid.load();
    grid.sortBy("Srm", "desc");
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    function onKeyEnter(e) {
        search();
    }
    //删除
    function remove() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.YHM);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=RemoveEmployees&id=" + id,
                        success: function(text) {
                            var o = mini.decode(text);
                            mini.alert(o.messageContent);
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
    //设置密码
    function CshMM(e) {
        var rows = grid.getSelecteds();
        var _width, _height, _url, _tiele;
        if (e.source.text == "设置密码") {
            _tiele = "用户-设置密码";
            _width = 450;
            _height = 200;
            _url = "Pwd_Setup.aspx";
        }
        if (e.source.text == "设置部门") {
            _tiele = "用户-设置部门";
            _width = 450;
            _height = 150;
            _url = "user_Empsetup.aspx";
        }

        if (rows.length > 0) {
            var ids = [];
            var yhs = [];
            for (var i = 0, l = rows.length; i < l; i++) {
                var r = rows[i];
                ids.push(r.YHM);
                yhs.push(r.XX);
            }
            var id = ids.join(',');
            var yh = yhs.join(',');
            mini.open({
                url: _url + "?yhm=" + id + "&&xx=" + yhs,
                title: _tiele,
                width: _width,
                height: _height,
                ondestroy: function(action) {
                }
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
    function sysrolessetup() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "sysRoles_setup.aspx?yhm=" + row.YHM + "&&xx=" + row.XX,
                title: '用户-角色设置',
                width: 650,
                height: 650,
                ondestroy: function(action) {
                }
            });

        } else {
            mini.alert("请选中一条记录");
        }
    }
    //添加
    function add() {
        mini.open({
            url: "UserAddEdit.aspx",
            title: "新增账户", width: 600, height: 300,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "new" };
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
                url: "UserAddEdit.aspx",
                title: "编辑账户", width: 600, height: 300,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", yhm: row.YHM };
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
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function csopen() {
        var row = grid.getSelected();
        if (row) {
            var data = { action: "edit", yhm: row.YHM };
            var tab = { powerid: 'AddEdit', text: '增加', Url: 'aaa.htm?datacation=' + row.YHM, icon: 'icon-edit' };  //首先模拟一个tab
            parent.AddshowTab(tab);

        } else {
            mini.alert("请选中一条记录");
        }
    }
    function onNameFilterChanged(e) {
        var textbox = e.sender;
        var key = textbox.getValue().toLowerCase();
        grid.filter(function(row) {
            var name = String(row.XX).toLowerCase();
            if (name.indexOf(key) != -1) return true;
            return false;
        });
    }
    
    /////////////////////////////////
    function UserSysRoles() {
        mini.open({
            url: "User_SysRoles_setup.aspx",
            title: "用户-批量权限设置",
            width: 1220,
            height: 650
        });
    }
    function usersysrolessetup() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "User_SysRolesPerson_setup.aspx?Userid=" + row.YHM,
                title: row.XX + "-权限设置",
                width: 1000,
                height: 650
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
    function userdatarolessetup() {
        mini.open({
            url: "User_DataRoles_serup.aspx",
            title: "用户数据管理范围设置",
            width: 500,
            height: 650
        });
    }
</script>


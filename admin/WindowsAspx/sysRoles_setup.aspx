<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRoles_setup.aspx.cs" Inherits="WindowsAspx_sysRoles_setup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户-角色设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

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
        <%--<a class="mini-button" iconcls="icon-add" onclick="UserEmpSetUp" plain="true">保存</a>
        <span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="AddSysRoles"
            plain="true">添加角色</a> <span class="separator"></span><a class="mini-button" iconcls="icon-add"
                onclick="RemoveSysRoles" plain="true">移除角色</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-add" onclick="sysRoleidChaKan" plain="true">查看角色权限</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
            plain="true">关闭</a>
        <input id="yhm" name="yhm" class="mini-hidden" />
    </div>
    <div class="mini-fit">
    <span id="spanxx" style="color: Red;"></span>
    <br />
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 95%;" idfield="ROLEID"
            allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true" allowalternating="true"
            showcolumnsmenu="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="ROLENAME" width="120" headeralign="center" allowsort="true">
                    角色名称
                </div>
                <div field="DEACRIPTION" width="120" headeralign="center" allowsort="true">
                    角色描述
                </div>
                <div field="PKID" width="120" headeralign="center" allowsort="true">
                    RolesId
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
    $(window).load(function() {
       //debugger;
        var Request = new QueryString();
        mini.get("yhm").setValue(Request["yhm"]);
       grid.setUrl("AspxDate.aspx?method=sysEmpRoles_xx&&userid=" + mini.get("yhm").getValue());
    grid.load();
    grid.hideColumn(3);
    yhxx(Request["xx"]);
     
    });
    
    function yhxx(xx) {
        $.ajax({
            url: "AspxDate.aspx?method=jszd",
            type: "post",
            data: { Cols: xx },
            success: function(text) {
                $("#spanxx").html("用户为:[" + text + "]");
            },
            error: function() {
            }
        });

    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
       
    }
    function RemoveSysRoles() {
        //debugger;
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定移除选中角色吗？", "确定？",
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
                    url: "AspxDate.aspx?method=Delete_user_sysEmpRoles&RoleID=" + id+"&&userid="+mini.get("yhm").getValue(),
                        success: function(text) {
                            if (text != -1) {
                                grid.reload();
                            }
                            else {
                                mini.alert("数据操作出现问题!");
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
    function AddSysRoles() {
        mini.open({
        url: "sysRolesDic_gridsetpu.aspx?yhm=" + mini.get("yhm").getValue(),
            title: "用户-角色选择",
            width: 650,
            height: 380,
            showCloseButton: false,   //显示关闭按钮
            ondestroy: function(action) {
                if (action == "ok") {
                    grid.reload();
                }
            }
        });
    }
    function sysRoleidChaKan() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
            url: "sysGroupPower_ChaKan.aspx",
                title: "角色权限预览", width: 300, height: 500,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", RoleID: row.ROLEID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    //grid.reload();
                }
            });

        } else {
            alert("请选中一条记录");
        }
    }
</script>


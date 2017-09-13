<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRolesDic_usersetup.aspx.cs"
    Inherits="WindowsAspx_sysRolesDic_usersetup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色用户设置</title>
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
        <a class="mini-button" iconcls="icon-add" onclick="AddSysRolesUser" plain="true">添加用户</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="RemoveSysRolesUser"
            plain="true">移除用户</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a>
        <input id="Roleid" name="Roleid" class="mini-hidden" />
    </div>
   
    <div class="mini-fit">
     <span id="spanxx" style="color: Red;"></span><br />
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height:95%;" allowresize="true"
             sizeList=[50,100,300,500] pagesize="50" idfield="yhm"
            multiselect="true" allowalternating="true" showcolumnsmenu="true" >
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="YHM" width="100" allowsort="true">
                    登录账号</div>
                <div field="XX" width="120" allowsort="true">
                    姓名
                </div>
                <div field="DWMC" width="120" allowsort="true">
                    所属部门</div>
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
        mini.get("Roleid").setValue(Request["RoleID"]);
        grid.setUrl("AspxDate.aspx?method=sysEmpRolesAndUser&&RoleID=" + mini.get("Roleid").getValue());
    grid.load();
    RoleName(Request["RoleName"]);
    });
    function RoleName(xx) {
        $.ajax({
            url: "AspxDate.aspx?method=jszd",
            type: "post",
            data: { Cols: xx },
            success: function(text) {
                $("#spanxx").html("角色为:[" + text + "]");
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
    function RemoveSysRolesUser() {
        //debugger;
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定移除选中用户吗？", "确定？",
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
                    url: "AspxDate.aspx?method=Delete_user_sysEmpRoles&userid=" + id + "&&RoleID=" + mini.get("Roleid").getValue(),
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
    function AddSysRolesUser() {
        mini.open({
        url: "sysRolesDic_addusersetup.aspx?Roleid=" + mini.get("Roleid").getValue(),
            title: "角色-用户设置",
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
                    var data = { action: "edit", RoleID: row.RoleID };
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


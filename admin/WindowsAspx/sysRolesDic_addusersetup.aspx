<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRolesDic_addusersetup.aspx.cs"
    Inherits="WindowsAspx_sysRolesDic_addusersetup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色用户添加</title>

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
        <a class="mini-button" iconcls="icon-add" onclick="EmpSave()" plain="true">确定</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-close" onclick="onCancel()" plain="true">关闭</a>
        <input id="Roleid" name="Roleid" class="mini-hidden" />
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 95%;" allowresize="true"
            sizeList=[50,100,300,500] pagesize="50" idfield="yhm" multiselect="true" allowalternating="true" showcolumnsmenu="true">
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
        mini.get("Roleid").setValue(Request["Roleid"]);
        var Roleid = mini.get("Roleid").getValue();
        grid.setUrl("AspxDate.aspx?method=sysEmpRolesNoAndUser&&Roleid=" + mini.get("Roleid").getValue());
        grid.load();
    });
    function EmpSave() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定添加选择的用户吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.YHM);
                    }
                    var yhm = ids.join(',');
                    //grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=Insert_sysEmpRolesAndUser&RoleID=" + mini.get("Roleid").getValue() + "&&userid=" + yhm,
                        success: function(text) {
                            if (text != -1) {
                                mini.alert("设置成功!", "提示", function() {
                                    grid.reload();
                                }
                                    )

                            }
                            else {
                                mini.aelrt("操作数据出现错误!");
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
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function onOk() {
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("ok");
    }   
</script>


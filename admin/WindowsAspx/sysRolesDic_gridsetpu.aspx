<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRolesDic_gridsetpu.aspx.cs"
    Inherits="WindowsAspx_sysRolesDic_gridsetpu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色设置</title>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        html, body
        {
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a class="mini-button" iconcls="icon-add" onclick="EmpSave()" plain="true">确定</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-close" onclick="onCancel()" plain="true">关闭</a>
        <input id="Roleid" name="Roleid" class="mini-hidden" />
        <input id="yhm" name="yhm" class="mini-hidden" />
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="ROLEID"
            allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="ROLENAME" width="120" headeralign="center" allowsort="true">
                    角色名称
                </div>
                <div field="DEACRIPTION" width="120" headeralign="center" allowsort="true">
                    角色描述
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
        var dd = mini.get("yhm").getValue();
        grid.setUrl("AspxDate.aspx?method=sysEmpRoles_useridxx&&userid=" + mini.get("yhm").getValue());
        grid.load();
    });

    function EmpSave() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定添加选择的角色吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.ROLEID);
                    }
                    var Roleid = ids.join(',');
                    //grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=Insert_sysEmpRoles&RoleID=" + Roleid + "&&userid=" + mini.get("yhm").getValue(),
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
    //查询
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
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


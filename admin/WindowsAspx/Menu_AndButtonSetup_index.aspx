<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Menu_AndButtonSetup_index.aspx.cs" Inherits="WindowsAspx_Menu_AndButtonSetup_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>菜单按钮管理</title>
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
        <a class="mini-button" iconcls="icon-add" onclick="AddButton"
            plain="true">添加按钮</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                onclick="RemoveSysRoles" plain="true">移除按钮</a> 
        <span class="separator"></span>
        <a id="sy" class="mini-button" iconcls="icon-upload" onclick="moveUp"
            plain="true">上移</a>
         <span class="separator"></span>
        <a id="xy" class="mini-button" iconcls="icon-download" onclick="moveDown"
            plain="true">下移</a>
          <span class="separator"></span>
            <a id="bc" class="mini-button" iconcls="icon-save" onclick="SaveData"
            plain="true">保存</a>
        <span class="separator"></span>
        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
            plain="true">关闭</a>
        <input id="parentid" name="parentid" class="mini-hidden" />
    </div> 
    <div class="mini-fit">
   <%--<span id="spanxx" style="color: Red;"></span>
    <br />--%>
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 95%;" idfield="POWERID"
            allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true" allowalternating="true"
            showcolumnsmenu="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="POWERTEXT" width="120" headeralign="center" allowsort="true">
                    按钮名称
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
        mini.get("parentid").setValue(Request["parentid"]);
        grid.setUrl("AspxDate.aspx?method=SelectDisButton&&parentid=" + mini.get("parentid").getValue());
        grid.load();
        //grid.hideColumn(3);
        //yhxx(Request["powertext"]);

    });

    function yhxx(xx) {
        $.ajax({
            url: "AspxDate.aspx?method=jszd",
            type: "post",
            data: { Cols: xx },
            success: function(text) {
                $("#spanxx").html("菜单:[" + text + "]");
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
            mini.confirm("确定移除选中按钮吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.POWERID);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                    url: "AspxDate.aspx?method=DeleteDisButton&Powerids=" + id,
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
    function AddButton() {
        mini.open({
        url: "Menu_AndButtonSetup.aspx?parentid=" + mini.get("parentid").getValue(),
            title: "菜单-按钮选择",
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
    function moveUp() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index - 1);
        }
    }
    function moveDown() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);

            grid.moveRow(row, index + 2);
        }
    }
    function SaveData() {
        var GridData = grid.getData();
        var GridJson = mini.encode(GridData);
        $.ajax({
        url: "AspxDate.aspx?method=UpDisplay_Zb_XuHao&data=" + GridJson,
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
</script>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Positiion_Roles_index.aspx.cs"
    Inherits="WindowsAspx_Positiion_Roles_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>职位权限设置主页面</title>

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
        <a id="upqx" class="mini-button" iconcls="icon-add" onclick="openRoles()" plain="true"
            enabled="false">设置权限</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a> <span class="separator"></span>
        <input id="key" class="mini-textbox" emptytext="请输入职位名称" style="width: 150px;" onenter="onKeyEnter" />
        <a id="cx" class="mini-button" iconcls="icon-search" onclick="search()" plain="true"
            enabled="false">查询</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="ZWID"
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
    var TableName = "TABLE37";
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
        ColumnData();
    });
    grid.setUrl("AspxDate.aspx?method=PositiionGet");
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
                    if (cx.getText() == ButtonObject[i].POWERTEXT) {
                        cx.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
   

    //设置权限
    function openRoles() {
        //debugger;
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "Positiion_Roles_setup.aspx?ZWID=" + row.ZWID,
                title: "设置-[" + row.MC + "]职位权限", width: 1000, height: 600,
                onload: function() {

                },
                ondestroy: function(action) {
                    //grid.reload();
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
    function onKeyEnter() {
        search();
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


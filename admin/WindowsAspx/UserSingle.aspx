﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserSingle.aspx.cs" Inherits="WindowsAspx_UserSingle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户单选-数据范围用户</title>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="text-align: center; line-height: 30px;" borderstyle="border:0;">
        <label>
            名称：</label>
        <input id="key" class="mini-textbox" style="width: 150px;" onenter="onKeyEnter" />
        <a class="mini-button" style="width: 60px;" onclick="search()">查询</a>
    </div>
    <div class="mini-fit">
        <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="yhm"
            allowresize="true" borderstyle="border-left:0;border-right:0;" onrowdblclick="onRowDblClick"
            url="AspxDate.aspx?method=SearchEmployees">
            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div field="YHM" width="100" allowsort="true">
                    登录账号</div>
                <div field="XX" width="120" allowsort="true">
                    姓名</div>
            </div>
        </div>
    </div>
    <div class="mini-toolbar" style="text-align: center; padding-top: 8px; padding-bottom: 8px;"
        borderstyle="border:0;">
        <a class="mini-button" style="width: 60px;" onclick="onOk()">确定</a> <span style="display: inline-block;
            width: 25px;"></span><a class="mini-button" style="width: 60px;" onclick="onCancel()">
                取消</a>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var grid = mini.get("grid1");
    //动态设置URL
    //grid.setUrl("AspxDate.aspx?method=SearchEmployees");
    //也可以动态设置列 grid.setColumns([]);
    grid.load();
    grid.sortBy("Srm", "asc");
    function GetData() {
        var row = grid.getSelected();
        return row;
    }
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    function onKeyEnter(e) {
        search();
    }
    function onRowDblClick(e) {
        onOk();
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
        CloseWindow("cancel");
    }
</script>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GaoJiChaXun.aspx.cs" Inherits="WindowsAspx_GaoJiChaXun" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>高级查询</title>

    <script type="text/javascript" src="../scripts/boot.js"></script>

    <script src="../swfupload/swfupload.js" type="text/javascript"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
        html, body
        {
            font-size: 12px;
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <!--按钮菜单功能-->
    <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <a class="mini-button" iconcls="icon-ok" onclick="save()">确定</a>
                </td>
            </tr>
        </table>
    </div>
    <!--主表-->
    <div class="mini-fit">
        <div id="jhxd_grid" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
            idfield="ID" oncellbeginedit="OnCellBeginEdit" allowcelledit="false" allowcellselect="true"
            multiselect="false" emptytext="数据为空，<a href='javascript:newRow()'>增加一条</a>" showemptytext="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div type="indexcolumn" style="width: 6px;" headeralign="center">
                    序号</div>
                <div field="ID" width="100" headeralign="center" visible="false">
                    ID号</div>
                <div field="field" width="100" headeralign="center">
                    字段<input property="editor" class="mini-combobox" style="width: 100%;" valuefield="field"
                        textfield="header" />
                </div>
                <div field="FH" width="100" headeralign="center">
                    运算标识<input property="editor" class="mini-combobox" style="width: 100%;" data="GetYSBS" />
                </div>
                <div field="ZDZ" width="100" headeralign="center">
                    赋值<input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="GX" width="100" headeralign="center">
                    关系<input property="editor" class="mini-combobox" style="width: 100%;" data="GetGX" />
                </div>
                <div name="action" width="60" headeralign="center" align="center" renderer="onActionRenderer"
                    cellstyle="padding:0;">
                    维护</div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var getZD = "";
    var dept_grid = mini.get("jhxd_grid");
    var GetYSBS = [{ id: '=', text: '等于' }, { id: '>', text: '大于' }, { id: '>=', text: '大于等于' }, { id: '<', text: '小于' }, { id: '<=', text: '小于等于' }, { id: 'like', text: '包含'}];
    var GetGX = [{ id: 'and', text: '并且' }, { id: 'or', text: '或者'}];
    
    function SetData(data) {
        data = mini.clone(data);
        $.ajax({
            url: "AspxDate.aspx?method=jszd",
            type: "post",
            data: { Cols: data.Cols },
            success: function(text) {

                getZD = text;
            },
            error: function() {
            }
        });
    }
    function OnCellBeginEdit(e) {
        //debugger;
        var grid = e.sender;
        var record = e.record;
        var field = e.field, value = e.value;
        var editor = e.editor;
        if (field == "field") {
             //var url = "AspxDate.aspx?method=jszd&Cols=" + getZD;
            //editor.setUrl(url);
            editor.setData(getZD);
        }
    }
    //维护处理
    function onActionRenderer(e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        var s = ' <a class="New_Button" href="javascript:newRow()">新增</a>'
                    + ' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >编辑</a>'
                    + ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">删除</a>';
        if (dept_grid.isEditingRow(record)) {
            s = '<a class="Update_Button" href="javascript:updateRow(\'' + uid + '\')">更新</a>'
                    + '<a class="Cancel_Button" href="javascript:cancelRow(\'' + uid + '\')">取消</a>'
        }
        return s;
    }
    function newRow() {
        var row = {};
        var number = dept_grid.getData().length;
        dept_grid.addRow(row, number+1);
        dept_grid.cancelEdit();
        dept_grid.beginEditRow(row);
    }

    function editRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            dept_grid.cancelEdit();
            dept_grid.beginEditRow(row);
        }
    }

    function cancelRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            dept_grid.cancelEditRow(row);
        }
    }

    function updateRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        dept_grid.commitEdit();
        dept_grid.updateRow(row);
    }

    function delRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            dept_grid.removeRow(row);
        }
    }

    function save() {
        CloseWindow("ok");
    }
    function GetData() {
        var wheresql = "";
        var Logic = " ";
        var data = dept_grid.getData();
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                var fh = data[i].FH;
                var gx = data[i].GX;
                if (!gx) {
                    gx = "and";
                }
                var field = data[i].field;
                var zdz = data[i].ZDZ;
                if (fh) {
                    if (gx) {
                        if (field) {
                            if (zdz) {
                                if (fh != 'like') {
                                    wheresql += Logic + " ( " + field + " " + fh + " " + "'" + zdz + "'" + ") ";
                                }
                                else {
                                    wheresql += Logic + " ( " + field + " like " + "'%" + zdz + "%'" + ") ";
                                }
                                Logic = gx;
                            }
                        }
                    }
                }
            }
            wheresql = " AND ( " + wheresql + ")";
        }
        return wheresql;
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) {
            if (action != "ok") {
                dept_grid.clearRows();
            }
            return window.CloseOwnerWindow(action);
        }
        else window.close();
    }
</script>


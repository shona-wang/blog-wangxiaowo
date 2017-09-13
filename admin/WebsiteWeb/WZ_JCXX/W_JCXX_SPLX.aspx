<%@ Page Language="C#" AutoEventWireup="true" CodeFile="W_JCXX_SPLX.aspx.cs" Inherits="WZ_JCXX_W_JCXX_SPLX" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>视频类型</title>
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
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
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <a class="mini-button" iconCls="icon-close" plain="true" onclick="CloseWindow()">关闭</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="dept_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" 
                url="../WZ_DealData/DataProcess.aspx?method=SPLXLoad"  idfield="TypeID"  allowcelledit="false" allowcellselect="true" multiSelect="false" emptyText="数据为空，<a href='javascript:newRow()'>增加一条</a>" showEmptyText="true">
                <div property="columns">
                   <div type="checkcolumn"></div>
                   <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                   <div field="TypeID" width="100" headerAlign="center" visible="false">TypeID</div>  
                   <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>  
                   <div field="TypeName" width="100" headerAlign="center" >名称<input property="editor" class="mini-textbox" name="editor1" id="editor1" style="width:100%;" /></div>
                   <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>
                </div>
            </div> 
        </div>
        <input type="hidden" name="Hidden5" id="Hidden5" />
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var dept_grid = mini.get("dept_grid");
    dept_grid.load();
    //////////////////////////////////////////////////////

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function SX() {
        dept_grid.reload();
    }
    //维护处理
    function onActionRenderer(e) {
       // debugger;
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
        dept_grid.addRow(row, 0);
        document.getElementById("Hidden5").value = "1";
        dept_grid.cancelEdit();
        dept_grid.beginEditRow(row);
    }

    function editRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            document.getElementById("Hidden5").value = "2";
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

    function delRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定删除此记录？")) {
                dept_grid.loading("删除中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DeleteSPLX&TypeID=" + row.TypeID,
                    success: function(text) {
                        dept_grid.load({ pageIndex: dept_grid.pageIndex, pageSize: dept_grid.pageSize });
                    },
                    error: function() {
                    }
                });
            }
        }
    }

    function updateRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        dept_grid.commitEdit();
        var rowData = dept_grid.getChanges();

        dept_grid.loading("保存中，请稍后......");
        var json = mini.encode(rowData);

        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveSPLX",
            data: { data: json },
            success: function(text) {
                if (text == "") {
                    alert("保存成功!");
                }
                else {
                    alert(text);
                }
                dept_grid.load({ pageIndex: dept_grid.pageIndex, pageSize: dept_grid.pageSize });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
</script>


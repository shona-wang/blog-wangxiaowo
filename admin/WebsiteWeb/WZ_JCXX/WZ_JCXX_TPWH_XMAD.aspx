<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_TPWH_XMAD.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_TPWH_XMAD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>投票项目维护</title>
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
   <div class="mini-fit" >
        <div id="dept_grid" class="mini-datagrid" style="width:600px;height:300px;" allowResize="true" 
                url="../WZ_DealData/DataProcess.aspx?method=TPMXLoad"  idfield="ID" allowcelledit="false" allowcellselect="true" multiSelect="false" emptyText="数据为空，<a href='javascript:newRow()'>增加一条</a>" showEmptyText="true">
                <div property="columns">
                   <div type="checkcolumn"></div>
                   <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                   <div field="ID" width="100" headerAlign="center" visible="false" >ID号</div>   
                   <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>  
                   <div field="XXMC" width="100" headerAlign="center"  required="true" requiredErrorText="项目名称">项目名称<input property="editor" class="mini-textbox" style="width: 100%;" /></div>
                    <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>
                </div>
        </div> 
    </div>
    <input type="hidden" name="IDH" id="IDH" />
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var dept_grid = mini.get("dept_grid");
    //标准方法接口定义
    function SetData(data) {
        document.getElementById("IDH").value = data.IDH;
        data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
        dept_grid.load({ IDH: data.IDH });
    }
    //////////////////////////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    //维护处理
    function onActionRenderer(e) {
        debugger;
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

    function delRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定删除此记录？")) {
                dept_grid.loading("删除中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DeleteTMMX&ID=" + row.ID,
                    success: function(text) {
                        var idh = document.getElementById("IDH").value;
                        dept_grid.load({ pageIndex: dept_grid.pageIndex, pageSize: dept_grid.pageSize, IDH: idh });
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
        var idh = document.getElementById("IDH").value;
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveTPMX",
            data: { data: json, IDH: idh },
            success: function(text) {
                debugger;
                if (text == "") {
                    alert("保存成功!");
                }
                else {
                    alert(text);
                }

                dept_grid.load({ pageIndex: dept_grid.pageIndex, pageSize: dept_grid.pageSize, IDH: idh });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
</script>
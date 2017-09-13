<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Taskulous_index.aspx.cs"
    Inherits="Flows_Taskulous_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待办事物</title>

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
        .New_Button, .Edit_Button, .Delete_Button, .Update_Button, .Cancel_Button
        {
            font-size: 11px;
            color: #1B3F91;
            font-family: Verdana;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <a class="mini-button" iconcls="icon-addnew" onclick="Dispose" plain="true">处理</a>
                       <span class="separator"></span>
                     <a class="mini-button" iconcls="icon-reload" onclick="reload" plain="true">刷新</a>  
                </td>
            </tr>
        </table>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
            url="Flows_Data.aspx?method=Get_Taskulous" idfield="IDBH" multiselect="true" sizeList=[50,100,300,500] pagesize="50">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="TITLE" width="100" allowsort="true">
                    流程名称</div>
                <div field="XX" width="120" allowsort="true">
                    提报人</div>
                <div field="APPLYTIME" width="120" allowsort="true">
                    提报时间</div>
                <div field="BILLCODE" width="120" allowsort="true">
                    billcode</div>
                <div field="IDBH" width="120" allowsort="true">
                    IDBH</div>
                <div field="APPLYID" width="120" allowsort="true">
                    ApplyID</div>
                <div field="OBJECT_DM" width="120" allowsort="true">
                    object_dm</div>
                <div field="URL" width="120" allowsort="true">
                    Url</div>
                 <div field="ALLOW_JUMP" width="120" allowsort="true">
                    ALLOW_JUMP</div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    grid.load();
    grid.hideColumn(4);
    grid.hideColumn(5);
    grid.hideColumn(6);
    grid.hideColumn(7);
    grid.hideColumn(8);
    grid.hideColumn(9);
     //编辑
    function Dispose() {
        var row = grid.getSelected();
        if (row) {
            var Dm_Url = "../" + row.URL + "?billcode=" + row.BILLCODE + "&IDBH=" + row.IDBH + "&ApplyID=" + row.APPLYID + "&object_dm=" + row.OBJECT_DM + "&&Allow_Jump=" + row.ALLOW_JUMP;
            //var tab = { PARENTID: 'Flows001', TEXT: '流程处理', URL: Dm_Url, ICON: 'icon-edit' };  //首先模拟一个tab
            //parent.AddshowTab(tab);
            mini.open({
            url: Dm_Url,
                title: "事物处理", width: 750, height: 650,
                showMaxButton: true,
                onload: function() {
                   
                },
                ondestroy: function(action) {
                    grid.reload();
                }
            });
        }
        else {
            mini.alert("请选中一条记录");
        }
    }
    function reload() {
        grid.load();
    }
</script>


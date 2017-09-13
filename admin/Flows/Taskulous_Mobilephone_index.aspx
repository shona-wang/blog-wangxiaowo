<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Taskulous_Mobilephone_index.aspx.cs" Inherits="Flows_Taskulous_Mobilephone_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>手机_待办事物查询</title>
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
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
             idfield="IDBH" multiselect="true">
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
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    //url="Flows_Data.aspx?method=Get_Taskulous"
    $(window).load(function() {
        var Request = new QueryString();
        var myWeiXinCode = Request["WeiXinCode"];
        grid.setUrl("Flows_Data.aspx?method=Get_Taskulous&&WeiXinCode=" + myWeiXinCode);
        grid.hideColumn(4);
        grid.hideColumn(5);
        grid.hideColumn(6);
        grid.hideColumn(7);
        grid.hideColumn(8);
        grid.hideColumn(9);
    });
    //grid.load();
</script>
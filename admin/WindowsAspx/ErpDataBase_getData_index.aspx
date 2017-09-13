<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErpDataBase_getData_index.aspx.cs"
    Inherits="WindowsAspx_ErpDataBase_getData_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>查看数据库表数据</title>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height:100%;
        }
    </style>
</head>
<body>
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
        pagesize="1000"  multiselect="true" allowalternating="true" showcolumnsmenu="true" virtualScroll="true">
         <div property="columns">
         
         </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    $(window).load(function() {
        var Request = new QueryString();
        var DataTableName = Request["DataTableName"];
        $.ajax({
            url: "AspxDate.aspx?method=SelectDataBaseField",
            type: "post",
            data: { TableName: DataTableName },
            success: function(text) {
                var _text = mini.decode(text)
                setColdm(_text.data, DataTableName);
            }
        });
    });
    function setColdm(coldms, DataTableName) {
        var datas = [];
        if (coldms.length > 0) {
            for (var i = 0; i < coldms.length; i++) {
                var data = [];
                data.field = coldms[i].字段名;
                data.header = coldms[i].字段名;
                data.width =150;
                data.headerAlign = 'center';
                data.allowSort = true;
                if (coldms[i].类型 == "datetime") {
                    data.dateFormat = "yyyy-MM-dd";
                }
                datas[i] = data;
            }
        }
        grid.setColumns(datas);
        grid.setUrl("AspxDate.aspx?method=getWinData&&TableName=" + DataTableName);
        grid.load();
    }
</script>
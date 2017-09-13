<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Flow_YiJian.aspx.cs" Inherits="Flows_Flow_YiJian" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script src="../scripts/boot.js" type="text/javascript"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

</head>
<body>
     <div id="dept_PSYJ" class="mini-datagrid" style="width: 100%; height:330px;" allowresize="true"
                    idfield="IDBH" allowcelledit="true" allowcellselect="true" multiselect="true"
                    showpager="false">
                    <div property="columns">
                        <div type="indexcolumn" style="width: 6px;" headeralign="center">
                            序号</div>
                        <div field="textname" width="100" headeralign="center">
                            步骤名</div>
                        <div field="processor" width="100" headeralign="center">
                            处理者</div>
                        <div field="processjg" width="80" headeralign="center">
                            处理结果</div>
                        <div field="processyj" width="50" headeralign="center">
                            处理意见</div>
                        <div field="finishtime" width="50" headeralign="center">
                            处理时间</div>
                    </div>
     </div>
</body>
</html>
<script type="text/javascript">
    //debugger;
    mini.parse();
    //////////////////////////////////////
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        var billcode = Request["billcode"];
        var url = "../Flows/Flows_Data.aspx?method=Select_Psyj&DJBH=" + billcode;
        //tabs.loadTab(url, e.tab);
        mini.get("dept_PSYJ").setUrl(url);
        mini.get("dept_PSYJ").load();
    });
    </script>
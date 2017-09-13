<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report_Index.aspx.cs" Inherits="WindowsAspx_Report_Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>报表设计维护</title>

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
        <a id="sj" class="mini-button" iconcls="icon-add" plain="true" onclick="ReqortOpen"
            enabled="false">设计</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" url="AspxDate.aspx?method=ReportGet"
            idfield="BBMC" allowsortcolumn="false" multiselect="true" pagesize="20" allowalternating="true"
            showcolumnsmenu="true">
            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div field="BBMC" headeralign="center" allowsort="true">
                    报表名称
                </div>
                <div field="BBMS" headeralign="center" allowsort="true">
                    报表说明
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    //加载绑定
    mini.parse();
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var sj = mini.get("sj");
        $.ajax({
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {
                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (sj.getText() == ButtonObject[i].POWERTEXT) {
                        sj.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    var grid = mini.get("datagrid1");
    grid.load();
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function ReqortOpen() {
        //debugger;
        var row = grid.getSelected();
        if (row) {
            // debugger;
            URL = "DesignReport.aspx?report=" + row.BBMC + "&amp;data=";
            myleft = (screen.availWidth - 500) / 2;
            mytop = 150;
            mywidth = 800;
            myheight = 500;
            window.open(URL, "报表设计", "height=" + myheight + ",width=" + mywidth + ",status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top=" + mytop + ",left=" + myleft + ",resizable=yes");

        } else {
            mini.alert("请选中一条记录");
        }
    }
</script>


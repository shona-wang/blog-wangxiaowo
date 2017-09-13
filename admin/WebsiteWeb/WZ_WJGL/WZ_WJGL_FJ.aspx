<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_WJGL_FJ.aspx.cs" Inherits="WZ_WJGL_WZ_WJGL_FJ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>附件查看</title>
     <script type="text/javascript" src="../scripts/boot.js"></script>
    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
    <div class="mini-fit" >
            <div id="dept_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
                url="../WZ_DealData/DataProcess.aspx?method=WJFJCKLoad" idfield="ID" allowcelledit="true" allowcellselect="true" multiSelect="false" >
                <div property="columns">
                    <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>                                           
                    <div field="FileName" width="100" headerAlign="center" >附件名称</div>  
                    <div field="FilePath" width="100" headerAlign="center" renderer="onActionRenderer">下载附件</div> 
                </div>
            </div> 
        </div>
</body>
</html>


<script type="text/javascript">
    mini.parse();
    var dept_grid = mini.get("dept_grid");
    $(window).load(function() {
        debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        dept_grid.load({ data: DJBH });
    });


    //////////////////////////////////////////////////////

    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }

    function SX() {

        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        dept_grid.load({ data: DJBH });
    }

    //下载
    function onActionRenderer(e) {
        debugger;
        var rows = e.row;
        var Path = "../" + rows.FilePath;
        //        var s = ' <a  href="javascript:OpenRow(\'' + Path + '\')" >下载附件</a>';
        var s = ' <a  href=\'' + Path + '\' >下载附件</a>';
        return s;
    }
</script>

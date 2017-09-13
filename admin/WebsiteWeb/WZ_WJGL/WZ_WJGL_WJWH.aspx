<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_WJGL_WJWH.aspx.cs" Inherits="WZ_WJGL_WZ_WJGL_WJWH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>文件上传维护</title>
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
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" plain="true" onclick="add()">添加文件</a> 
                    </td>
                    <td style="white-space:nowrap;">
                        <label for="textbox1$text">查询条件</label>
                        <input id="key" class="mini-textbox" emptyText="文件名称" style="width:150px;" onenter="onKeyEnter"/>
                        <a class="mini-button" onclick="search()" plain="true">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="wj_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
                url="../WZ_DealData/DataProcess.aspx?method=WJGLLoad"  idfield="AccountNum,FileID" allowcelledit="false" allowcellselect="true" multiSelect="false" >
                <div property="columns">
                    <div type="checkcolumn"></div>
                    <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                    <div field="id" width="100" headerAlign="center" visible="false" >ID号</div>   
                    <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>                                         
                    <div field="FileID" width="100" headerAlign="center" visible="false">文件编号</div>
                    <div field="FileName" width="100" headerAlign="center" >文件名称</div>    
                    <div field="FileTypeID" width="30" headerAlign="center" visible="false">类别编号</div> 
                    <div field="FileTypeIDMC" width="100" headerAlign="center" >文件类别</div> 
                    <div field="FileNote" width="100" headerAlign="center" >文件说明</div> 
                    <div field="FileCreateTime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd">创建时间</div> 
                    <div field="FileCreateUser" width="100" headerAlign="center" visible="false">创建人账号</div> 
                    <div name="action1" width="50" headerAlign="center" align="center" renderer="onActionRenderer2" cellStyle="padding:0;">查看附件</div>   
                    <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>  
                </div>
            </div> 
        </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var wj_grid = mini.get("wj_grid");
    wj_grid.load();
    //////////////////////////////////////////////////////
    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }
    function search() {
        //
        var key = mini.get("key").getValue();
        wj_grid.load({ key: key });
    }
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function SX() {
        wj_grid.reload();
    }
    //添加文件
    function add() {
        mini.open({
        url: "../WZ_WJGL/WZ_WJGL_WJWH_AD.aspx",
            title: "添加文件", width: 600, height: 500,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "new" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
            wj_grid.reload();
            }
        });
    }

    //单元格链接
    function onActionRenderer2(e) {
        debugger;
        var grid = e.sender;
        var record = e.record;
        var uid = record.FileID;
        var rowIndex = e.rowIndex;

        var s = '<a href="javascript:OpenRow2(\'' + uid + '\')">查看附件</a>';

        return s;
    }

    function OpenRow2(row_uid) {
        debugger;
        if (row_uid != "") {
            URL = "../WZ_WJGL/WZ_WJGL_FJ.aspx?DJBH=" + row_uid;
            //window.open(URL);
            window.open(URL, "查看附件", "width=600,height=500,status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes")
        }
    }

    //维护处理
    function onActionRenderer(e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        //'<a class="New_Button" href="javascript:newRow()">New</a>'+
        var s = ' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >编辑</a>'
             + ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">删除</a>';

        //        if (dept_grid.isEditingRow(record)) {
        //            s = '<a class="Update_Button" href="javascript:updateRow(\'' + uid + '\')">更新</a>'
        //                    + '<a class="Cancel_Button" href="javascript:cancelRow(\'' + uid + '\')">取消</a>'
        //        }
        return s;
    }

    function editRow(row_uid) {
        var row = wj_grid.getRowByUID(row_uid);
        if (row) {
            mini.open({
                url: "../WZ_WJGL/WZ_WJGL_WJWH_AD.aspx",
                title: "修改文件", width: 860, height: 600,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", FileID: row.FileID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    wj_grid.reload();
                }
            });
        }
    }

    function delRow(row_uid) {
        var row = wj_grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定删除此记录？")) {
                wj_grid.loading("删除中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DeleteWJ&FileID=" + row.FileID,
                    success: function(text) {
                        wj_grid.reload();
                    },
                    error: function() {
                    }
                });
            }
        }
    }
</script>
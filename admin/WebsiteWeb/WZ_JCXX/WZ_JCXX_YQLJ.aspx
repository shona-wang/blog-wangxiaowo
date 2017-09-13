<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_YQLJ.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_YQLJ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>友情链接管理</title>
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
                        <a class="mini-button" iconCls="icon-add" onclick="add()" plain="true">新增</a> <span class="separator"></span> 
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()" plain="true">修改</a> <span class="separator"></span> 
                        <a class="mini-button" iconCls="icon-remove" onclick="del()" plain="true">删除</a> <span class="separator"></span> 
                        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
                    </td>
                    <td style="white-space:nowrap;">
                        <label for="textbox1$text">查询条件</label>
                        <input id="key" class="mini-textbox" emptyText="请输入网站名称" style="width:150px;" onenter="onKeyEnter"/>
                        <a class="mini-button" onclick="search()" plain="true">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="dept_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" oncellbeginedit="cellbeginedit" 
                url="../WZ_DealData/DataProcess.aspx?method=YQLJLoad"  idfield="ID" allowcelledit="false" allowcellselect="true" multiSelect="false">
                <div property="columns">
                   <div type="checkcolumn"></div>
                   <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                   <div field="id" width="100" headerAlign="center" visible="false" >ID号</div>   
                   <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>  
                   <div field="FLBH" width="100" headerAlign="center" visible="false" >分类编号</div>
                   <div field="FLMC" width="100" headerAlign="center" >分类名称</div>
                   <div field="WZMS" width="100" headerAlign="center">网站名称</div>
                   <div field="LJDZ" width="100" headerAlign="center">链接地址</div>    
                </div>
            </div> 
        </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var dept_grid = mini.get("dept_grid");

    dept_grid.load();

    //////////////////////////////////////////////////////

    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }

    function search() {
        //
        var key = mini.get("key").getValue();
        dept_grid.load({ key: key });
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }

    function SX() {
        dept_grid.reload();
    }

    //新增
    function add() {
        mini.open({
        url: "../WZ_JCXX/WZ_JCXX_YQLJ_WH.aspx",
            title: "新增友情链接", width: 550, height: 400,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "new" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                dept_grid.reload();
            }
        });
    }

    //修改
    function edit() {
        var row = dept_grid.getSelected();
        if (row) {
            mini.open({
            url: "../WZ_JCXX/WZ_JCXX_YQLJ_WH.aspx",
                title: "编辑友情链接", width: 550, height: 400,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", IDH: row.ID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    dept_grid.reload();
                }
            });
        } else {
            alert("请选中一条记录!");
        }
    }

    //删除
    function del() {

        var row = dept_grid.getSelected();
        if (row) {
            if (confirm("确定删除此记录？")) {
                dept_grid.loading("删除中，请稍后......");
                $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=DelYQLJ&IDH=" + row.ID,
                    success: function(text) {
                        var mes = mini.decode(text);
                        if (mes.messageid > 0) {
                            mini.alert("删除成功!");
                        }
                        else {
                            mini.alert("删除失败!");
                        }
                        dept_grid.reload();
                    }
                })
            }
        }
        else {
            mini.alert("请选中一条记录");
        }
    }
</script>

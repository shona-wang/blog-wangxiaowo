<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_TPWH.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_TPWH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>投票设置管理</title>
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
                         <a class="mini-button" iconCls="icon-close" plain="true" onclick="CloseWindow()">关闭</a>
                    </td>
                    <td style="white-space:nowrap;">
                        <label for="textbox1$text">查询条件</label>
                        <input id="key" class="mini-textbox" emptyText="请输入主题" style="width:150px;" onenter="onKeyEnter"/>
                        <a class="mini-button" onclick="search()" plain="true">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="dept_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" oncellbeginedit="cellbeginedit" 
                url="../WZ_DealData/DataProcess.aspx?method=TPLoad"  idfield="ID" allowcelledit="false" allowcellselect="true" multiSelect="false">
                <div property="columns">
                   <div type="checkcolumn"></div>
                   <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                   <div field="ID" width="100" headerAlign="center" visible="false" >ID号</div>   
                   <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>  
                   <div field="TPZT" width="100" headerAlign="center" >投票主题</div>
                   <div field="SFYC" width="100" headerAlign="center" visible="false">是否当前调查项</div>
                   <div field="SFYCMC" width="100" headerAlign="center" >当前调查</div>
                   <div field="DXDX" width="100" headerAlign="center" visible="false">单选多选</div>
                   <div field="DXDXMC" width="100" headerAlign="center">单选多选</div>
                   <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>    
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
            url: "../WZ_JCXX/WZ_JCXX_TPWH_AD.aspx",
            title: "新增投票项目", width: 550, height: 400,
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
        debugger;
        var row = dept_grid.getSelected();
        if (row) {
            mini.open({
                url: "../WZ_JCXX/WZ_JCXX_TPWH_AD.aspx",
                title: "编辑投票项目", width: 550, height: 400,
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
                    url: "../WZ_DealData/DataProcess.aspx?method=DelTP&IDH=" + row.ID,
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

    //维护处理
    function onActionRenderer(e) {
        debugger;
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        var s = '<a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >维护投票明细</a>';
        return s;
    }

    function editRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            mini.open({
                url: "../WZ_JCXX/WZ_JCXX_TPWH_XMAD.aspx",
                title: "编辑投票明细", width: 650, height: 400,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { IDH: row.ID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    dept_grid.reload();
                }
            });
        }
    }

</script>


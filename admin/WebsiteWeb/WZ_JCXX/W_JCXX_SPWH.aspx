<%@ Page Language="C#" AutoEventWireup="true" CodeFile="W_JCXX_SPWH.aspx.cs" Inherits="WZ_JCXX_W_JCXX_SPWH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>视频维护</title>
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
                        <a class="mini-button" iconCls="icon-add" plain="true" onclick="add()">增加视频</a> <span class="separator"></span> 
                        <a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">修改视频</a><span class="separator"></span>  
                        <a class="mini-button" iconCls="icon-remove" plain="true" onclick="del()">删除视频</a><span class="separator"></span>  
                        <a class="mini-button" iconCls="icon-close" plain="true" onclick="CloseWindow()">关闭</a>
                    </td>
                    <td style="white-space:nowrap;">
                        <input id="key" class="mini-textbox" emptyText="请输入视频名称" style="width:150px;" onenter="onKeyEnter"/>   
                        <a class="mini-button" onclick="search()">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="ht_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
                url="../WZ_DealData/DataProcess.aspx?method=SPWHLoad"  idfield="FilmID" allowcelledit="true" allowcellselect="true" multiSelect="false" >
                <div property="columns">
                    <div type="checkcolumn"></div>
                    <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                    <div field="FilmID" width="80" headerAlign="center" visible="false" >FilmID</div>  
                    <div field="FilmName" width="100" headerAlign="center" >视频名称</div>                                           
                    <div field="FilmURL" width="200" headerAlign="center" >视频路径</div>
                    <div field="IsNotMul" width="100" headerAlign="center"  visible="false" >IsNotMul</div>
                    <div field="TypeID" width="100" headerAlign="center" visible="false">对方单位</div>    
                    <div field="TypeName" width="100" headerAlign="center" >视频类型</div>    
                    <div field="Hits" width="100" headerAlign="center" visible="false" >Hits</div>    
                    <div field="CreateDate" width="100" headerAlign="center"  dateFormat="yyyy-MM-dd">创建时间</div> 
                    <div field="PlayType" width="100" headerAlign="center" visible="false">PlayType</div>  
                    <div field="Filmzy" width="100" headerAlign="center" visible="false">视频路径</div>  
                    <div field="LMBH" width="100" headerAlign="center" visible="false">栏目编号</div>      
                     <div field="LMMC" width="100" headerAlign="center" >栏目名称</div>      
                    <div field="SPTP" width="200" headerAlign="center" >视频图片</div> 
                    <div field="accountnum" width="50" headerAlign="center" visible="false">帐套号</div> 
                </div>
            </div> 
        </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var ht_grid = mini.get("ht_grid");
    ht_grid.load();

    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }
    //查询事件
    function search() {
        var key = mini.get("key").getValue();
        ht_grid.load({ key: key });
    }
    //窗体关闭事件
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    //增加视频
    function add() {
        mini.open({
        url: "../WebsiteWeb/WZ_JCXX/W_JCXX_SPWH_Add.aspx",
            title: "增加视频", width: 650, height:200,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "new" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                ht_grid.reload();
            }
        });
    }
    //修改视频
    function edit() {
        var row = ht_grid.getSelected();
        if (row) {
            mini.open({
            url: "../WebsiteWeb/WZ_JCXX/W_JCXX_SPWH_Add.aspx",
                title: "修改视频", width: 800, height: 600,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", FilmID: row.FilmID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    ht_grid.reload();
                }
            });
        } else {
            alert("请选中一条记录!");
        }
    }
    //删除视频
    function del() {
        var row = ht_grid.getSelected();
        if (row) {
            mini.confirm("确定要删除选中的记录吗?", "确定?",
            function(action) {
                if (action == "ok") {
                    ht_grid.loading("操作中,请稍后……");
                    $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DelSP&FilmID=" + row.FilmID + "&FilmURL=" + row.FilmURL + "&SPTP=" + row.SPTP,
                        success: function(text) {
                            var mes = mini.decode(text);
                            if (mes.messageid > 0) {
                                mini.alert("删除成功!");
                            }
                            else {
                                mini.alert("删除失败!");
                            }
                            ht_grid.reload();
                        }
                    })
                }
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
</script>


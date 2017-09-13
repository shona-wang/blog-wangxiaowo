<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_LYXX.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_LYXX" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>留言信箱维护</title>
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
                    <td style="white-space:nowrap;">
                        <label for="textbox1$text">标题</label>
                        <input id="key" class="mini-textbox" emptyText="请输入标题" style="width:150px;" onenter="onKeyEnter"/>
                        <label for="textbox1$text">类别</label>
                        <input id="LB" name="LB" class="mini-combobox" style="width:80px;" textField="text" valueField="id" emptyText="请选择..." url="../WZ_JCXX/LBCombo.txt" value=""  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/>
                        <label for="textbox1$text">是否查看</label>
                        <input id="CK" name="CK" class="mini-combobox" style="width:80px;" textField="text" valueField="id" emptyText="请选择..." url="../WZ_JCXX/CKCombo.txt" value=""  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/>
                        <label for="textbox1$text">是否回复</label>
                        <input id="HF" name="HF" class="mini-combobox" style="width:80px;" textField="text" valueField="id" emptyText="请选择..." url="../WZ_JCXX/HFCombo.txt" value=""  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/>                        
                        <a class="mini-button" onclick="search()">查询</a>
                    </td>
                </tr>
            </table>           
        </div>
        
        <!--主表-->
        <div class="mini-fit" >
            <div id="dept_grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"   
                url="../WZ_DealData/DataProcess.aspx?method=LYXXLoad"  idfield="ID" allowcelledit="false" allowcellselect="true" multiSelect="false">
                <div property="columns">
                   <div type="checkcolumn"></div>
                   <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                   <div field="id" width="100" headerAlign="center" visible="false" >ID号</div>   
                   <div field="AccountNum" width="100" headerAlign="center" visible="false">帐套号</div>  
                   <div field="FXBT" width="100" headerAlign="center"   allowSort="true" >标题</div>
                   <div field="XFLXMC" width="100" headerAlign="center" >类型名称</div>
                   <div field="FXRMC" width="100" headerAlign="center"  allowSort="true">发信人名称</div>
                   <div field="FXSJ" width="100" headerAlign="center" dateFormat="yyyy-MM-dd"  allowSort="true">发送时间</div>
                   <div field="SFFB" width="100" headerAlign="center" visible="false">是否回复</div>
                   <div field="SFCK" width="100" headerAlign="center" visible="false">是否查看</div>
                   <div field="SFFBMC" width="100" headerAlign="center"   allowSort="true">是否回复</div>
                   <div field="SFCKMC" width="100" headerAlign="center" allowSort="true" >是否查看</div>
                   <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>
                </div>
            </div> 
        </div>
        <input type="hidden" name="Hidden5" id="Hidden5" />
</body>
</html>


<script type="text/javascript">
    mini.parse();
    var dept_grid = mini.get("dept_grid");
    dept_grid.sortBy("ID", "desc");
    dept_grid.load();

    //////////////////////////////////////////////////////
    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }
    function search() {
        var key = mini.get("key").getValue();
        var lb = mini.get("LB").getValue();
        var ck = mini.get("CK").getValue();
        var hf = mini.get("HF").getValue();
        dept_grid.load({ key: key, lb: lb, ck: ck, hf: hf });
    }
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function SX() {
        dept_grid.reload();
    }
    //维护处理
    function onActionRenderer(e) {
        debugger;
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        var hf = record.SFFB;
        var s = ' <a class="New_Button" href="javascript:LookRow(\'' + uid + '\')">查看</a>';
        if (hf == "0") {
            s += ' <a class="Edit_Button" href="javascript:HFRow(\'' + uid + '\')" >回复</a>';
        }
        s += ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">删除</a>';
        return s;
    }

    function LookRow(row_uid) {
        debugger;
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            mini.open({
                url: "../WZ_JCXX/WZ_JCXX_LYXX_CK.aspx",
                title: "查看", width: 960, height: 600,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Look", IDH: row.ID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    dept_grid.reload();
                }
            });
        }
    }

    function HFRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            mini.open({
                url: "../WZ_JCXX/WZ_JCXX_LYXX_HF.aspx",
                title: "回复", width: 960, height: 600,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", IDH: row.ID };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    dept_grid.reload();
                }
            });
        }
    }

    function delRow(row_uid) {
        var row = dept_grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定删除此记录？")) {
                dept_grid.loading("删除中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DeleteLYXX&ID=" + row.ID,
                    success: function(text) {
                        dept_grid.load({ pageIndex: dept_grid.pageIndex, pageSize: dept_grid.pageSize });
                    },
                    error: function() {
                    }
                });
            }
        }
    }
</script>
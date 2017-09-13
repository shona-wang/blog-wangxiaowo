<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_NRGL_DS.aspx.cs" Inherits="WZ_NRGL_WZ_NRGL_DS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待审文章</title>
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
              <%--  <tr>
                    <td style="width:100%;">
                        <label for="textbox1$text">文章标题</label>
                        <input id="key" class="mini-textbox" emptyText="文章标题" style="width:150px;" onenter="onKeyEnter"/>
                        <a class="mini-button" onclick="search()">查询</a>
                    </td>
                </tr>--%>
                
                    <tr>
                    <td style="width:100%;">
                        <label for="textbox1$text">文章标题</label>
                        <input id="key" class="mini-textbox" emptyText="文章标题" style="width:150px;" onenter="onKeyEnter"/>
                        <label for="textbox1$text">所属栏目</label>
                        <input id="btnEdit_lm" class="mini-buttonedit" onbuttonclick="onButtonEdit_lm"  style="width:150px;"  /> 
                        <label for="textbox1$text">撰写时间</label>
                        <input id="date1" name="date1" class="mini-datepicker" value=""/>
                        <label for="textbox1$text">到</label>
                        <input id="date2" name="date2" class="mini-datepicker" value=""/> 
                        <a class="mini-button" onclick="search()">查询</a>
                    </td>
                </tr>
                 <tr>
                    <td style="width:100%;">
                      <label for="textbox1$text">发 布 者</label>
                        <input id="xwfbz" class="mini-textbox" emptyText="新闻发布者" style="width:150px;" onenter="onKeyEnter"/>
                       <label for="textbox1$text">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态</label>
                        <input id="combo1" class="mini-combobox" style="width:150px;" textField="text" valueField="id" emptyText="请选择..." url="../WZ_NRGL/zt.txt" value=""  required="false" allowInput="false" showNullItem="true" nullItemText="请选择..."/>     
                        <label for="textbox1$text">审核时间</label>
                        <input id="date3" name="date3" class="mini-datepicker" value=""/>
                        <label for="textbox1$text">到</label>
                        <input id="date4" name="date4" class="mini-datepicker" value=""/> 
                          </td>
                </tr>
                
            </table>           
        </div>
        
         <!--主表-->
        <div class="mini-fit" >
            <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
                url="../WZ_DealData/DataProcess.aspx?method=FindDSDoc"  idfield="AccountNum,XWBH" allowcelledit="true" allowcellselect="true" multiSelect="false" sizeList=[50,100,300,500] pagesize="50">
                <div property="columns">
                    <div type="checkcolumn"></div>
                    <div type="indexcolumn"  style="width:6px;" headerAlign="center">序号</div>      
                    <div field="AccountNum" width="120" headerAlign="center" allowSort="true" visible="false">AccountNum</div>      
                    <div field="XWBH" width="120" headerAlign="center" allowSort="true" visible="false">新闻编号</div>
                    <div field="XWZBT" width="120" headerAlign="center" allowSort="true">主标题</div>
                    <div field="LMBH" width="120" headerAlign="center" allowSort="true" visible="false">栏目编号</div>
                    <div field="LMMC" width="120" headerAlign="center" allowSort="true">栏目名称</div>   
                    <div field="XWFBZ" width="120" headerAlign="center" allowSort="true">发布者</div>
                    <div field="CJSJ" width="120" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">撰写时间</div> 
                    <div field="SHRY" width="120" headerAlign="center" allowSort="true">审核人员</div>
                    <div field="SHSJ" width="120" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">审核时间</div> 
                    <div field="BSMC" width="120" headerAlign="center" allowSort="true">状态</div>
                    <div name="action" width="150" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">维护</div>  
                </div>
            </div> 
        </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var grid = mini.get("grid");
    grid.load();
    //////////////////////////////////////////////////////
    //键盘回车事件
    function onKeyEnter(e) {
        search();
    }
    function search() {
        //
//        var key = mini.get("key").getValue();
        //        grid.load({ key: key });

        var wzbt = mini.get("key").getValue();
        var sslm = mini.get("btnEdit_lm").getValue();
        var xwfbz = mini.get("xwfbz").getValue();
        var dt1 = mini.get("date1").getFormValue();
        var dt2 = mini.get("date2").getFormValue();
        var dt3 = mini.get("date3").getFormValue();
        var dt4 = mini.get("date4").getFormValue();
        var zt = mini.get("combo1").getValue();
        grid.load({ wzbt: wzbt, sslm: sslm, xwfbz: xwfbz, dt1: dt1, dt2: dt2, dt3: dt3, dt4: dt4, zt: zt });
    }
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function SX() {
        grid.reload();
    }

    //选择所属栏目
    function onButtonEdit_lm(e) {
        var btnEdit_lm = this;
        mini.open({
        url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_SHLMSel.aspx",
            title: "选择栏目",
            width: 600,
            height: 500,
            ondestroy: function(action) {
                if (action == "ok") {

                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //必须
                    if (data) {
                        btnEdit_lm.setValue(data.LMBH);
                        btnEdit_lm.setText(data.LMMC);
                    }
                }

            }
        });
    }

    //维护处理
    function onActionRenderer(e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        //'<a class="New_Button" href="javascript:newRow()">New</a>'+
        //' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >编辑</a>'
        //            +
        var s = ' <a class="New_Button" href="javascript:shRow(\'' + uid + '\')" ></a>' +
                    ' <a class="New_Button" href="javascript:sh2Row(\'' + uid + '\')"></a>' +
                      ' <a class="New_Button" href="javascript:sh3Row(\'' + uid + '\')">审核</a>' +
                    ' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >编辑</a>' +
                    ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">删除</a>';

        //        if (dept_grid.isEditingRow(record)) {
        //            s = '<a class="Update_Button" href="javascript:updateRow(\'' + uid + '\')">更新</a>'
        //                    + '<a class="Cancel_Button" href="javascript:cancelRow(\'' + uid + '\')">取消</a>'
        //        }
        return s;
    }

    function shRow(row_uid) {
        debugger;
        var row = grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定同意此记录？")) {
                grid.loading("审核中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=SHDoc&XWBH=" + row.XWBH + "&BS=1",
                    success: function(text) {
                        if (text == 1) {
                            mini.alert("审核成功!");
                        }
                        else {
                            mini.alert("审核失败!");
                        }
                        grid.reload();
                    },
                    error: function() {
                    }
                });
            }
        }
    }

    function sh2Row(row_uid) {
        debugger;
        var row = grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定不同意此记录？")) {
                grid.loading("审核中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=SHDoc&XWBH=" + row.XWBH + "&BS=-1",
                    success: function(text) {
                        if (text == 1) {
                            mini.alert("审核成功!");
                        }
                        else {
                            mini.alert("审核失败!");
                        }
                        grid.reload();
                    },
                    error: function() {
                    }
                });
            }
        }
    }

    function editRow(row_uid) {
        debugger;
        var row = grid.getRowByUID(row_uid);
        mini.open({
        url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_LR_AM.aspx",
            title: "修改文档", width: 860, height: 600,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "edit", XWBH: row.XWBH };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }
    function delRow(row_uid) {
        var row = grid.getRowByUID(row_uid);
        if (row) {
            if (confirm("确定删除此记录？")) {
                grid.loading("删除中，请稍后......");
                $.ajax({
                    url: "../WZ_DealData/DataProcess.aspx?method=DeleteDoc&XWBH=" + row.XWBH,
                    success: function(text) {
                        if (text == 1) {
                            mini.alert("删除成功!");
                        }
                        else {
                            mini.alert("删除失败!");
                        }
                        grid.reload();
                    },
                    error: function() {
                    }
                });
            }
        }
    }

    function sh3Row(row_uid) {
        debugger;
        var row = grid.getRowByUID(row_uid);
        mini.open({
        url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_SH.aspx",
            title: "审核", width: 860, height: 600,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "edit", XWBH: row.XWBH };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }
</script>

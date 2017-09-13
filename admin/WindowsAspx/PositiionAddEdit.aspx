<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PositiionAddEdit.aspx.cs"
    Inherits="WindowsAspx_PositiionAddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>职位维护</title>

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
        <a id="add" class="mini-button" iconcls="icon-add" onclick="addRow()" plain="true" enabled="false">增加</a>
        <span class="separator"></span><a id="edit" class="mini-button" iconcls="icon-edit" onclick="edit()"
            plain="true" enabled="false">编辑</a> <span class="separator"></span><a id="del" class="mini-button" iconcls="icon-remove"
                onclick="removeRow()" plain="true" enabled="false">删除</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
        <input id="key" class="mini-textbox" emptytext="请输入职位名称" style="width: 150px;" onenter="onKeyEnter" />
        <a id="cx" class="mini-button" onclick="search()" iconcls="icon-search" plain="true" enabled="false">查询</a>
        <% = HtmlHidden("TABLE37")%>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" 
            idfield="ZWID" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true"
            allowalternating="true" showcolumnsmenu="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <%--<div field="MC" width="120" headeralign="center" allowsort="true">
                    职位名称
                </div>--%>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript" language="javascript">
     //加载绑定
     mini.parse();
     var grid = mini.get("datagrid1");
     var TableName = "TABLE37";
     $(window).load(function() {
         var Request = new QueryString();
         ButtonRoles(Request["MenuBh"]);
         ColumnData();
     });
     grid.setUrl("AspxDate.aspx?method=PositiionGet");
     grid.load({ TableName: TableName });
     function ColumnData() {
         var columns = grid.getColumns();
         var lenght = 0;
         $.ajax({
         url: "../DynamicForm/KY_Modes/KY_ModesData.aspx?method=KY_Modes_Json_getSelectWhere&TableName=" + TableName,
             type: "post",
             success: function(text) {
                 var V = mini.decode(text);
                 var data = [];
                 if (V.length > 0) {
                     for (var i = 0; i < V.length; i++) {
                         data = [];
                         data.field = V[i].KJID;
                         data.header = V[i].KJMS;
                         data.width = 100;
                         data.headerAlign = 'center';
                         data.allowsort = 'true';
                         if (V[i].KJLX == 4) {
                             data.dateFormat = 'yyyy-MM-dd';
                         }
                         lenght = columns.length;
                         columns[lenght] = data;
                     }
                     data = [];
                     data.field = "LRRYXM";
                     data.header = "录入人员姓名";
                     data.width = 100;
                     data.headerAlign = 'center';
                     data.allowsort = "true";
                     lenght = columns.length;
                     columns[lenght] = data;
                     data = [];
                     data.field = "LRSJ";
                     data.header = "录入时间";
                     data.width = 100;
                     data.headerAlign = 'center';
                     data.allowsort = "true";
                     data.dateFormat = "yyyy-MM-dd";
                     lenght = columns.length;
                     columns[lenght] = data;
                     grid.setColumns(columns);
                 }
             }
         });
     }
     function ButtonRoles(MenuBh) {
         var ButtonObject;
         var add = mini.get("add");
         var edit = mini.get("edit");
         var del = mini.get("del");
         var cx = mini.get("cx");
         $.ajax({
             url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
             success: function(text) {
                 ButtonObject = mini.decode(text);
                 for (var i = 0; i < ButtonObject.length; i++) {
                     var zt = true;
                     if (ButtonObject[i].ZT == "flase") {
                         zt = false;
                     }
                     if (add.getText() == ButtonObject[i].POWERTEXT) {
                         add.setEnabled(zt);
                     }
                     if (edit.getText() == ButtonObject[i].POWERTEXT) {
                         edit.setEnabled(zt);
                     }
                     if (del.getText() == ButtonObject[i].POWERTEXT) {

                         del.setEnabled(zt);
                     }
                     if (cx.getText() == ButtonObject[i].POWERTEXT) {
                         cx.setEnabled(zt);
                     }
                 }
             },
             error: function() {
             }
         });
     }
     //添加
     function addRow() {
         mini.open({
             url: "Positiion_Edit.aspx",
             title: "新增-" + mini.get("TABLETEXT").getValue(), width: mini.get("WIDTH").getValue(), height: mini.get("HEIGTH").getValue(),
             onload: function() {
                 var iframe = this.getIFrameEl();
                 var data = { action: "Add", FL: TableName };
                 iframe.contentWindow.SetData(data);
             },
             ondestroy: function(action) {
                 grid.reload();
             }
         });
     }
     //编辑
     function edit() {
         var row = grid.getSelected();
         if (row) {
             mini.open({

                 url: "Positiion_Edit.aspx",
                 title: "新增-" + mini.get("TABLETEXT").getValue(), width: mini.get("WIDTH").getValue(), height: mini.get("HEIGTH").getValue(),
                 onload: function() {
                     var iframe = this.getIFrameEl();
                     var data = { action: "Edit", FL: TableName, zwid: row.ZWID };
                     iframe.contentWindow.SetData(data); //调用子页面的函数
                 },
                 ondestroy: function(action) {
                     grid.reload();
                 }
             });

         } else {
             mini.alert("请选中一条记录");
         }
     }
     //删除
     function removeRow() {
         var rows = grid.getSelecteds();
         if (rows.length > 0) {
             mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.ZWID);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=Table37_Deletes&ZWID=" + id,
                        success: function(text) {
                            var o = mini.decode(text);
                            if (o.messageid == -1) {
                                mini.alert(o.messageContent);
                            }
                            grid.reload();
                        },
                        error: function() {
                        }
                    });

                }
            });
         } else {
             mini.alert("请选中一条记录");
         }
     }
     //查询
     function search() {
         var key = mini.get("key").getValue();
         grid.load({ key: key });
     }
     function onKeyEnter() {
         search();
     }
     //关闭窗口
     function CloseWindow(action) {
         if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
         else window.close();
     }
</script>


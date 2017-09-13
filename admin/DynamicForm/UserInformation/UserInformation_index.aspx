<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserInformation_index.aspx.cs" Inherits="DynamicForm_UserInformation_UserInformation_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../scripts/boot.js" type="text/javascript"></script>
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
    <a class="mini-button" iconcls="icon-add"
            onclick="add()" plain="true">增加</a> <span class="separator"></span>
              <a class="mini-button" iconcls="icon-add"
            onclick="addlist()" plain="true">批量增加</a> <span class="separator"></span>
            <a class="mini-button"
                iconcls="icon-edit" onclick="edit()" plain="true">编辑</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">
            刷新</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                onclick="Dels()" plain="true">删除</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
            plain="true">关闭</a>
        <input id="Where" name="Where" class="mini-hidden" />
        <% = HtmlHidden("UserInformation")%>
    </div>
    <div class="mini-fit">
         <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;"
            idfield="DJKEY" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true"
            allowalternating="true" showcolumnsmenu="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    var TableName = "UserInformation";
    $(window).load(function() {
        ColumnData();
    });
    grid.setUrl("UserInformationData.aspx?method=UserInformation_PageJson_SelectWhere");
    grid.load({ TableName: TableName });
    function ColumnData() {
        var columns = grid.getColumns();
        var lenght =0;
        $.ajax({
            url: "../KY_Modes/KY_ModesData.aspx?method=KY_Modes_Json_getSelectWhere&TableName=" + TableName,
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
    //添加
    function add() {
        mini.open({
        url: "../DynamicForm/UserInformation/UserInformation_Edit.aspx", //此处注意修改
        title: "新增-" + mini.get("TABLETEXT").getValue(), width: mini.get("WIDTH").getValue(), height: mini.get("HEIGTH").getValue(),
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { FL: TableName };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }
    //批量添加
    function addlist() {
        mini.open({
        url: "../DynamicForm/UserInformation/UserInformationDynamicForm_EditList.aspx", //此处注意修改
            //title: "新增-" + mini.get("TABLETEXT").getValue(), width: mini.get("WIDTH").getValue(), height: mini.get("HEIGTH").getValue(),
            title: "新增-档案信息", width:800,height: 500,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = {action:'Add', FL: TableName };
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
            url: "../DynamicForm/UserInformation/UserInformation_Edit.aspx",
            title: "新增-" + mini.get("TABLETEXT").getValue(), width: mini.get("WIDTH").getValue(), height: mini.get("HEIGTH").getValue(),
                showMaxButton: true,
                onload: function() {
                var iframe = this.getIFrameEl();
                    var data = { action: "edit", FL: TableName,DJBH: row.DJKEY };
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
    function Dels() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.DJKEY);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                    url: "UserInformationData.aspx?method=UserInformation_Deletes&DJBH=" + id,
                        success: function(text) {
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
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

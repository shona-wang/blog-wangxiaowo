<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_DengJi.aspx.cs" Inherits="CustomersAspx_KHZD_KH_DengJi" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户等级-字典</title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

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
           <a id="sy" class="mini-button" iconcls="icon-upload" onclick="moveUp"
            plain="true" enabled="false">上移</a>
         <span class="separator"></span>
        <a id="xy" class="mini-button" iconcls="icon-download" onclick="moveDown"
            plain="true" enabled="false">下移</a>
             <span class="separator"></span>
              <a id="px" class="mini-button"
                            iconcls="icon-save" plain="true" onclick="SaveDataOrder()" enabled="false">保存</a>
             <span class="separator"></span>               
        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    </div>
  <div class="mini-fit">
    <div id="datagrid1" class="mini-datagrid" style="width:100%x; height:100%" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHDJ"
        idfield="DJBH" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
        <div property="columns">
            <div type="checkcolumn">
            </div>
            <div field="MC" width="120" headeralign="center" allowsort="true">
              等级名称
            </div>
            <div field="BZ" width="120" headeralign="center" allowsort="true">
              备注
            </div>
        </div>
    </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var add = mini.get("add");
        var edit = mini.get("edit");
        var del = mini.get("del");
        var sy = mini.get("sy");
        var xy = mini.get("xy");
        var px = mini.get("px");
        $.ajax({
            url: "../../WindowsAspx/AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {
                //debugger;
                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].zt == "flase") {
                        zt = false;
                    }
                    if (add.getText() == ButtonObject[i].powertext) {
                        add.setEnabled(zt);
                    }
                    if (edit.getText() == ButtonObject[i].powertext) {
                        edit.setEnabled(zt);
                    }
                    if (del.getText() == ButtonObject[i].powertext) {

                        del.setEnabled(zt);
                    }
                    if (sy.getText() == ButtonObject[i].powertext) {
                        sy.setEnabled(zt);
                    }
                    if (xy.getText() == ButtonObject[i].powertext) {
                        xy.setEnabled(zt);
                    }
                    if (px.getText() == ButtonObject[i].powertext) {
                        px.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    var grid = mini.get("datagrid1");
    grid.load();


    function addRow() {
        mini.open({
            url: "../ZiDian/ZiDian_Edit.aspx",
            title: "新增-客户等级", width: 350, height: 200,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add", YWLX: 'KHDJ' };
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

                url: "../ZiDian/ZiDian_Edit.aspx",
                title: "修改-客户等级", width: 350, height: 200,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.DJBH };
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
                        ids.push(r.DJBH);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "../../WindowsAspx/AspxDate.aspx?method=DeleteList&&DJBH=" + id,
                        success: function(text) {
                            var o = mini.decode(text);
                            if (o.messageid == -1) {
                                mini.alert("提示:删除错误!");
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
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function moveUp() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index - 1);
        }
    }
    function moveDown() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index + 2);
        }
    }
    function SaveDataOrder() {
        var GridData = grid.getData();
        var GridJson = mini.encode(GridData);
        $.ajax({
            url: "../../WindowsAspx/AspxDate.aspx?method=UpZiDian_XuHao&data=" + GridJson,
            success: function(text) {
                if (text != -1) {
                    grid.reload();
                }
                else {
                    mini.alert("数据操作出现问题!");
                }
            },
            error: function() {
            }
        });
    }
</script>

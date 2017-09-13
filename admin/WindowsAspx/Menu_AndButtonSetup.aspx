<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Menu_AndButtonSetup.aspx.cs" Inherits="WindowsAspx_Menu_AndButtonSetup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>菜单按钮添加</title>
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
  <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a class="mini-button" iconcls="icon-add" onclick="MenuButtonSave()" plain="true">确定</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-close" onclick="onCancel()" plain="true">关闭</a>
        <input id="parentid" name="parentid" class="mini-hidden" />
    </div>
 <div class="mini-fit">
    <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" 
         idField="GUID"
        allowResize="true" sizeList=[50,100,300,500] pagesize="50"
         allowCellSelect="true" multiSelect="true">
        <div property="columns">
            <div type="checkcolumn"></div>
            <div field="BUTTONICONNAME" width="120" headerAlign="center" allowSort="true">按钮图标
            </div>
             <div field="BUTTONNAME" width="120" headerAlign="center" allowSort="true">按钮名称
            </div>
             <div field="BUTTONTITLE" width="120" headerAlign="center" allowSort="true">按钮标题
            </div>
             <div field="BUTTONMIN" width="120" headerAlign="center" allowSort="true">执行函数
            </div>
             <div field="BUTTONIREMAK" width="120" headerAlign="center" allowSort="true">备注
            </div>
        </div>
        </div>
        </div>
</body>
</html>
<script type="text/javascript" language="javascript">
    //加载绑定
    mini.parse();
    var grid = mini.get("datagrid1");
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        mini.get("parentid").setValue(Request["parentid"]);
        grid.setUrl("AspxDate.aspx?method=Select_MenuPowerid&&parentid=" + mini.get("parentid").getValue());
        grid.load();
    });
    grid.on("drawcell", function(e) {
        //debugger;
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
        if (column.field == "BUTTONICONNAME") {
            e.cellHtml = "<img src='../scripts/miniui/themes/icons/" + record.BUTTONICONNAME + "' />";
        }
    });
    function MenuButtonSave() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定添加选择的按钮吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var buttonid = [], buttontext=[],buttonimg=[];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        buttonid.push(r.GUID);
                        buttontext.push(r.BUTTONNAME);
                        buttonimg.push(r.BUTTONICONNAME);
                    }
                    var buttonids = buttonid.join(',');
                    var buttontexts=buttontext.join(',');
                    var buttonimgs=buttonimg.join(',');
                    //grid.loading("操作中，请稍后......");
                    $.ajax({
                    url: "AspxDate.aspx?method=InsertDisButton&parentid=" + mini.get("parentid").getValue() + "&&buttonids=" + buttonids + "&&buttontexts=" + buttontexts + "&&buttonimgs=" + buttonimgs,
                        success: function(text) {
                            if (text != -1) {
                                mini.alert("设置成功!", "提示", function() {
                                    grid.reload();
                                }
                                    )

                            }
                            else {
                                mini.aelrt("操作数据出现错误!");
                            }
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
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function onOk() {
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("ok");
    } 
    </script>
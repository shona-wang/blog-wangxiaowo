<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-column.aspx.cs" Inherits="cms_column_add_column" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>栏目信息编辑</title>
    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
        #name {
            width: 347px;
        }
    </style>
</head>
<body>
    <%--隐藏字段--%>
    <form id="form1">
        <input id="id" name="id" class="mini-hidden" />
        <input id="pid" name="pid" class="mini-hidden" />
        <table>
            <tr>
                <td>栏目名称:
                </td>
                <td colspan="3">
                    <input id="name" name="name" class="mini-textbox" required="true" />
                </td>
            </tr>
            <tr>
                <td>链接地址:
                </td>
                <td>
                    <input id="url" name="url" class="mini-textbox" required="true" />
                </td>
                <td>状态：
                </td>
                <td>
                    <select name="status" class="mini-combobox" value="0">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </td>
            </tr>
        </table>
        <div style="text-align: center; padding: 10px;">
            <a id="OK" class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
            <a id="CANCEL" class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("form1");

    //与主页的接口函数
    function SetData(data) {
        //跨页面传递的数据对象，克隆后才可以安全使用
        data = mini.clone(data);
        if (data.action == "add") {
            mini.get("pid").setValue(data.pid);
        }
        if (data.action == "edit") {
            $.ajax({
                url: "../service/column.aspx?method=query&id=" + data.id,
                cache: false,
                success: function (text) {
                    var o = mini.decode(text);
                    form.setData(o[0]);
                }
            });
        }
    }

    //确定（保存）
    function onOk() {
        mini.get("OK").setEnabled(false);
        form.validate();
        if (!form.isValid()) {
            mini.get("OK").setEnabled(true);
            return;
        }
        var data = form.getData();
        if (data["id"] == "") {
            delete data.id;
        }
        $.ajax({
            url: "../service/column.aspx?method=insert",
            data: {data:mini.encode([data])},
            type: 'post',
            cache: false,
            success: function (text) {
                if (text != "-1") {
                    mini.alert("保存成功！", "提示",
                    function (action) {
                        if (action == "ok") {
                            CloseWindow("ok");
                        }
                    });
                }
                else {
                    mini.alert("保存失败！");
                    mini.get("OK").setEnabled(true);
                }
            }
        });
    }

    //取消
    function onCancel() {
        CloseWindow("cancel");
    }


    //关闭函数
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRolesDic_AddEdit.aspx.cs" Inherits="WindowsAspx_sysRolesDic_AddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色编辑</title>
     <script src="../scripts/boot.js" type="text/javascript"></script>
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
        <a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">保存关闭</a>
          <span class="separator"></span>
          <a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">保存继续</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow"
            plain="true">关闭</a>
            
    </div>
    <form id="form1">
    <table style="width: 684px">
         <% = Html("sysRolesDic")%>
        <tr>
            <td colspan="4" style="text-align: center;">
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJKEY" name="DJKEY" class="mini-hidden" />
                <input id="FL" name="FL" class="mini-hidden" /><br />
                <input id="ROLEID" name="ROLEID" class="mini-hidden" />
                <%= HiddenText %>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
    function SaveData(e) {
        var ButtonText = e.sender.text;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
            url: "AspxDate.aspx?method=sysRolesDicSave",
            data: { data: json },
            cache: false,
            success: function(text) {
                if (text > 0) {
                    if (ButtonText == "保存继续") {
                        mini.alert("保存成功,您可以继续添加!");
                        inputClert();
                    }
                    else {
                        CloseWindow();
                    }
                }
                else {
                    mini.alert("保存数据出现错误!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    ////////////////////
    //标准方法接口定义
    function SetData(data) {
        if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
            $.ajax({
            url: "AspxDate.aspx?method=sysRolesDic_Where&RoleID=" + data.RoleID,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    mini.get("FL").setValue(data.FL);
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
            mini.get("FL").setValue(data.FL);
        }
    }
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }
    function inputClert() {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.name != "FL") {
                c.setValue('');
            }
        }
        mini.get("mytype").setValue("Add");
    }
</script>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserInformation_Edit.aspx.cs" Inherits="DynamicForm_UserInformation_UserInformation_Edit" %>

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
        .style1
        {
            width:239px;
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
         <% = Html("UserInformation") %>
        <tr>
            <td colspan="4" style="text-align: center;">
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJKEY" name="DJKEY" class="mini-hidden" />
                <input id="FL" name="FL" class="mini-hidden" /><br />
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
    //关闭
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();
    }
    
    //标准方法接口定义
    function SetData(data) {
        //debugger;
        if (data.action == "edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
            $.ajax({
                url: "UserInformationData.aspx?method=UserInformation_Json_SelectWhere&&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("YHM").setText(o.XX);
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
    function SaveData(e) {
        var ButtonText=e.sender.text;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "UserInformationData.aspx?method=UserInformation_Insert",
            data: { data: json },
            cache: false,
            type: "post",
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
            }
        });
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
    function onYHMButtonEdit(e) {
        var btnEdit = this;
        mini.open({
            url: "UserSinglePossessive.aspx",
            showMaxButton: false,
            title: "用户选择",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                        btnEdit.setValue(data.YHM);
                        btnEdit.setText(data.XX);
                        mini.get("XX").setValue(data.XX);
                    }
                }
            }
        });
    }
</script>


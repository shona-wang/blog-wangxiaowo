<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pwd_Setup.aspx.cs" Inherits="WindowsAspx_Pwd_Setup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户密码设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a class="mini-button" iconcls="icon-save" onclick="MiMaUp" plain="true">设置为用户名</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-save" onclick="MiMaUp"
            plain="true">系统默认密码</a> <span class="separator"></span><a class="mini-button" iconcls="icon-save"
                onclick="MiMaUp" plain="true">修改密码</a> <span class="separator"></span><a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
                  
    </div>
     <fieldset id="Fieldset1">
        <legend>设置密码</legend>
    <div id="loginForm" style="padding: 15px; padding-top: 10px; text-align:center">
    <span id="spanxx" style="color:Red;"></span><br />
          &nbsp;&nbsp;&nbsp;新密码:
        <input id="Xpwd" name="Xpwd" class="mini-password" requirederrortext="新密码不能为空" required="true"
            style="width: 150px;" /><br />
        确认密码:
        <input id="QXpwd" name="QXpwd" class="mini-password" requirederrortext="确认密码不能为空"
            required="true" style="width: 150px;" /><br />
            <input id="yhm" name="yhm" class="mini-hidden" />  
            <input id="type" name="type" class="mini-hidden" /> 
    </div>
    </fieldset>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    $(window).load(function() {
        var Request = new QueryString();
        mini.get("yhm").setValue(Request["yhm"]);
        yhxx(Request["xx"]);
    });
    function yhxx(xx) {
        $.ajax({
            url: "AspxDate.aspx?method=jszd",
            type: "post",
            data: { Cols: xx },
            success: function(text) {
            $("#spanxx").html("用户为:[" + text + "]");
            },
            error: function() {
            }
        });
        
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function MiMaUp(e) {
        //debugger;
        var form = new mini.Form("#loginForm");
        if (e.source.text == "设置为用户名") {
            mini.get("type").setValue("yhm");
        }
        if (e.source.text == "系统默认密码") {
            mini.get("type").setValue("mrmm");
        }
        if (e.source.text == "修改密码") {
            form.validate();
            if (form.isValid() == false) return;
            var Xpwd = mini.get("Xpwd");
            var QXpwd = mini.get("QXpwd");
            if (Xpwd.getValue() != QXpwd.getValue()) {
                mini.alert("两次密码输入不一致!");
                return;
            }
           mini.get("type").setValue("update");
        }
        var o = form.getData();
        var json = mini.encode([o]);
        $.ajax({
            url: "AspxDate.aspx?method=PwdSetup",
            data: { data: json },
            success: function(text) {
                //debugger;
                if (text == "1") {
                    //mini.alert("保存成功！");
                    mini.alert("设置成功!", "提示", function()
                    { CloseWindow(); }
                )
                }
                else {
                    mini.alert("设置失败!");
                    form.reset();
                }
            }
        });
    }
</script>
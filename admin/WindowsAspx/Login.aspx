<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="WindowsAspx_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><%= WinTitleName() %></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../JavaScript/GRInstall.js" type="text/javascript"></script>

    <script src="../scripts/boot.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 57px;
            text-align: right;
        }
        body
        {
            background-image: url(../Images/bj.gif);
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
        }
        .style2
        {
            width: 57px;
        }
        #AccountNum
        {
            width: 151px;
        }
        #Code
        {
            width: 49px;
        }
    </style>
</head>
<body>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td width="626" height="169">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td width="626" height="266" background="../Images/dl3.jpg">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 300px;">
                            &nbsp;
                        </td>
                        <td>
                            <div id="loginForm" style="padding: 15px; padding-top: 90px;">
                                <table>
                                    <tr>
                                        <td class="style1">
                                            <label for="username$text">
                                                帐号:</label>
                                        </td>
                                        <td>
                                            <input id="username" name="username" class="mini-textbox" required="true" requirederrortext="登录账号不能为空"
                                                style="width: 150px;" onenter="onpwdenter" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style1">
                                            <label for="pwd$text">
                                                密码:</label>
                                        </td>
                                        <td>
                                            <input id="pwd" name="pwd" class="mini-password" requirederrortext="密码不能为空" required="true"
                                                style="width: 150px;" onenter="onLoginClick" />
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style1">
                                           帐套号:
                                        </td>
                                        <td>
                                           <input id="AccountNum" name="AccountNum" class="mini-combobox" textfield="DWMC" valuefield="AccountNum"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                        </td>
                                        <td style="padding-top: 7px; padding-left: 10px;">
                                            <a onclick="onLoginClick" class="mini-button" style="width: 60px; padding-left">登录</a>
                                            <a onclick="onResetClick" class="mini-button" style="width: 60px;">重置</a><input id="Code" name="Code" class="mini-hidden" /><br />
                                            注:本系统建议使用<a href='../UploadFiles/谷歌浏览器130705.rar' target='_blank'>Chrome浏览器</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    $(window).load(function() {
        mini.get("username").focus();
        var AccountNum = mini.get("AccountNum");
        AccountNum.setUrl("../AccountNum/DWXXTABLE/DWXXTABLEData.aspx?method=DWXXTABLE_Json_getSelectWhere");
        AccountNum.select(0);
    });
    function onpwdenter() {
        mini.get("pwd").focus();
    }

    function onLoginClick() {
        //debugger;
        var form = new mini.Form("#loginForm");
        form.validate();
        if (form.isValid() == false) return;
//        var yhm = mini.get("username").getValue();
//        var pwd = mini.get("pwd").getValue();
        //        var Code = ""; // mini.get("T_Code").getValue();
        //debugger;
        var o = form.getData();
        var json = mini.encode([o]);
        $.ajax({
            url: "Login_Data.aspx?method=RepeatLogin",
            type: "post",
            data: { data: json },
            success: function(text) {
                var o = mini.decode(text);
                var cou = o.messageid;
                if (cou == 1) {
                    var _urlmenu = mini.Cookie.get("Menu");
                    if (_urlmenu != null && _urlmenu != "") {
                        window.location = _urlmenu; //
                    } else {
                        window.location = "Menuindex.aspx"
                    }
                } else {

                    mini.get("username").setValue();
                    mini.get("pwd").setValue();
                    mini.alert(o.messageContent);
                    mini.get("username").focus();
                }
            }
        });
    }
    function onResetClick() {
        var form = new mini.Form("#loginForm");
        form.clear();
    }
    //验证码
    function GetValCode(control) {
        var date = new Date();
        control.src = "Number.ashx?" + date.getTime();
    }
</script>


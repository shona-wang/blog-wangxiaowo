<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPbc.aspx.cs" Inherits="WindowsAspx_LoginPbc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%= WinTitleName() %></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../JavaScript/GRInstall.js" type="text/javascript"></script>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            width: 57px;
            text-align: right;
            font-size: 20px;
            font-weight: bold;
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
            width: 42px;
        }
        #Code
        {
            width: 49px;
        }
        #username
        {
            width: 43px;
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
                <table border="0" cellpadding="0" cellspacing="0" style="width: 99%">
                    <tr>
                        <td style="width: 300px;">
                            &nbsp;
                        </td>
                        <td>
                            <div id="loginForm" style="padding: 15px; padding-top: 90px;">
                                <table>
                                    <tr>
                                        <td class="style1">
                                            刷<br />
                                            卡
                                        </td>
                                        <td>
                                            <input id="kh_text" name="kh_text" style="height:45px; font-size:20px; font-weight:bold;" onkeypress="EnterPress(event)" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                        </td>
                                        <td style="padding-top: 7px; padding-left: 10px;">
                                            <a onclick="onLoginClick" class="mini-button" style="width: 60px; padding-left">登录</a>
                                            <a onclick="onResetClick" class="mini-button" style="width: 60px;">重置</a><input id="Code"
                                                name="Code" class="mini-hidden" /><input id="Code" name="Code" class="mini-hidden" />
                                            <input id="AccountNum" name="AccountNum" class="mini-hidden" value="009" />
                                             <input id="username" name="username" class="mini-hidden"/>
                                            <br />
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
    $("#kh_text").focus();
      
    });
    function EnterPress(e) { //传入 event
            var e = e || window.event;
            if (e.keyCode == 13) {
                onLoginClick();
            }
    }
    function onLoginClick() {
        var u = $("#kh_text").val();
        if (u != '') {
            var form = new mini.Form("#loginForm");
            mini.get("username").setValue(u);
            var o = form.getData();
            var json = mini.encode([o]);
            $.ajax({
                url: "Login_Data.aspx?method=UserLogin_PayByCard",
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
                        mini.get("username").setValue('');
                        $("#kh_text").val('');
                        mini.alert(o.messageContent);
                        $("#kh_text").focus();
                    }
                }
            });
        }
    }
    function onResetClick() {
        $("#kh_text").val('');
        $("#kh_text").focus();
        var form = new mini.Form("#loginForm");
        form.clear();
        
    }
</script>


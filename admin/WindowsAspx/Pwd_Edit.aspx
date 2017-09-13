<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pwd_Edit.aspx.cs" Inherits="WindowsAspx_Pwd_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>密码修改</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../scripts/boot.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
    var $pwd = $('input[name="Xpwd"]');
        $pwd.passwordStrength();
        //        $(".Generate_password").click(function() {
        //            //产生随机八位密码
        //            var pwd = $.passwordStrength.getRandomPassword(8);
        //            //将随机密码写入密码框，并触发验证
        //            $pwd.val(pwd).trigger("keyup");
        //            return false;
        //        })
    });
    $.fn.passwordStrength = function(options) {
        var PW_Strength;
        return this.each(function() {
            var that = this; that.opts = {};
            that.opts = $.extend({}, $.fn.passwordStrength.defaults, options);

            that.div = $(that.opts.targetDiv);
            that.defaultClass = that.div.attr('class');

            that.percents = (that.opts.classes.length) ? 100 / that.opts.classes.length : 100;
            v = $(this).keyup(function() {
                if (typeof el == "undefined")
                    this.el = $(this);
                var s = getPasswordStrength(this.value);
                var p = this.percents;
                var t = Math.floor(s / p);
                if (100 <= s) t = this.opts.classes.length - 1;
                PW_Strength = t + 1;
                this.div.removeAttr('class').addClass(this.defaultClass).addClass(this.opts.classes[t]);
            });

            //鍏夋爣澶辩劍
            $(this).blur(function() {
                CheckPW($(this));
            });
        });

        function CheckPW(obj) {
            if (obj.val().length < 6) {
                //mini.alert('密码长度太短！');
                obj.select();
                return false;
            }
            if (PW_Strength < 8) {
                //mini.alert('密码强度不够,建议重设!');
                obj.select();
                return false;
            }
        }
        //鑾峰彇瀵嗙爜寮哄害
        function getPasswordStrength(H) {
            var D = (H.length);
            if (D > 5) {
                D = 5
            }
            var F = H.replace(/[0-9]/g, "");
            var G = (H.length - F.length);
            if (G > 3) { G = 3 }
            var A = H.replace(/\W/g, "");
            var C = (H.length - A.length);
            if (C > 3) { C = 3 }
            var B = H.replace(/[A-Z]/g, "");
            var I = (H.length - B.length);
            if (I > 3) { I = 3 }
            var E = ((D * 10) - 20) + (G * 10) + (C * 15) + (I * 10);
            if (E < 0) { E = 0 }
            if (E > 100) { E = 100 }
            return E
        }

    };

    $.fn.passwordStrength.defaults = {
        classes: Array('is10', 'is20', 'is30', 'is40', 'is50', 'is60', 'is70', 'is80', 'is90', 'is100'), //鏍峰紡鍚�
        targetDiv: '#passwordStrengthDiv',
        cache: {}
    }
    $.passwordStrength = {};
    $.passwordStrength.getRandomPassword = function(size) {
        var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var size = size || 8;
        var i = 1;
        var ret = ""
        while (i <= size) {
            $max = chars.length - 1;
            $num = Math.floor(Math.random() * $max);
            $temp = chars.substr($num, 1);
            ret += $temp;
            i++;
        }
        return ret;
    }
</script>
<style type="text/css">
#passwordStrengthDiv{margin-top:6px;}
.is0{background:url(progressImg1.png) no-repeat 0 0;width:138px;height:7px;}
.is10{background-position:0 -7px;}
.is20{background-position:0 -14px;}
.is30{background-position:0 -21px;}
.is40{background-position:0 -28px;}
.is50{background-position:0 -35px;}
.is60{background-position:0 -42px;}
.is70{background-position:0 -49px;}
.is80{background-position:0 -56px;}
.is90{background-position:0 -63px;}
.is100{background-position:0 -70px;}
</style>
</head>
<body>
    <div id="tabs1" class="mini-tabs" activeindex="0" style="width: 100%; height:auto;">
        <div name="first" title="密码修改">
            <div style="width: 500px;">
                <div class="mini-toolbar">
                    <a class="mini-button" iconcls="icon-cut" onclick="onResetClick()" plain="true">重置</a>
                    <span class="separator"></span><a class="mini-button" iconcls="icon-save" onclick="onLoginClick()"
                        plain="true">保存</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                            onclick="CloseWindow()" plain="true">关闭</a>
                </div>
            </div>
            <fieldset id="fd1" style="width: 470px;">
                <legend>修改密码</legend>
                <div id="loginForm" style="padding: 15px; padding-top: 10px;">
                    <table>
                        <tr>
                            <td>
                                新密码:
                            </td>
                            <td>
                            <div id="passwordStrengthDiv" class="is0"></div>  
                                <input id="Xpwd" name="Xpwd" class="mini-password" requirederrortext="新密码不能为空" required="true"
                                    style="width: 150px;" /> 
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                确认密码:
                            </td>
                            <td>
                                <input id="QXpwd" name="QXpwd" class="mini-password" requirederrortext="确认密码不能为空"
                                    required="true" style="width: 150px;" /><br />
                            </td>
                        </tr>
                          <tr>
                            <td>
                                旧密码:
                            </td>
                            <td>
                                <input id="Jpwd" name="Jpwd" class="mini-password" required="true" requirederrortext="旧密码不能为空"
                                    style="width: 150px;" /><br />
                                 <span style="color:Red;">说明:新密码必须大于8位!</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
        </div>
        <div title="个性化设置">
            <fieldset id="Fieldset1" style="width: 470px;">
                <legend>设置信息</legend>菜单显示模式:
                <select id="_Menu" onchange="onMenuChange(this.value)" style="width: 200px;">
                    <option value="MenuindexBar.aspx">顶部</option>
                    <option value="Menuindex.aspx">左侧</option>
                </select><br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 皮肤设置:
                <select id="selectSkin" onchange="onSkinChange(this.value)" 
                    style="width: 200px;">
                    <option value="">Default</option>
                    <option value="blue">Blue</option>
                    <option value="gray">Gray</option>
                    <option value="olive2003">Olive2003</option>
                    <option value="blue2003">Blue2003</option>
                    <option value="blue2010">Blue2010</option>
                    <option value="purple">purple</option>
                    <option value="bootstrap">Bootstrap</option>
                    <option value="metro">metro</option>
                    <option value="metro-green">metro-green</option>
                    <option value="metro-orange">metro-orange</option>
                    <option value="jqueryui-uilightness">jqueryui-uilightness</option>
                    <option value="jqueryui-humanity">jqueryui-humanity</option>
                    <option value="jqueryui-excitebike">jqueryui-excitebike</option>
                    <option value="jqueryui-cupertino">jqueryui-cupertino</option>
                </select>
            </fieldset>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    function onLoginClick() {
        var form = new mini.Form("#loginForm");
        form.validate();
        if (form.isValid() == false) return;

        var Jpwd = mini.get("Jpwd");
        var Xpwd = mini.get("Xpwd");
        var QXpwd = mini.get("QXpwd");
        if (Xpwd.getValue() == QXpwd.getValue()) {
            $.ajax({
                url: "AspxDate.aspx?method=PwdEdit&Jpwd=" + Jpwd.getValue() + "&Xpwd=" + Xpwd.getValue(),
                //type: "post",
                success: function(text) {
                    var o = mini.decode(text);
                    var cou = o.messageid;
                    if (cou == 1) {
                        mini.alert("密码修改成功,请牢记!");
                    } else {
                        mini.alert(o.messageContent);
                    }
                }
            });
        }
        else {
            mini.alert("两次密码输入不一致!");
        }
    }
    function onResetClick() {
        var form = new mini.Form("#loginForm");
        form.clear();
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    window.onload = function onLoad() {
        var skin = mini.Cookie.get("Menu");
        if (skin) {
            var selectSkin = document.getElementById("_Menu");
            if (selectSkin != null) {
                selectSkin.value = skin;
            }
        }
        var _skin = mini.Cookie.get("miniuiSkin");
        if (_skin) {
            var _selectSkin = document.getElementById("selectSkin");
            if (_selectSkin != null) {
                _selectSkin.value = _skin;
            }
        }
    }
</script>


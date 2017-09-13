<%@ Page Language="C#" AutoEventWireup="true" CodeFile="user_Empsetup.aspx.cs" Inherits="WindowsAspx_user_Empsetup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户部门设置</title>
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
        #btnEdit1
        {
            width: 352px;
        }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a class="mini-button" iconcls="icon-add" onclick="UserEmpSetUp" plain="true">确定</a> <span
            class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()"
                plain="true">关闭</a>
    </div>
    <fieldset id="Fieldset1">
        <legend>设置部门</legend>
       <div id="loginForm">
        <span id="spanxx" style="color: Red;"></span><br />
        选择部门:
        <input id="btnEdit1" name="bmbm" class="mini-buttonedit" onbuttonclick="onButtonEdit"
            allowinput="false" 
            required="true"/><br />
             <input id="yhm" name="yhm" class="mini-hidden" />  
             </div>
    </fieldset>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        mini.get("yhm").setValue(Request["yhm"]);
        yhxx(Request["xx"]);
    });
    var btnEdit = mini.get("btnEdit1");
   
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
    //部门选择
    function onButtonEdit(e) {
        //var btnEdit = this;
        mini.open({
            url: "EmpTree.aspx",
            showMaxButton: false,
            title: "选择树",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                        debugger;
                        //var dwid = _dwid(data.id);
                        btnEdit.setValue(data.DWID);
                        btnEdit.setText(data.TEXT);
                    }
                }
            }
        });
    }
    function _dwid(id) {
        $.ajax({
            url: "AspxDate.aspx?method=get_table38&JDDM=" + id,
            type: "post",
            cache: false,
            success: function(text) {
                //debugger;
                btnEdit.setValue(text);
            }
        });
    }
  
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function UserEmpSetUp(e) {
        var form = new mini.Form("#loginForm");
        form.validate();
        if (form.isValid() == false) return;
        var o = form.getData();
        var json = mini.encode([o]);
        $.ajax({
        url: "AspxDate.aspx?method=UserEmpSetUp",
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


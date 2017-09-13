<%@ Page Language="C#" AutoEventWireup="true" CodeFile="access_token_index.aspx.cs" Inherits="WeiXinAspx_WeiXin_AccountContro_access_token_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>access_token获取设置</title>
         <script src="../../scripts/boot.js" type="text/javascript"></script>
      <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
    <style type="text/css">
        #AppID
        {
            width: 900px;
        }
        #AppSecret
        {
            width: 900px;
        }
        #access_token
        {
            width: 900px;
        }
    </style>
</head>
<body>
<div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">保存</a> 
  </div>
<fieldset id="fd1" style="width: 98%;">
      <legend>内容</legend>
      <form id="form1">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AppID:<input id="AppID" name="AppID" class="mini-textbox" required="true"/><br />
        &nbsp;&nbsp;&nbsp;
        AppSecret:<input id="AppSecret" name="AppSecret" class="mini-textbox" required="true"/><br />
        access_token:<input id="access_token" name="access_token" class="mini-textbox"/><br />
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="WeiXinCode" name="WeiXinCode" class="mini-hidden" />
      </form>
 </fieldset>
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
    $(window).load(function() {
        var Request = new QueryString();
        mini.get("WeiXinCode").setValue(Request["WeiXinCode"]);
        loadset();

    });
    function loadset() {
        $.ajax({
            url: "WeiXin_MessageWelcomeData.aspx?method=WeiXin_MessageWelcome_Json_SelectWhere&DJBH=" + mini.get("WeiXinCode").getValue(),
            cache: false,
            success: function(text) {
                debugger;
                if (text != "") {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                }
                else {
                    mini.get("mytype").setValue("Add");
                }
            }
        });
    }
    //保存函数
    function SaveData() {
        //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "WeiXin_MessageWelcomeData.aspx?method=WeiXin_MessageWelcome_access_token",
            data: { data: json },
            type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("提示:数据操作失败!");
                }
                else {
                    mini.alert("提示:设置成功!");
                    loadset();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }



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
 </script>

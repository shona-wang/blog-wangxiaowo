<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Parameter_SDSZ.aspx.cs" Inherits="WindowsAspx_ParameterSetting_Parameter_SDSZ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>密码锁定设置</title>
       <script src="../../scripts/boot.js" type="text/javascript"></script>  <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
      .mini-combobox
      {
          height: 24px;
          width: 128px;
      }
      #SRM
      {
          width: 129px;
      }
    </style>
</head>
<body>
     <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a id="ok" class="mini-button" iconcls="icon-ok" onclick="SaveData" plain="true">确定</a>
    </div>
    <fieldset id="Fieldset1">
        <legend>设置</legend>
        <span id="form1">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        密码锁定: <select id="LXZ" name="LXZ" class="mini-combobox" onvaluechanged="onsfChanged" value="0">
                    <option value="否">否</option>
                    <option value="是">是</option>
                </select><br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        最大次数: <input id="GLSZ_A" name="GLSZ_A" class="mini-spinner"  minValue="1" maxValue="10000" />
        <input id="LXMC" name="LXMC" class="mini-hidden"/>
        <input id="mytype" name="mytype" class="mini-hidden" value="Edit"/>
        <input id="DJKEY" name="DJKEY" class="mini-hidden" value="Edit"/>
        </span>
    </fieldset>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
    $(window).load(function() {
        GetAjaxData();
    });
    function GetAjaxData()
    {
        $.ajax({
            url: "ParameterSetting_Data.aspx?method=get_Parameter&&LXMC=是否启用密码锁定",
            type: "post",
            success: function(text) {
                var o = mini.decode(text);
                form.setData(o);
            }
        });    }    function SaveData() {
        var o = form.getData();
        var json = mini.encode([o]);
        $.ajax({
        url: "ParameterSetting_Data.aspx?method=SaveParameter",
            data: { data: json },
            cache: false,
            type: "post",
            success: function(text) {
                if (text > 0) {
                    mini.alert("设置成功!");
                }
                else {
                    mini.alert("设置出现错误!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }</script>
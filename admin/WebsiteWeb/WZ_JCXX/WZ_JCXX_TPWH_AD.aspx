<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_TPWH_AD.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_TPWH_AD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>投票维护</title>
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <style type="text/css">
        html, body
        {
            font-size: 12px;
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
  <form id="form1">
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <a class="mini-button" iconcls="icon-save" onclick="save">保存</a> <span class="separator">
                    </span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow">关闭</a>
                </td>
            </tr>
        </table>
    </div>
    <fieldset style="width:500px;border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>详细信息</legend>
        <div id="editForm1" style="padding:5px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:80px;">主题：</td>
                    <td style="width:300px;"><input id="ID" name="ID" class="mini-textbox" style="width:200px" visible="false" /><input id="TPZT" name="TPZT" class="mini-textbox" style="width:200px" required="true" requiredErrorText="投票主题"/></td>
                </tr>
                <tr>
                    <td>设置当前投票：</td>
                    <td><div id="SFYC" name="SFYC" class="mini-radiobuttonlist" repeatItems="2" repeatLayout="table" repeatDirection="vertical" textField="text" valueField="id" value=""  url="../WZ_JCXX/TP1.txt" ></div></td>
                </tr>
                <tr>
                    <td>单选多选：</td>
                     <td>
                        <div id="DXDX" name="DXDX" class="mini-radiobuttonlist" repeatItems="2" repeatLayout="table" repeatDirection="vertical" textField="text" valueField="id" value=""  url="../WZ_JCXX/TP2.txt" ></div>
                     </td>
                </tr>
            </table>
        </div>
    </fieldset>
    <input type="hidden" name="_state" id="_state" />
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    //////////////////////////////////////////////////////

    //起草合同
    //起草合同
    function save() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;
        var tpzt = mini.get("TPZT").getValue();
        if (tpzt == "") {
            alert("必须录入投票主题!");
            return;
        }
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveTPZB",
            data: { state: _state, Json: json },
            type: "post",
            cache: false,
            success: function(text) {
                //成功
                var mes = mini.decode(text);
                if (mes.messageid == 1) {
                    //alert("保存成功!");
                    CloseWindow("save");
                }
                else {
                    mini.alert("保存失败!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    
    //标准方法接口定义
    function SetData(data) {
        debugger;
        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=OpenTP&IDH=" + data.IDH + "",
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.get("ID").setValue(o.ID);
                    mini.get("TPZT").setValue(o.TPZT);
                    mini.get("SFYC").setValue(o.SFYC);
                    mini.get("DXDX").setValue(o.DXDX);
                }
            });
        }
    }
    
    function GetData() {
        var o = form.getData();
        return o;
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow)
            window.CloseOwnerWindow(action);
        else window.close();
    }

    //关闭
    function onCloseClick(e) {
        var lookup2 = mini.get("lookup2");
        lookup2.hidePopup();
    }
</script>

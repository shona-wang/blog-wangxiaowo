<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_LMGL_LMWH_AM.aspx.cs"
    Inherits="WZ_LMGL_WZ_LMGL_LMWH_AM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网站栏目维护</title>

    <script type="text/javascript" src="../../scripts/boot.js"></script>

    <script src="../../swfupload/swfupload.js" type="text/javascript"></script>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
        html, body
        {
            font-size: 12px;
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
        }
        #FLMBH
        {
            width: 337px;
        }
        .style1
        {
            width: 112px;
        }
        #LMMC
        {
            width: 336px;
        }
        #LMXH
        {
            width: 335px;
        }
        #TZDZ
        {
            width: 335px;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">
    <div id="editForm1" style="padding: 5px;">
        <table style="text-align: right; width: 550px;">
            <tr>
                <td class="style1">
                    上级栏目：
                </td>
                <td style="text-align: left;">
                    <input id="FLMBH" name="FLMBH" class="mini-buttonedit" onbuttonclick="onButtonEdit"
                        allowinput="false" required="true" />
                    <a class="mini-button" iconcls="icon-upgrade" onclick="Clert()"></a>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    栏目名称：
                </td>
                <td style="text-align: left;">
                    <input id="LMMC" name="LMMC" class="mini-textbox"  required="true"
                        requirederrortext="栏目名称不能为空" />
                </td>
            </tr>
            <tr>
                <td class="style1">
                    栏目序号：
                </td>
                <td style="text-align: left">
                    <input id="LMXH" name="LMXH" class="mini-spinner" minvalue="1" maxvalue="10000" />
                </td>
            </tr>
            <tr>
                <td class="style1">
                    链接地址：
                </td>
                <td style="text-align: left">
                    <input id="TZDZ" name="TZDZ" class="mini-textbox"  />
                </td>
            </tr>
            <tr>
                <td class="style1">
                    是/否导航栏目：
                </td>
                <td style="text-align: left">
                    <div id="SFYC" class="mini-radiobuttonlist" repeatitems="2" repeatlayout="table"
                        repeatdirection="hertical" textfield="text" valuefield="id" value="0" url="../WZ_LMGL/select.txt">
                    </div>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    是/否专题栏目：
                </td>
                <td style="text-align: left">
                    <div id="ZTBZ" class="mini-radiobuttonlist" repeatitems="2" repeatlayout="table"
                        repeatdirection="hertical" textfield="text" valuefield="id" value="0" url="../WZ_LMGL/select.txt">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <a class="mini-button" iconcls="icon-save" onclick="save">保存</a> <a class="mini-button"
                        iconcls="icon-close" onclick="CloseWindow">关闭</a>
                    <input type="hidden" name="_state" id="_state" />
                    <input id="LMBH" name="LMBH" class="mini-hidden" style="text-align: left">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    //    $(window).load(function() {
    //    });
    //////////////////////////////////////////////////////
    var btnEdit = mini.get("FLMBH");
    //部门选择
    function onButtonEdit(e) {
        mini.open({
            url: "../WebsiteWeb/WZ_NRGL/WZ_NRGL_LMSel.aspx",
            title: "选择栏目",
            width: 600,
            height: 500,
            ondestroy: function(action) {
                if (action == "ok") {

                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //必须
                    if (data) {
                        btnEdit.setValue(data.LMBH);
                        btnEdit.setText(data.LMMC);
                    }
                }

            }
        });
    }
    //保存
    function save() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;

        var lmbh = mini.get("LMBH").getValue();
        var lmmc = mini.get("LMMC").getValue();
        if (lmmc == "") {
            mini.alert("栏目名称必须录入!");
            return;
        }
        var sfjt = "0"; //mini.get("SFJT").getValue();
        var sfdh = mini.get("SFYC").getValue();
        var sfzt = mini.get("ZTBZ").getValue();
        //        var sfjszl = mini.get("sfjszl").getValue();

        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveLMInfo",
            data: { data: json, state: _state, lmbh: lmbh, sfjt: sfjt, sfdh: sfdh, sfzt: sfzt },
            type: "post",
            cache: false,
            success: function(text) {
                debugger;
                //成功
                //var mes = mini.decode(text);
                if (text == 1) {
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
        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenLMInfo&LMBH=" + data.LMBH + "",
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    btnEdit.setValue(o.FLMBH);
                    btnEdit.setText(o.FLMMC);
                    mini.get("LMMC").setValue(o.LMMC);
                    mini.get("LMBH").setValue(o.LMBH);
                    mini.get("LMXH").setValue(o.LMXH);
                    mini.get("TZDZ").setValue(o.TZDZ);

                    mini.get("SFYC").setValue(o.SFYC);
                    mini.get("ZTBZ").setValue(o.ZTBZ);
                }
            });
        }
        else {
            btnEdit.setValue(data.FLMBH);
            btnEdit.setText(data.FLMMC);
        }
    }

    function GetData() {
        var o = form.getData();
        return o;
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }

    //关闭
    function onCloseClick(e) {
        var lookup2 = mini.get("lookup2");
        lookup2.hidePopup();
    }
    function Clert() {
        btnEdit.setValue('');
        btnEdit.setText('');
    }
</script>


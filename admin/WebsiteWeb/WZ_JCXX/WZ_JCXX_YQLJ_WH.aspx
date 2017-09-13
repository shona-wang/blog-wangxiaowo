<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_YQLJ_WH.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_YQLJ_WH" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>友情链接维护</title>
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
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">
    <fieldset style="width:500px;border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>友情链接详细信息</legend>
        <div id="editForm1" style="padding:5px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:80px;">网站名称：</td>
                    <td style="width:300px;"><input id="ID" name="ID" class="mini-textbox" style="width:200px" visible="false" /><input id="WZMS" name="WZMS" class="mini-textbox" style="width:200px" required="true" requiredErrorText="网站名称"/></td>
                </tr>
                <tr>
                    <td>链接类型：</td>
                    <td><input id="FLBH" name="FLBH" class="mini-combobox" style="width:150px;" textField="FLMC" valueField="FLBH" emptyText="请选择..." url="../WZ_DealData/DataProcess.aspx?method=SelectYQLJCombo" value=""  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/></td>
                </tr>
                <tr>
                    <td>链接地址：</td>
                     <td>
                        <input id="LJDZ" name="LJDZ" class="mini-textbox" style="width:200px" required="true" requiredErrorText="链接地址"/>
                     </td>
                </tr>
            </table>
        </div>
    </fieldset>
        <!--按钮菜单功能-->
        <div style="text-align: center; padding: 10px;">
              <a class="mini-button" iconCls="icon-save" onclick="save()">保存</a>     
        </div>
    <input type="hidden" name="_state" id="_state" />
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    $(window).load(function() {
    });
    //////////////////////////////////////////////////////

    //起草合同
    function save() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;
        var wzmc = mini.get("WZMS").getValue();
        var ljdz = mini.get("LJDZ").getValue();
        var flbh = mini.get("FLBH").getValue();
        if (wzmc == "") {
            alert("必须录入网站描述!");
            return;
        }
        if (ljdz == "") {
            alert("必须录入链接地址!");
            return;
        }
        if (flbh == "") {
            alert("分类编号必须选择!");
            return;
        }
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveYQLJ",
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

        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=OpenYQLJ&IDH=" + data.IDH + "",
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.get("ID").setValue(o.ID);
                    mini.get("WZMS").setText(o.WZMS);
                    mini.get("FLBH").setValue(o.FLBH);
                    mini.get("LJDZ").setText(o.LJDZ);
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
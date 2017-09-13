<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZiDian_Edit.aspx.cs" Inherits="ZiDian_ZiDian_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>字典编辑</title>

    <script src="../scripts/boot.js" type="text/javascript"></script>
<script src="../JavaScript/pinyin.js" type="text/javascript"></script>
    <style type="text/css">
        #MC
        {
            width: 254px;
        }
        #BZ
        {
            width: 252px;
            height: 85px;
        }
        #PYM
        {
            width: 254px;
        }
    </style>
</head>
<body>
    <form id="form1">
    <table>
        <tr>
            <td>
                名称:
            </td>
            <td>
                <input id="MC" name="MC" class="mini-textbox" required="fales"  onblur="Repeat()"/>
            </td>
        </tr>
        <tr>
            <td>
                拼音码:
            </td>
            <td>
                <input id="PYM" name="PYM" class="mini-textbox" enabled="false"/>
            </td>
        </tr>
        <tr>
            <td>
                备注:
            </td>
            <td>
                <input id="BZ" name="BZ" class="mini-textarea"  />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">关闭</a>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJBH" name="DJBH" class="mini-hidden" />
                <input id="YWLX" name="YWLX" class="mini-hidden" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");


    function SaveData() {
        var o = form.getData();

        form.validate();
        if (form.isValid() == false) return;

        var json = mini.encode([o]);
        $.ajax({
        url: "../WindowsAspx/AspxDate.aspx?method=ZDAdd",
            data: { data: json },
            cache: false,
            success: function(text) {

                if (text == -1) {
                    mini.alert("提示:数据操作失败!");
                }
                else {
                    mini.alert("提示:数据操作成功,可以继续录入!");
                    SaveAdd();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    ////////////////////
    //标准方法接口定义
    function SetData(data) {
        if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
            $.ajax({
            url: "../WindowsAspx/AspxDate.aspx?method=Select_WhereDJBH&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
            mini.get("YWLX").setValue(data.YWLX);
        }
    }
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }
    function SaveAdd() {
        mini.get("mytype").setValue("Add");
        mini.get("DJBH").setValue("");
        mini.get("MC").setValue("");
        mini.get("BZ").setValue("");
    }
    function Repeat() {
        var mc = mini.get("MC").getValue();
        var pym = codefans_net_CC2PY(mc);
        mini.get("PYM").setValue(pym);
    }
</script>


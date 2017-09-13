<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomePage_Manage_add.aspx.cs" Inherits="HomePage_Manage_HomePage_Manage_add" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>栏目信息编辑</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
        #BZ
        {
            width: 347px;
            height: 100px;
        }
        #LJDZ
        {
            width: 272px;
        }
        #SFDH2
        {
            width: 347px;
        }
    </style>
</head>
<body>
    <form id = "form1">
    <%--隐藏字段--%>
    <input id = "mytype" name="mytype" class ="mini-hidden" />
    <input id = "JDDM" name="JDDM" class ="mini-hidden" />
    <input id = "FJDDM" name="FJDDM" class ="mini-hidden" />
    <input id = "LRRYZH" name="LRRYZH" class ="mini-hidden" />
    <input id = "LRSJ" name="LRSJ" class ="mini-hidden" />
        <table>
        <tr>
            <td>
                栏目编号:
            </td>
            <td>
                <input id="LMBH" name="LMBH" class="mini-textbox" enabled="false"/>
            </td>
            <td>
                栏目名称:
            </td>
            <td>
            <input id="LMMC" name="LMMC" class="mini-textbox" required = "true"/>
            </td>
            <%--<td>
                栏目性质:
            </td>
            <td>
            <input id="LMXZ" name="LMXZ" class="mini-combobox" textField="mc" valueField="id"   url="../ZD/LMXZ.txt" enabled = "false" required = "true"/>
            </td>--%>
            </tr>
            <tr>
            <td>
                栏目序号:
            </td>
            <td>
                <input id="LMXH" name="LMXH" class="mini-textbox"/>
            </td>
            <td>
                是否首页导航:
            </td>
            <td>
            <input id="SFDH1" name="SFDH1" class="mini-combobox" required = "true" data = "renderSFDH" textfield = "text" valuefield = "id"/>
            </td>
            </tr>
            <tr>
            <td>
                是否公开课导航:
            </td>
            <td colspan="3">
                <input id="SFDH2" name="SFDH2" class="mini-combobox" required = "true" data = "renderSFDH" textfield = "text" valuefield = "id"/>
            </td>
            </tr>
            <tr>
            <td>
                链接地址:
            </td>
            <td colspan = "3">
            <input id="LJDZ" name="LJDZ" class="mini-textbox" required = "true"/>
            <a id = "YL" class="mini-button" onclick="YL()" iconcls = "icon-search" style="width: 60px; margin-right: 20px;">预览</a>
            </td>
        </tr>
        <tr>
            <td>
            备注:
            </td>
            <td colspan = "5">
                <input id="BZ" name="BZ" class="mini-textarea"/>
            </td>
        </tr>
        </table>
    </form>
    <div style="text-align: center; padding: 10px;">
        <a id = "OK" class="mini-button" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a>
        <a id = "CANCEL" class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("form1");
    var combobox_SFDH1 = mini.get("SFDH1");
    var combobox_SFDH2 = mini.get("SFDH2");
    var renderSFDH = [{ id: 1, text: '是' }, { id: 0, text: '否'}];
    combobox_SFDH1.setData(renderSFDH);
    combobox_SFDH2.setData(renderSFDH);
    
    
    //与主页的接口函数
    function SetData(data) {
        debugger;
        //跨页面传递的数据对象，克隆后才可以安全使用
        data = mini.clone(data);
        if (data.action == "add") {
            mini.get("mytype").setValue("Add");
           // mini.get("LMXZ").setEnabled(true);
            mini.get("FJDDM").setValue(data.FJDDM);
            mini.get("LMXH").setValue("0");
        }
        if (data.action == "edit") {
            $.ajax({
            url: "HomePage_Manage_data.aspx?method=SearchLMWH&JDDM=" + data.JDDM,
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                }
            });
        }
    }

   //确定（保存）
    function onOk() {
        mini.get("OK").setEnabled(false);
        form.validate();
        if (form.isValid() == false) {
            mini.get("OK").setEnabled(true);
            return;
        }
        debugger;
        var data = form.getData();
        var json = mini.encode([data]);
        $.ajax({
        url: "../HomePage_Manage/HomePage_Manage_data.aspx?method=InsertLMWH",
            data: { data: json },
            type: 'post',
            cache: false,
            success: function(text) {
                if (text != "-1") {
                    mini.alert("保存成功！", "提示",
                    function(action) {
                        debugger;
                        if (action == "ok") {
                            CloseWindow("ok");
                        }
                    });
                }
                else {
                    mini.alert("保存失败！");
                    mini.get("OK").setEnabled(true);
                }
            }
        });
    }
    
    //取消
    function onCancel() {
        CloseWindow("cancel");
    }
    
    //预览
    function YL() {
        var LJDZ = mini.get("LJDZ").getValue();
        window.open(LJDZ);
    }


    //关闭函数
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>
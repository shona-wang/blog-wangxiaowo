<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZD_Tree_Edit.aspx.cs" Inherits="ZiDian_ZD_Tree_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

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
        #btnEdit1
        {
            width: 186px;
        }
        .style1
        {
            width: 222px;
            height: 22px;
        }
        #JDMC
        {
            width: 182px;
        }
        .style2
        {
            height: 22px;
        }
        #DM
        {
            width: 184px;
        }
        #mytype
        {
            width: 60px;
        }
        #DJBH
        {
            width: 56px;
        }
        #YWLX
        {
            width: 60px;
        }
        #FJDDM
        {
            width: 185px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table style="text-align: right; width: 339px; height: 86px;">
        <tr>
            <td style="text-align: right;" class="style2">
                父节点
            </td>
            <td style="text-align: left;" class="style1">
                <input id="FJDDM" name="FJDDM" class="mini-buttonedit" onbuttonclick="onButtonEdit"
                    allowinput="false" />
                <a class="mini-button" iconcls="icon-upgrade" onclick="Clert()"></a>
            </td>
           
        </tr>
        <tr>
           <td style="text-align: right;" class="style2">
                名称
            </td>
            <td style="text-align: left;" class="style2">
                <input id="JDMC" name="JDMC" class="mini-textbox" required="true" />
            </td> 
        </tr>
         <tr>
            <td style="text-align: right;" class="style2">
                代码
            </td>
            <td style="text-align: left;" class="style2">
                <input id="DM" name="DM" class="mini-textbox" required="false" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">关闭</a>
            </td>
        </tr>
    </table>
     <input id="mytype" name="mytype" class="mini-hidden" />
     <input id="JDDM" name="JDDM" class="mini-hidden" />
     <input id="YWLX" name="YWLX" class="mini-hidden" />
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
    var btn = mini.get("FJDDM");
    //保存函数
    function SaveData() {
        //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
            url: "../WindowsAspx/AspxDate.aspx?method=KY_ZD_Tree_Insert",
            data: { data: json },
            type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("提示:数据操作失败!");
                }
                else {
                    mini.alert("提示:保存成功,可以继续添加!");
                    Clerts();
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
                url: "../WindowsAspx/AspxDate.aspx?method=getTreeDataWhere&JDDM=" + data.JDDM + "&&YWLX=" + data.YWLX,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    btn.setValue(o.FJDDM);
                    btn.setText(o.FJDMC);

                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
            mini.get("YWLX").setValue(data.YWLX);
            btn.setValue(data.JDDM);
            btn.setText(data.JDMC);
        }
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
    function Clert() {
        btn.setValue('');
        btn.setText('');
    }
    function onButtonEdit(e) {
        //var btnEdit = this;
        mini.open({
        url: "../ZiDian/ZD_TreeList_Index_.aspx?YWLX=" + mini.get("YWLX").getValue(),
            showMaxButton: false,
            title: "字典选择",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                        //var dwid = _dwid(data.ID);
                        btn.setValue(data.JDDM);
                        btn.setText(data.JDMC);
                    }
                }
            }
        });
    }
    function Clerts() {
        mini.get("JDDM").setValue('');
        mini.get("JDMC").setValue('');
        mini.get("mytype").setValue("Add");
        mini.get("DM").setValue('');
    }
</script>


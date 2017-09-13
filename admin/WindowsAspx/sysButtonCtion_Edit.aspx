<%@ Page Language="VB" AutoEventWireup="false" CodeFile="sysButtonCtion_Edit.aspx.vb" Inherits="WindowsAspx_sysButtonCtion_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>按钮维护</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 131px;
        }
        .style2
        {
            width: 259px;
        }
        #ButtonName
        {
            width: 221px;
        }
        #ButtonTiele
        {
            width: 221px;
        }
        #ButtonMin
        {
            width: 221px;
        }
        #Buttonicon
        {
            width: 221px;
        }
        #ButtonRemak
        {
            width: 221px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table width="300px;">
           <tr>
             <td class="style1">按钮名称:</td>
             <td class="style2">
             <input id="BUTTONNAME" name="BUTTONNAME" class="mini-textbox" required="fales" />
             </td>
           </tr>
           <tr>
             <td class="style1">按钮标题:</td>
             <td class="style2">
             <input id="BUTTONTIELE" name="BUTTONTIELE" class="mini-textbox"  />
             </td>
           </tr>
           <tr>
             <td class="style1">执行事件:</td>
             <td class="style2">
             <input id="BUTTONMIN" name="BUTTONMIN" class="mini-textbox" required="fales" />
             </td>
           </tr>
           <tr>
             <td class="style1">按钮图标:</td>
             <td class="style2">
            <%-- <input id="Buttonicon" name="Buttonicon" class="mini-textbox" required="fales" />--%>
             <input id="BUTTONICON" allowInput="false" name="BUTTONICON" class="mini-buttonedit" onbuttonclick="onMButtonEdit"  required="true"/>
             <input id="BUTTONICONNAME" name="BUTTONICONNAME" class="mini-hidden" />
             <img id="img"  src="#" alt=""/>
             </td>
           </tr>
           <tr>
             <td class="style1">按钮备注:</td>
             <td class="style2">
             <input id="BUTTONREMAK" name="BUTTONREMAK" class="mini-textbox" />
             </td>
           </tr>
           <tr>
             <td class="style1" colspan="2" style="text-align:center;"> 
             <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
                     iconcls="icon-close" onclick="CloseWindow">关闭</a>
                    <input id="mytype" name="mytype" class="mini-hidden" />
                 <input id="GUID" name="GUID" class="mini-hidden" />  
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
        url: "AspxDate.aspx?method=Insert_sysButtonCtion",
            data: { data: json },
            cache: false,
            success: function(text) {
                var Mes = mini.decode(text);
                if (Mes.messageid == 1) {
                    mini.alert("保存成功,您可以继续添加!");
                    SaveAdd();
                }
                else {
                    mini.alert(Mes.messageContent);
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
                url: "AspxDate.aspx?method=get_sysButtonCtionWhere&Guid=" + data.Guid,
                cache: false,
                success: function(text) {
                    //debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    $("#img").attr("src", "../scripts/miniui/themes/icons/"+o.BUTTONICONNAME);
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
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
        mini.get("BUTTONNAME").setValue("");
        mini.get("BUTTONTIELE").setValue("");
        mini.get("BUTTONMIN").setValue("");
        mini.get("BUTTONICON").setValue("");
        mini.get("BUTTONICON").setText("");
        mini.get("BUTTONREMAK").setValue("");
        mini.get("BUTTONICONNAME").setValue("");
    }
    //人员选择
    function onMButtonEdit(e) {
        //debugger;
        var btnEdit = this;
        mini.open({
        url: bootPATH + "../WindowsAspx/Icons_index.aspx",
            title: "图标选择",
            width: 300,
            height:600,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //必须
                    if (data) {
                        btnEdit.setValue(data.iconName);
                        btnEdit.setText(data.iconName);
                        mini.get("BUTTONICONNAME").setValue(data.icon);
                    }
                }
            }
        });
    }
</script>


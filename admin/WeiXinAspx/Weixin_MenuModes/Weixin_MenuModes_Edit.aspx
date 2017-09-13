 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Weixin_MenuModes_Edit.aspx.cs" Inherits="WeiXinAspx_Weixin_MenuModes_Weixin_MenuModes_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
<%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
--%>     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
             .style1
             {
                 width: 138px;
             }
             .style2
             {
                 width: 124px;
             }
             .style3
             {
                 width: 113px;
             }
             #SqlText
             {
                 width: 460px;
             }
             #DataTable
             {
                 width: 192px;
             }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 589px; height: 126px;">
    <tr>
     <td style="text-align:right;" class="style3"> Key���</td>
    <td style="text-align:left;" class="style1"><input id="MenuKey" name="MenuKey" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;" class="style2">��Ϣ����</td>
     <td style="text-align:left;"><%--<input id="MenuHftypy" name="MenuHftypy" class="mini-textbox" required="false"/>--%>
     <div id="MenuHftypy" name="MenuHftypy" class="mini-radiobuttonlist"  repeatDirection="vertical"
    textField="text" valueField="id" value="WB" 
    url="MessageType.txt" onvaluechanged="valuechanged">
     </td>
    </tr>
    <tr>
     <td style="text-align:right;" class="style3">��Ϣ����</td>
    <td style="text-align:left;" class="style1">
    <input id="MenuHfCount" name="MenuHfCount" class="mini-spinner" minValue="1" maxValue="8" required="false" enabled="false"/>
    </td>
    <td style="text-align:right;" class="style2">��ѯ�����ݱ�</td>
     <td style="text-align:left;"><input id="DataTable" name="DataTable" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;" class="style3">��ѯʱsql���</td>
    <td style="text-align:left;" class="style1" colspan="3"><input id="SqlText" name="SqlText" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td colspan="4" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">�ر�</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="ID" name="ID" class="mini-hidden" />
     </td>
     </tr>
   </table>
 </form>
 </body>
 </html>
 <script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
   //���溯��
    function SaveData() {
    //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "Weixin_MenuModesData.aspx?method=Weixin_MenuModes_Insert",
        data: { data: json },
        type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("��ʾ:���ݲ���ʧ��!");
                }
                else {
                    CloseWindow();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    ////////////////////
    //��׼�����ӿڶ���
    function SetData(data) {
       if (data.action == "Edit") {
            //��ҳ�洫�ݵ����ݶ��󣬿�¡��ſ��԰�ȫʹ��
            data = mini.clone(data);
            $.ajax({
                url: "Weixin_MenuModesData.aspx?method=Weixin_MenuModes_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("ID").setValue(data.DJBH);
                    mini.get("MenuKey").disable();
                    if (o.MenuHftypy == "TW") {
                        mini.get("MenuHfCount").enable();
                    }
                    mini.get("mytype").setValue("Edit");
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
        }
    }
  //�ر�
  function CloseWindow(action) {
  if (action == "close" && form.isChanged()) {
      if (confirm("���ݱ��޸��ˣ��Ƿ��ȱ��棿")) {
          return false;
      }
   }
  if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
    else window.close();
}
function valuechanged(e) {
    var ts = mini.get("MenuHfCount");
    var z = e.value;
    if (z == "TW") {
        ts.enable();
    }
    else {
        ts.disable();
        ts.setValue('1');
    }
}
 </script>


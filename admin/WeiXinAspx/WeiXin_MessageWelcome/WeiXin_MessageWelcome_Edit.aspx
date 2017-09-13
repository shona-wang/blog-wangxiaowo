 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_MessageWelcome_Edit.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageWelcome_WeiXin_MessageWelcome_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
      <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
<%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
         #WelcomeContent
         {
             width: 384px;
             height: 152px;
         }
     </style>
 </head>
 <body>
  <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">����</a> 
  </div>
   <fieldset id="fd1" style="width:98%;">
      <legend>����</legend>
 <form id="form1">
   <table style="text-align: right; width: 500px;">
    <tr>
     <td style="text-align:right;">��עʱ�ظ�����:</td>
    <td style="text-align:left;"><input id="WelcomeContent" name="WelcomeContent" class="mini-textarea" required="false"/></td>
    </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
     
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="WeiXinCode" name="WeiXinCode" class="mini-hidden" />
     </td>
     </tr>
   </table>
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
   //���溯��
    function SaveData() {
    //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "WeiXin_MessageWelcomeData.aspx?method=WeiXin_MessageWelcome_Insert",
        data: { data: json },
        type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("��ʾ:���ݲ���ʧ��!");
                }
                else {
                    mini.alert("��ʾ:���óɹ�!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
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
 </script>


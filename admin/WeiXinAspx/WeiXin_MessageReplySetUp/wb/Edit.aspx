<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageReplySetUp_wb_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head id="Head1" runat="server">
     <title></title>
     <script src="../../../scripts/boot.js" type="text/javascript"></script>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
         #MessagDescription
         {
             width: 369px;
             height: 71px;
         }
         #MessagContentAndId
         {
             width: 368px;
             height: 118px;
         }
         #MessagTiele
         {
             width: 368px;
         }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 474px;">
    <tr>
     <td style="text-align:right;">信息标题</td>
    <td style="text-align:left;"><input id="MessagTiele" name="MessagTiele" class="mini-textbox" required="false"/></td>
   
    </tr>
    <tr>
        <td style="text-align:right;">信息内容</td>
     <td style="text-align:left;"><input id="MessagContentAndId" name="MessagContentAndId" class="mini-textarea" required="false"/></td>
    </tr>
    
    <tr>
     <td style="text-align:right;">描述</td>
    <td style="text-align:left;" colspan="3"><input id="MessagDescription" name="MessagDescription" class="mini-textarea" required="false"/></td>
    </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">关闭</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="ID" name="ID" class="mini-hidden" />
        <input id="MessageType" name="MessageType" class="mini-hidden" value="WB"/>
     </td>
     </tr>
   </table>
 </form>
 </body>
 </html>
 <script type="text/javascript" language="javascript">
     mini.parse();
     var form = new mini.Form("form1");
     //保存函数
     function SaveData() {
         //debugger;
         var o = form.getData();
         form.validate();
         if (form.isValid() == false) return;
         var json = mini.encode([o]);
         $.ajax({
             url: "../WeiXin_MessageReplySetUpData.aspx?method=WeiXin_MessageReplySetUp_Insert",
             data: { data: json },
             type: "post",
             success: function(text) {
                 if (text == -1) {
                     mini.alert("提示:数据操作失败!");
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
     //标准方法接口定义
     function SetData(data) {
         if (data.action == "Edit") {
             //跨页面传递的数据对象，克隆后才可以安全使用
             data = mini.clone(data);
             $.ajax({
                 url: "../WeiXin_MessageReplySetUpData.aspx?method=WeiXin_MessageReplySetUp_Json_SelectWhere&DJBH=" + data.DJBH,
                 cache: false,
                 success: function(text) {
                     var o = mini.decode(text);
                     form.setData(o);
                     mini.get("mytype").setValue("Edit");
                     mini.get("ID").setValue(data.DJBH);
                 }
             });
         }
         else {
             mini.get("mytype").setValue("Add");
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
 </script>


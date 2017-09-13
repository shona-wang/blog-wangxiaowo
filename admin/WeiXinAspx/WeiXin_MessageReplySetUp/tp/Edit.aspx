<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageReplySetUp_tp_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head id="Head1" runat="server">
     <title></title>
     <script src="../../../scripts/boot.js" type="text/javascript"></script>
      <script src="../../../swfupload/swfupload.js" type="text/javascript"></script>
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
         #fileupload1
         {
             width: 200px;
             height: 24px;
         }
         #MessagTiele
         {
             width: 261px;
         }
         #MessagContentAndId
         {
             width: 259px;
         }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 356px;">
    <tr>
     <td style="text-align:right;">标题</td>
    <td style="text-align:left;"><input id="MessagTiele" name="MessagTiele" class="mini-textbox" required="true"/></td>
  
    </tr>
    <tr>
         <td style="text-align:right;">选择:</td>
     <td style="text-align:left;">
         <input id="fileupload1" class="mini-fileupload" name="Fdata" flashurl="../../../swfupload/swfupload.swf"
                    limittype=".jpg" uploadurl="../FuJian_Data.aspx" onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError" />
                <a class="mini-button" id="A2" iconcls="icon-upload" onclick="onFileSelect()">上传</a>
     </td>
    </tr>
    <tr>
    <td></td>
     <td  style="text-align:left;">
        <img id="imgtp"  src="#" style=" width:260px; height:100px;"/><br />
         <input id="MessagContentAndId" name="MessagContentAndId" class="mini-textbox"  enabled="false"/>
     </td>
    </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">关闭</a><br />
&nbsp;<input id="mytype" name="mytype" class="mini-hidden" />
        <input id="MessageType" name="MessageType" class="mini-hidden" value="TP"/>
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
     //保存函数
     function SaveData() {
         //debugger;
         var o = form.getData();
         form.validate();
         if (form.isValid() == false) return;
         var json = mini.encode([o]);
         if (mini.get("MessagContentAndId").getValue() != "") {
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
         else {
             mini.alert("提示:请上传图片!");
         }
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
                     $("#imgtp").attr("src", "../../../UploadFiles/" + o.MessagContentAndId);
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
     //附件
     //文件选择时激发
     function onFileSelect() {
         //debugger;
         var val = mini.get("fileupload1");
         if (val.text == "") {
             alert("上传文件不能为空");
         }
         else {
             val.startUpload();
         }
     }
     function onUploadSuccess(e) {

         if (e.serverData != "") {
             //mini.alert("上传成功");
             //查询附件
             this.setText("");
             var _file = mini.decode(e.serverData);
             mini.get("MessagContentAndId").setValue(_file.FileName);
             //var Array = [{ "Docname": _file.FileText, "FPath": _file.FileName}];
             $("#imgtp").attr("src", "../../../UploadFiles/" + _file.FileName);
             

         }
     }
     function onUploadError(e) {
         //debugger;
         alert("上传失败:" + e.serverData);
     }
 </script>


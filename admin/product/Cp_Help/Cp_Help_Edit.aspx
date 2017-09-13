 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cp_Help_Edit.aspx.cs" Inherits="product_Cp_Help_Cp_Help_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
<script src="../../swfupload/swfupload.js" type="text/javascript"></script>
   <link rel="stylesheet" href="../../kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="../../kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" src="../../kindeditor/kindeditor.js"></script>
	<script type="text/javascript" src="../../kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="../../kindeditor/plugins/code/prettify.js"></script> 
     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
         #BT
         {
             width: 297px;
         }
         #FLBH
         {
             width: 294px;
         }
         .style1
         {
             width: 87px;
         }
         #fileupload1
         {
             width: 337px;
         }
         #ImageMC
         {
             width: 398px;
         }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 693px;">
    <tr>
     <td style="text-align:right;" class="style1">����</td>
    <td style="text-align:left;"><input id="BT" name="BT" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
   <td style="text-align:right;" class="style1">����</td>
     <td style="text-align:left;"><input id="FLBH" name="FLBH" class="mini-combobox" valuefield="DJBH" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=BZLB"  onvaluechanged="onDeptChanged" required="true"/></td>
    </tr>
    <tr>
        <td style="text-align:right;" class="style1">˵��</td>
     <td style="text-align:left;">
        <textarea id="KinCPMS"   style="width:98%; height:300px;visibility:hidden;"></textarea>
     </td>
    </tr>
     <tr>
            <td style="text-align: right;" class="style1">
                ѡ��
            </td>
            <td style="text-align: left;">
                <input id="fileupload1" class="mini-fileupload" name="Fdata" flashurl="../../swfupload/swfupload.swf"
                    limittype=".jpg" uploadurl="../Cp_product/FuJian_Data.aspx" onuploadsuccess="onUploadSuccess"
                    onuploaderror="onUploadError" />
                <a class="mini-button" id="A2" iconcls="icon-upload" onclick="onFileSelect()">�ϴ�</a>
            </td>
        </tr>
        <tr>
            <td class="style1">
            </td>
            <td style="text-align: left;">
                <img id="imgtp" src="#" style="width: 400px; height: 100px;" /><br />
                <input id="ImageMC" name="ImageMC" class="mini-textbox" enabled="false" />
            </td>
        </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">�ر�</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="DJBH" name="DJBH" class="mini-hidden" />
        <input id="FLMC" name="FLMC" class="mini-hidden"/>
        <input id="SM" name="SM" class="mini-hidden"/>
     </td>
     </tr>
   </table>
 </form>
 </body>
 </html>
 <script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");

    var editor1;
    KindEditor.ready(function(K) {
        editor1 = K.create('#KinCPMS', {
            cssPath: '../../kindeditor/plugins/code/prettify.css',
            uploadJson: '../../kindeditor/upload_json.ashx',
            fileManagerJson: '../../kindeditor/file_manager_json.ashx',
            allowFileManager: true,
            afterCreate: function() {
                var self = this;
                K.ctrl(document, 13, function() {
                    self.sync();
                    K('form[name=form1]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function() {
                    self.sync();
                    K('form[name=form1]')[0].submit();
                });
            }
        });
        prettyPrint();
    }); ;
   //���溯��
    function SaveData() {
        //debugger;
        mini.get("SM").setValue(editor1.html());
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "Cp_HelpData.aspx?method=Cp_Help_Insert",
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
            url: "Cp_HelpData.aspx?method=Cp_Help_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
               success: function(text) {
                   var o = mini.decode(text);
                   form.setData(o);
                   editor1.html(o.SM);
                   $("#imgtp").attr("src", "../../UploadFiles/" + o.ImageMC);
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



//����
//�ļ�ѡ��ʱ����
function onFileSelect() {
    //debugger;
    var val = mini.get("fileupload1");
    if (val.text == "") {
        alert("�ϴ��ļ�����Ϊ��");
    }
    else {
        val.startUpload();
    }
}
function onUploadSuccess(e) {

    if (e.serverData != "") {
        //mini.alert("�ϴ��ɹ�");
        //��ѯ����
        this.setText("");
        var _file = mini.decode(e.serverData);
        mini.get("ImageMC").setValue(_file.FileName);
        //var Array = [{ "Docname": _file.FileText, "FPath": _file.FileName}];
        $("#imgtp").attr("src", "../../UploadFiles/" + _file.FileName);
    }
}
function onUploadError(e) {
    //debugger;
    alert("�ϴ�ʧ��:" + e.serverData);
}
function onDeptChanged(e) {
    mini.get("FLMC").setValue(e.source.text);
}
 </script>


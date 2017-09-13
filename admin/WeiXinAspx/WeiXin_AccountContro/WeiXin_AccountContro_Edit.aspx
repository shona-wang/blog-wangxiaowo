<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_AccountContro_Edit.aspx.cs"
    Inherits="WeiXinAspx_WeiXin_AccountContro_WeiXin_AccountContro_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../../scripts/boot.js" type="text/javascript"></script>
<script src="../../swfupload/swfupload.js" type="text/javascript"></script>
<%--    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
        #MC
        {
            width: 380px;
        }
        #DLYX
        {
            width: 380px;
        }
        #YSID
        {
            width: 380px;
        }
        #WXH
        {
            width: 380px;
        }
        #ZTXX
        {
            width: 380px;
        }
        #JS
        {
            width: 380px;
        }
        #SZDZ
        {
            width: 380px;
        }
    </style>
</head>
<body>
    <form id="form1">
    <table style="text-align: right; width: 500px;">
        <tr>
            <td style="text-align: right;">
                ����
            </td>
            <td style="text-align: left;">
                <input id="MC" name="MC" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ͷ��
            </td>
            <td style="text-align: left;">
                  <input id="fileupload1" class="mini-fileupload" name="Fdata" flashurl="../../swfupload/swfupload.swf"
                    limittype=".jpg" uploadurl="FuJian_Data.aspx" onuploadsuccess="onUploadSuccess"
                    onuploaderror="onUploadError" />
                <a class="mini-button" id="A1" iconcls="icon-upload" onclick="onFileSelect">�ϴ�</a>&nbsp;&nbsp;&nbsp; ���飺150*150 jpgͼƬ<br />
                <img id="txtp" src="#" style="width: 150px; height: 150px;" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��¼����
            </td>
            <td style="text-align: left;">
                <input id="DLYX" name="DLYX" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ԭʼID
            </td>
            <td style="text-align: left;">
                <input id="YSID" name="YSID" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ΢�ź�
            </td>
            <td style="text-align: left;">
                <input id="WXH" name="WXH" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ����
            </td>
            <td style="text-align:center;">
                <input id="LX" name="LX"  class="mini-radiobuttonlist" textField="text" valueField="id" value="�����" 
    url="lx_text.txt"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��֤���
            </td>
            <td style="text-align:center;">
                <input id="RZQK" name="RZQK" class="mini-radiobuttonlist" textField="text" valueField="id" value="δ��֤" 
    url="rzqk_text.txt"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ������Ϣ
            </td>
            <td style="text-align: left;">
                <input id="ZTXX" name="ZTXX" class="mini-textbox" required="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ����
            </td>
            <td style="text-align: left;">
                <input id="JS" name="JS" class="mini-textbox" required="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ���ڵ�ַ
            </td>
            <td style="text-align: left;">
                <input id="SZDZ" name="SZDZ" class="mini-textbox" required="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��ά��
            </td>
            <td style="text-align: left;">
                 <input id="fileupload2" class="mini-fileupload" name="Fdata" flashurl="../../swfupload/swfupload.swf"
                    limittype=".jpg" uploadurl="FuJian_Data.aspx" onuploadsuccess="onUploadSuccess"
                    onuploaderror="onUploadError" />
                <a class="mini-button" id="A2" iconcls="icon-upload" onclick="onFileSelect">�ϴ�</a>&nbsp;&nbsp;&nbsp; ���飺150*150 jpgͼƬ<br />
                <img id="ewmtp" src="#" style="width: 150px; height: 150px;" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">�ر�</a>
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJKEY" name="DJKEY" class="mini-hidden" />
                <input id="TX" name="TX" class="mini-hidden"/>
                 <input id="EWM" name="EWM" class="mini-hidden"/>
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
            url: "WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_Insert",
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
                url: "WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    $("#txtp").attr("src", "../../UploadFiles/" + o.TX);
                    $("#ewmtp").attr("src", "../../UploadFiles/" + o.EWM);
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
    /////////////////////
    //����
    //�ļ�ѡ��ʱ����
    function onFileSelect(e) {
        //debugger;
        var val;
        if (e.sender.id == "A1") {
            val = mini.get("fileupload1");
        }
        if (e.sender.id == "A2") {
            val = mini.get("fileupload2");
        }
        if (val.text == "") {
            alert("�ϴ��ļ�����Ϊ��");
        }
        else {
            val.startUpload();
        }
    }
    function onUploadSuccess(e) {
        debugger;
        if (e.serverData != "") {
            //mini.alert("�ϴ��ɹ�");
            //��ѯ����
            this.setText("");
            var _file = mini.decode(e.serverData);
            if (e.sender.id == "fileupload1") {
                mini.get("TX").setValue(_file.FileName);
                $("#txtp").attr("src", "../../UploadFiles/" + _file.FileName);
             }
            if (e.sender.id == "fileupload2") {
                mini.get("EWM").setValue(_file.FileName);
                $("#ewmtp").attr("src", "../../UploadFiles/" + _file.FileName);
            }
//            mini.get("ImageMC").setValue(_file.FileName);
//            //var Array = [{ "Docname": _file.FileText, "FPath": _file.FileName}];
//            $("#imgtp").attr("src", "../../UploadFiles/" + _file.FileName);
        }
    }
    function onUploadError(e) {
        //debugger;
        alert("�ϴ�ʧ��:" + e.serverData);
    }
</script>


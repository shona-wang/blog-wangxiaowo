<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DWXXTABLE_Edit.aspx.cs" Inherits="AccountNum_DWXXTABLE_DWXXTABLE_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <%--    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
--%>
    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
        #AccountNum
        {
            width: 251px;
        }
        #DWMC
        {
            width: 250px;
        }
        #SRM
        {
            width: 249px;
        }
    </style>
</head>
<body>
    <form id="form1">
    <table style="text-align: right; width: 392px;">
        <tr>
            <td style="text-align: right;">
                ���׺�
            </td>
            <td style="text-align: left;">
                <input id="AccountNum" name="AccountNum" class="mini-textbox" required="true" onvaluechanged="Repeat()"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��������
            </td>
            <td style="text-align: left;">
                <input id="DWMC" name="DWMC" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                �����
            </td>
            <td style="text-align: left;">
                <input id="SRM" name="SRM" class="mini-spinner" minvalue="0" maxvalue="99999999999"
                    required="true" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">�ر�</a>
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJKEY" name="DJKEY" class="mini-hidden" />
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
            url: "DWXXTABLEData.aspx?method=DWXXTABLE_Insert",
            data: { data: json },
            type: "post",
            success: function(text) {
                if (text != -1) {
                    mini.alert("��ʾ:���ݱ���ɹ�,�����!");
                    mini.get("AccountNum").setValue('');
                    mini.get("DWMC").setValue('');
                    mini.get("mytype").setValue("Add");
                }
                else {
                    mini.alert("��ʾ:���ݲ���ʧ��!");
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
                url: "DWXXTABLEData.aspx?method=DWXXTABLE_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    mini.get("AccountNum").setEnabled(false);
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
    function Repeat() {
        var AccountNum = mini.get("AccountNum");
        $.ajax({
        url: "DWXXTABLEData.aspx?method=DWXXTABLE_SelectCount&AccountNum=" + AccountNum.getValue(),
            type: "post",
            success: function(text) {
                if (text > 0) {
                    AccountNum.setValue("");
                    AccountNum.focus();
                    mini.alert("���׺��ظ�,����������!");
                }
            }
        });
    }
</script>


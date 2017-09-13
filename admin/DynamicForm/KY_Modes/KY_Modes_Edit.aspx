<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_Modes_Edit.aspx.cs" Inherits="DynamicForm_KY_Modes_KY_Modes_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
        #SJY
        {
            width: 374px;
            height: 144px;
        }
        #JSGS
        {
            width: 374px;
        }
        #HZZD
        {
            width: 374px;
        }
        #MRZ
        {
            width: 374px;
        }
        #XYFS
        {
            width: 374px;
        }
        #GLZDBM
        {
            width: 374px;
        }
    </style>
</head>
<body>
    <form id="form1">
    <table style="text-align: right; width: 498px;">
        <tr>
            <td style="text-align: right;">
                �ؼ�ID
            </td>
            <td style="text-align: left;">
                <input id="KJID" name="KJID" class="mini-textbox" required="true" onvaluechanged="Repeat()" />
            </td>
            <td style="text-align: right;">
                �ؼ�����
            </td>
            <td style="text-align: left;">
                <input id="KJMS" name="KJMS" class="mini-textbox" required="true" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                �ؼ�����
            </td>
            <td style="text-align: left;">
                <input id="KJLX" name="KJLX" class="mini-combobox" textfield="text" valuefield="id"
                    url="ControlTypeText.txt" shownullitem="true" required="true" onvaluechanged="onChanged" />
            </td>
            <td style="text-align: right;">
                �ؼ�����
            </td>
            <td style="text-align: left;">
                <input id="ZDCD" name="ZDCD" class="mini-spinner" minvalue="130" maxvalue="530" required="false"
                    enabled="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��ʾ˳��
            </td>
            <td style="text-align: left;">
                <input id="XSSX" name="XSSX" class="mini-spinner" minvalue="0" maxvalue="99999999999"
                    required="false" />
            </td>
            <td style="text-align: right;">
                �ؼ��߶�
            </td>
            <td style="text-align: left;">
                <input id="KJGD" name="KJGD" class="mini-spinner" minvalue="0" maxvalue="500" required="false"
                    enabled="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="SFHB" name="SFHB" class="mini-checkbox" readonly="false" text="�Ƿ�ϲ���" oncheckedchanged="checkedchanged">
                </div>
            </td>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="SFWK" name="SFWK" class="mini-checkbox" readonly="false" text="�Ƿ�Ϊ����">
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="SFXS" name="SFXS" class="mini-checkbox" readonly="false" text="�Ƿ���ʾ">
                </div>
            </td>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="SFJSHJ" name="SFJSHJ" class="mini-checkbox" readonly="false" text="�Ƿ����ϼ�">
                </div>
            </td>
        </tr>
         <tr>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="LBSFXS" name="LBSFXS" class="mini-checkbox" required="false" text="�б��Ƿ���ʾ">
                </div>
            </td>
            <td style="text-align: right;">
            </td>
            <td style="text-align: left;">
                <div id="SFXY" name="SFXY" class="mini-checkbox" required="false" text="�Ƿ�Ч��">
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ��̬����Դ
            </td>
            <td style="text-align: left;" colspan="3">
                <input id="SJY" name="SJY" class="mini-textarea" enabled="false" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">
                ���㹫ʽ
            </td>
            <td style="text-align: left;"  colspan="3">
                <input id="JSGS" name="JSGS" class="mini-textbox" required="false" />
            </td>
           
        </tr>
       <tr>
          <td style="text-align: right;">
                �����ֶ�
            </td>
            <td style="text-align: left;"  colspan="3">
                <input id="HZZD" name="HZZD" class="mini-textbox" required="false" />
            </td>
       </tr>
        <tr>
            <td style="text-align: right;">
                Ĭ��ֵ
            </td>
            <td style="text-align: left;" colspan="3">
                <input id="MRZ" name="MRZ" class="mini-textbox" required="false" />
            </td>
           
        </tr>
        <tr>
            <td style="text-align: right;">
                Ч�鹫ʽ
            </td>
            <td style="text-align: left;" colspan="3">
                <input id="XYFS" name="XYFS" class="mini-textbox" required="false" />
            </td>
        </tr>
        <tr>
           <td style="text-align:right;">�����ֵ����</td>
           <td style="text-align:left;" colspan="3"><input id="GLZDBM" name="GLZDBM" class="mini-textbox" required="false"/>
           </td>
        </tr>
        <tr>
          <td style="text-align:right;"></td>
          <td style="text-align:left;" colspan="3">
            ע:1.url 2.���ֶ� 3.��ʾ�ֶ�4.��"|"����;<br />
            ��:user.aspx?method=DorList|id|text
          </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center;">
                <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">�ر�</a>
                <input id="mytype" name="mytype" class="mini-hidden" />
                <input id="DJKEY" name="DJKEY" class="mini-hidden" />
                <input id="FL" name="FL" class="mini-hidden" /><br />
                ע:1.�ؼ�ID���ΪӢ����ĸ; 2.�ؼ�������ò�Ҫ����5������; 3.�ؼ�����Ϊ(�����򡢵�ѡ��ť����ѡ��)�ſ�����д����Դ,��ʽ����Ϊ"|"����;
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
        debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
            url: "KY_ModesData.aspx?method=KY_Modes_Insert",
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
                url: "KY_ModesData.aspx?method=KY_Modes_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                   
                    mini.get("mytype").setValue("Edit");
                    InitializationWebCol(o.KJLX);
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
            mini.get("FL").setValue(data.FL);
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
    function onChanged(e) {
        InitializationWebCol(e.value);
    }
    function InitializationWebCol(lx) {
        //debugger;
        var ZDCD = mini.get("ZDCD");
        var KJGD = mini.get("KJGD");
        var SJY = mini.get("SJY");
        if (lx == 1) {//����
            ZDCD.setValue('130');
            KJGD.setValue('22');
            SJY.setEnabled(false);
            SJY.setValue('');
        }
        if (lx == 2) {//����
            ZDCD.setValue('530');
            KJGD.setValue('145');
            KJGD.setEnabled(true);
            SJY.setEnabled(false);
            SJY.setValue('');
        }
        if (lx == 3) {//������
            ZDCD.setValue('130');
            KJGD.setValue('22');
            SJY.setEnabled(true); //��Ϊ����
            //SJY.setRequired(true); //����Ϊ��
            KJGD.setEnabled(false);
        }
        if (lx == 4) {//����
            ZDCD.setValue('130');
            KJGD.setValue('22');
            KJGD.setEnabled(false);
            SJY.setEnabled(false);
            SJY.setValue('');
        }
        if (e.value == 5) {//���ֿ�
            ZDCD.setValue('130');
            KJGD.setValue('22');
            KJGD.setEnabled(false);
            SJY.setEnabled(false);
        }
        if (lx == 6) {//��ѡ��ť
            ZDCD.setValue('130');
            KJGD.setValue('22');
            SJY.setEnabled(true); //��Ϊ����
            SJY.setRequired(true); //����Ϊ��
            KJGD.setEnabled(false);
        }
        if (lx == 7) {//��ѡ��
            ZDCD.setValue('130');
            KJGD.setValue('22');
            SJY.setEnabled(true); //��Ϊ����
            SJY.setRequired(true); //����Ϊ��
            KJGD.setEnabled(false);
        }
    }
    function checkedchanged(e) {//
        //debugger;
        var ZDCD = mini.get("ZDCD");
        var KJGD = mini.get("KJGD");
        if (e.sender.value == "true") {
            ZDCD.setValue('530');
            KJGD.setValue('145');
        }
        else {
            ZDCD.setValue('130');
            KJGD.setValue('22');
        }
    }
    //��֤�ֶ��Ƿ��ظ�
    function Repeat() {
        $.ajax({
            url: "KY_ModesData.aspx?method=KY_Modes_SelectCount",
            data: { KJID: mini.get("KJID").getValue(), DJKEY: mini.get("DJKEY").getValue(), FL: mini.get("FL").getValue() },
            type: "post",
            success: function(text) {
                if (text > 0) {
                    mini.alert("�ؼ�ID�ظ�,����������!");
                    var KJID = mini.getbyName("KJID");
                    KJID.setValue("");
                    KJID.focus();
                }
            }
        });
    }
</script>


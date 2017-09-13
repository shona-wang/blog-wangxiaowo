 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Customers_Edit.aspx.cs" Inherits="CustomersAspx_KH_Customers_KH_Customers_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>�ͻ�-�༭ҳ��</title>
     
     <script src="../../scripts/boot.js" type="text/javascript"></script>
        <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
             #Cust_SerialNO
             {
                 width: 193px;
             }
             #Cust_Name
             {
                 width: 190px;
             }
             #Cust_City
             {
                 width: 191px;
             }
             #Cust_Rate
             {
                 width: 190px;
             }
             #Cust_Type
             {
                 width: 189px;
             }
             #Cust_Trade
             {
                 width: 188px;
             }
             .style1
             {
                 width: 207px;
             }
             #Cust_Address
             {
                 width: 237px;
             }
             #Cust_PostCode
             {
                 width: 235px;
             }
             #Cust_HomePage
             {
                 width: 234px;
             }
             #Cust_Habit
             {
                 width: 233px;
             }
             #Cust_Source
             {
                 width: 232px;
             }
             #Cust_Memo
             {
                 width: 232px;
             }
             #Contact_JingDu
             {
                 width: 190px;
             }
             #Contact_WeiDu
             {
                 width: 231px;
             }
             #Cust_YeWuRenYuan
             {
                 width: 190px;
             }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 685px;">
    <tr>
     <td style="text-align:right;">�ͻ����</td>
    <td style="text-align:left;" class="style1"><input id="Cust_SerialNO" name="Cust_SerialNO" class="mini-textbox" /></td>
    <td style="text-align:right;">��ַ</td>
     <td style="text-align:left;"><input id="Cust_Address" name="Cust_Address" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">�ͻ�����</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Name" name="Cust_Name" class="mini-textbox" required="true"/></td>
    <td style="text-align:right;">��������</td>
     <td style="text-align:left;"><input id="Cust_PostCode" name="Cust_PostCode" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">����</td>
    <td style="text-align:left;" class="style1"><input id="Cust_City" name="Cust_City" class="mini-textbox" /></td>
    <td style="text-align:right;">��˾��ҳ</td>
     <td style="text-align:left;"><input id="Cust_HomePage" name="Cust_HomePage" class="mini-textbox" /></td>
    </tr>
      <tr>
     <td style="text-align:right;">����</td>
    <td style="text-align:left;" class="style1"><input id="Contact_JingDu" name="Contact_JingDu" class="mini-textbox" /></td>
    <td style="text-align:right;">γ��</td>
     <td style="text-align:left;"><input id="Contact_WeiDu" name="Contact_WeiDu" class="mini-textbox" /></td>
    </tr>
      <tr>
     <td style="text-align:right;">ҵ��Ա</td>
    <td style="text-align:left;" class="style1">
        <input id="Cust_YeWuRenYuan" name="Cust_YeWuRenYuan" class="mini-buttonedit" onbuttonclick="onMButtonEdit"
                    allowinput="false" />


    </td>
    <td style="text-align:right;">�Ƿ�����ɾ��</td>
     <td style="text-align:left;"> <select id="Cust_IsDelete" name="Cust_IsDelete" class="mini-radiobuttonlist">
                         <option value="��">��</option>
                         <option value="��">��</option>
                    </select></td>
    </tr>
    <tr>
     <td style="text-align:right;">�ͻ��ȼ�</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Rate" name="Cust_Rate" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHDJ" /></td>
    <td style="text-align:right;">�ͻ�״̬</td>
     <td style="text-align:left;"><input id="Cust_Habit" name="Cust_Habit" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHZT"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">�ͻ�����</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Type" name="Cust_Type" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHLX"/></td>
    <td style="text-align:right;">�ͻ���Դ</td>
     <td style="text-align:left;"><input id="Cust_Source" name="Cust_Source" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHLY"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">��ҵ���</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Trade" name="Cust_Trade" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHHY"/></td>
    <td style="text-align:right;">��ע</td>
     <td style="text-align:left;"><input id="Cust_Memo" name="Cust_Memo" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td colspan="4" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">����</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">�ر�</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="Cust_ID" name="Cust_ID" class="mini-hidden" />
        <input id="Cust_YeWuRenYuanName" name="Cust_YeWuRenYuanName" class="mini-hidden" />
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
        url: "KH_CustomersData.aspx?method=KH_Customers_Insert",
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
                url: "KH_CustomersData.aspx?method=KH_Customers_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    mini.get("Cust_ID").setValue(data.DJBH);
                    var btn = mini.get("Cust_YeWuRenYuan");
                    btn.setValue(o.Cust_YeWuRenYuan);
                    btn.setText(o.Cust_YeWuRenYuanName);;
                }
            });
        }
        else {
            mini.get("mytype").setValue("Add");
        }
        if (data.zt == "ywgl") {
            var Cust_IsDelete = mini.get("Cust_IsDelete");
            Cust_IsDelete.disable();
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
    //ҵ����Աѡ��
    function onMButtonEdit(e) {
        //debugger;
        var btnEdit = this;
        mini.open({
        url: bootPATH + "../WindowsAspx/UserSinglePossessive.aspx",
            title: "ѡ��-ҵ����Ա",
            width: 650,
            height: 380,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //����
                    if (data) {
                        btnEdit.setValue(data.yhm);
                        btnEdit.setText(data.xx);
                        mini.get("Cust_YeWuRenYuanName").setValue(data.xx);
                    }
                }
            }
        });

    }
 </script>


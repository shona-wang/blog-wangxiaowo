 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_index_ChaXun.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>�ͻ���ϵ��-��ѯҳ��</title>
        <script src="../../scripts/boot.js" type="text/javascript"></script>
      <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
    <%-- <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
     </style>
 </head>
 <body>
  <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
  <a class="mini-button" iconcls="icon-folderopen" onclick="lxrxx()" plain="true">��ϸ��Ϣ</a> 
    <input id="DJBH" name="DJBH" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KH_Contactdatagrid" class="mini-datagrid" style="height: 98%;" url="KH_ContactData.aspx?method=KH_Contact_Json_getSelectWhere" idfield="Contact_ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
       <%-- <div field="Cust_ID"  width="120" headeralign="center" allowsort="true"  >
        �ͻ����ݺ�
        </div>--%>
        <div field="Contact_Name"  width="120" headeralign="center" allowsort="true"  >
        ��ϵ��
        </div>
        <div field="Contact_Sex"  width="120" headeralign="center" allowsort="true"  >
        �Ա�
        </div>
        <div field="Contact_Birthday"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="Contact_Department"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="Contact_Func"  width="120" headeralign="center" allowsort="true"  >
        ְ��
        </div>
        <div field="Contact_IsMain"  width="120" headeralign="center" allowsort="true"  >
        �Ƿ���Ҫ��ϵ��
        </div>
        <div field="Contact_PhoneWork"  width="120" headeralign="center" allowsort="true"  >
        �칫�绰
        </div>
        <div field="Contact_Fax"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="Contact_Mobile"  width="120" headeralign="center" allowsort="true"  >
        �ֻ���
        </div>
        <div field="Contact_PhoneHome"  width="120" headeralign="center" allowsort="true"  >
        ��ͥ�绰
        </div>
        <div field="Contact_Mail"  width="120" headeralign="center" allowsort="true"  >
        �����ʼ�
        </div>
        <div field="Contact_Address"  width="120" headeralign="center" allowsort="true"  >
        ��ַ
        </div>
        <div field="Contact_QQ"  width="120" headeralign="center" allowsort="true"  >
        QQ��
        </div>
        <div field="Contact_Memo"  width="120" headeralign="center" allowsort="true"  >
        ��ע
        </div>
        <div field="LRRY"  width="120" headeralign="center" allowsort="true"  >
         ¼����Ա
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
         ¼��ʱ��
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
    <script type="text/javascript">
    mini.parse();
    var KH_Contactgrid = mini.get("KH_Contactdatagrid");
    $(window).load(function() {
        debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("DJBH").setValue(DJBH);
        KH_Contactgrid.load({DJBH:mini.get("DJBH").getValue()});
    });
    //�޸�
    function lxrxx() {
        //debugger;
        var row = KH_Contactgrid.getSelected();
        if (row) {
            mini.open({
            url: "../CustomersAspx/KH_Contact/KH_Contact_xx.aspx?Contact_ID=" + row.Contact_ID,
                title: "�ͻ�-��ϵ����Ϣ", width: 600, height: 300,
                onload: function() {

                },
                ondestroy: function(action) {

                }
            });
        } else {
            mini.alert("��ʾ:��ѡ��һ����¼!");
        }
    }
 </script>


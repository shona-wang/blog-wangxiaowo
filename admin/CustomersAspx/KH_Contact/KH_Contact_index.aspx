 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_Index.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>�ͻ���ϵ��-����ҳ��</title>
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
    <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
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
        //debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("DJBH").setValue(DJBH);
        KH_Contactgrid.load({DJBH:mini.get("DJBH").getValue()});
    });
    
        //���
     function add() {
         mini.open({
             url: "../CustomersAspx/KH_Contact/KH_Contact_Edit.aspx", //�˴�ע���޸�
             title: "����-�ͻ���ϵ��", width: 550, height: 300,
             onload: function() {
                 //debugger;
                 var iframe = this.getIFrameEl();
                 var data = { action: "Add", Cust_ID: mini.get("DJBH").getValue() };
                 iframe.contentWindow.SetData(data);
             },
             ondestroy: function(action) {
                 KH_Contactgrid.reload();
             }
         });
    }
      //�޸�
    function edit() {
        //debugger;
      var row =KH_Contactgrid.getSelected();
      if (row) {
          mini.open({
              url:"../CustomersAspx/KH_Contact/KH_Contact_Edit.aspx",
              title: "�޸�-�ͻ���ϵ��", width: 550, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", Contact_ID: row.Contact_ID, Cust_ID: mini.get("DJBH").getValue() }; //�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  KH_Contactgrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = KH_Contactgrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.Contact_ID); //�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 KH_Contactgrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "KH_ContactData.aspx?method=KH_Contact_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         KH_Contactgrid.reload();
                     },
                     error: function() {
                     }
                 });
             }
         });
     } else {
        mini.alert("��ѡ��һ����¼");
     }
  }
     //ˢ��
     function reload() {
     mini.get("Where").setValue('');
     KH_Contactgrid.load();
     }
     //��ӡ
     function print() {
        mini.alert('δʵ��');
     }
     //�߼���ѯ
     function SeelctCx() {
     var columns = _getColumns();
     mini.open({
         url: "GaoJiChaXun.aspx?Cols=" + columns,
         title: "�߼���ѯ", width: 800, height: 300,
         ondestroy: function() {
             var iframe = this.getIFrameEl();
             Where = iframe.contentWindow.GetData(); //������ҳ��ĺ���
             mini.get("Where").setValue(Where);
             grid.load({ Where: Where });
         }
     });
   }
     //�߼���ѯ���ú���
     function _getColumns() {
     var columns = KH_Contactgrid.getBottomColumns();
     function getColumns(columns) {
         columns = columns.clone();
         for (var i = columns.length - 1; i >= 0; i--) {
             var column = columns[i];
             if (!column.field) {
                 columns.removeAt(i);
             } else {
                 var c = { header: column.header, field: column.field };
                 columns[i] = c;
             }
         }
         return columns;
     }
     var columns = getColumns(columns);
     var json = mini.encode(columns);
     return json;
   }
     //�رմ���
     function CloseWindow(action) {
       if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
       else window.close();
     }
 </script>


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserInformationDynamicForm_EditList.aspx.cs" Inherits="WebAspx_UserInformation_UserInformationDynamicForm_EditList" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
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
     </style>
 </head>
 <body>
<div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
&nbsp;&nbsp;&nbsp; ��:<input id="rowscount" style="width: 40px;" class="mini-spinner"
minvalue="1" maxvalue="20" />
<span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="addrows"
 plain="true">������ϸ</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
     onclick="removerows" plain="true">ɾ����ϸ</a> <span class="separator"></span>
<a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">����</a>
 <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow"
 plain="true">�ر�</a>
</div>
  <div class="mini-fit">
 <div id="UserInformationdatagrid" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="DJKEY" allowresize="true" idfield="DJKEY" allowcelledit="true" editnextonenterkey="true"  allowcellselect="true" multiselect="true" showpager="false" allowSortColumn="false">
      <div property="columns">
        <div type="checkcolumn">
        </div>
 <% =Html("UserInformation")%>
        <%--<div field="SFDY"  width="120" headeralign="center" allowsort="true"  >
        �Ƿ�Ա
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="YHM"  width="120" headeralign="center" allowsort="true"  >
        �û���
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="XX"  width="120" headeralign="center" allowsort="true"  >
        �û�����
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="JG"  width="120" headeralign="center" allowsort="true"  >
        ����
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="NL"  width="120" headeralign="center" allowsort="true"  >
        ����
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="SFZH"  width="120" headeralign="center" allowsort="true"  >
        ���֤��
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="BYSJ"  width="120" headeralign="center" allowsort="true"  >
        ��ҵʱ��
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="ZW"  width="120" headeralign="center" allowsort="true"  >
        ְλ
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="XZZ"  width="120" headeralign="center" allowsort="true"  >
        ��סַ
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="JTZZ"  width="120" headeralign="center" allowsort="true"  >
        ��ͥסַ
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="BZ"  width="120" headeralign="center" allowsort="true"  >
        ��ע
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="LRRYZH"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա����
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ¼��ʱ��
 <input property="editor" class="mini-datepicker" style="width: 100%;" />
        </div>
        <div field="LLRYDWID"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա������λID
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="LLRYDWMC"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա��λ����
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="ACCOUNTNUM"  width="120" headeralign="center" allowsort="true"  >
        ���׺�
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>
        <div field="QTXX"  width="120" headeralign="center" allowsort="true"  >
        XXXX
 <input property="editor" class="mini-spinner" style="width: 100%;" />
        </div>--%>
      </div>
    </div>
  </div>
 <input id="FL" name="FL" class="mini-hidden" /> </body>
 </html>
 <script type="text/javascript" language="javascript">
 mini.parse();
 var UserInformationgrid = mini.get("UserInformationdatagrid");
 //��׼�����ӿڶ���
 function SetData(data) {
     if (data.action == "Add") {
         //��ҳ�洫�ݵ����ݶ��󣬿�¡��ſ��԰�ȫʹ��
         mini.get("FL").setValue(data.FL);
     }
 }
 //���溯��
 function SaveData() {
     UserInformationgrid.clearSelect(false);
     var cnt_bc = UserInformationgrid.getData().length;
     if (cnt_bc < 1) {
         mini.alert("��ϸ��������һ��");
         return;
     }
     
     UserInformationgrid.validate();
     if (UserInformationgrid.isValid() == false) {
         var error = UserInformationgrid.getCellErrors()[0];
         UserInformationgrid.beginEditCell(error.record, error.column);
         return;
     }
     UserInformationgrid.cancelEdit(); 
     //grid.cancelEdit();
     var data_ = UserInformationgrid.getData();
     var json_data = mini.encode(data_);
     $.ajax({
         url: "UserInformationData.aspx?method=UserInformation_ListInsert",
         data: { data: json_data, TableName: mini.get("FL").getValue() },
         type: "post",
         success: function(text) {
             if (text > 0) {
                 CloseWindow();
             } else {
                 mini.alert("��ʾ:�������ݳ��ִ���!");
             }
         }
     });
 }
 //������ϸ��
 function addrows() {
     //�ж������Ƿ�Ϊ��
     var Hs_Count = mini.get("rowscount").getValue();
     if (Hs_Count == 0) {
         mini.alert("��������һ����")
     }
     else {
         //������Ϊ��  �������
         for (var i = 0, n = Hs_Count; i < n; i++) {
             var cnt = i;
             var newRow = {};
             var gridcount = UserInformationgrid.getData().length;
             UserInformationgrid.addRow(newRow, gridcount);
             UserInformationgrid.validateRow(newRow);   //��������
         }
     }
 }
 //�Ƴ���
 function removerows() {
     var rows = UserInformationgrid.getSelecteds();
     if (rows.length > 0) {
         UserInformationgrid.removeRows(rows, true);
     }
 }
 //�رմ���
 function CloseWindow(action) {
     if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
     else window.close();
 }
</script>


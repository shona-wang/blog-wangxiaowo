 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="DWXXTABLE_Index.aspx.cs" Inherits="AccountNum_DWXXTABLE_DWXXTABLE_index" %>
 
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
    <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="DWXXTABLEdatagrid" class="mini-datagrid" style="height: 98%;" url="DWXXTABLEData.aspx?method=DWXXTABLE_PageJson_SelectWhere" idfield="DJKEY" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="AccountNum"  width="120" headeralign="center" allowsort="true"  >
        ���׺�
        </div>
        <div field="DWMC"  width="120" headeralign="center" allowsort="true"  >
        ��������
        </div>
        <div field="JZSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ����ʱ��
        </div>
        <div field="SRM"  width="120" headeralign="center" allowsort="true"  >
        �����
        </div>
     <%--   <div field="BS"  width="120" headeralign="center" allowsort="true"  >
        ��ʶ
        </div>--%>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var DWXXTABLEgrid = mini.get("DWXXTABLEdatagrid");
    DWXXTABLEgrid.load();
        //���
     function add() {
          mini.open({
          url: "DWXXTABLE_Edit.aspx",//�˴�ע���޸�
          title: "����-���׺�", width: 400, height: 170,
          onload: function() {
              var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              DWXXTABLEgrid.reload();
          }
     });
    }
      //�޸�
      function edit() {
      var row =DWXXTABLEgrid.getSelected();
      if (row) {
          mini.open({
              url:"DWXXTABLE_Edit.aspx",
              title: "�޸�-���׺�", width: 400, height: 170,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.DJKEY }; //�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  DWXXTABLEgrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = DWXXTABLEgrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJKEY);//�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 DWXXTABLEgrid.loading("�����У����Ժ�......");
                 $.ajax({
                     url: "DWXXTABLEData.aspx?method=DWXXTABLE_Deletes&&DJBH=" + id,//�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         DWXXTABLEgrid.reload();
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
     DWXXTABLEgrid.load();
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
     var columns = DWXXTABLEgrid.getBottomColumns();
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


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cp_product_index_ChaXun.aspx.cs" Inherits="product_Cp_product_Cp_product_index_ChaXun" %>
 
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head id="Head1" runat="server">
     <title>��Ʒ����-ҳ��</title>
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="Cp_productdatagrid" class="mini-datagrid" style="height: 98%;" url="Cp_productData.aspx?method=Cp_product_PageJson_SelectWhere" idfield="DJBH" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="CPBH"  width="120" headeralign="center" allowsort="true"  >
        ��Ʒ���
        </div>
        <div field="LBMC"  width="120" headeralign="center" allowsort="true"  >
         �������
        </div>
        <div field="CPBT"  width="120" headeralign="center" allowsort="true"  >
        ��Ʒ����
        </div>
        <div field="JG"  width="120" headeralign="center" allowsort="true"  >
        �۸�
        </div>
      <%--  <div field="CPSM"  width="120" headeralign="center" allowsort="true"  >
        ��Ʒ����
        </div>--%>
        
       <%-- <div field="ImageMC"  width="120" headeralign="center" allowsort="true"  >
        ͼƬ
        </div>--%>
        <div field="LRRYMC"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
        <div field="CJSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ¼��ʱ��
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var Cp_productgrid = mini.get("Cp_productdatagrid");
    Cp_productgrid.load();
    Cp_productgrid.on("drawcell", function(e) {
        var record = e.record,
         column = e.column,
         field = e.field,
         value = e.value;
        if (column.field == "CPBT") {
            e.cellHtml = "<a href='Cp_xxxx.htm?DJBH=" + record.DJBH + "' target='_blank' title='��ϸ��Ϣ'>" + value + "</a>";
        }
    });
        //���
     function add() {
     //debugger;
          mini.open({
          url: "../product/Cp_product/Cp_product_Edit.aspx",//�˴�ע���޸�
          title: "����-��Ʒ��Ϣ", width: 800, height: 650,
          onload: function() {
              var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              Cp_productgrid.reload();
          }
     });
    }
      //�޸�
      function edit() {
      var row =Cp_productgrid.getSelected();
      if (row) {
          mini.open({
              url:"../product/Cp_product/Cp_product_Edit.aspx",
              title: "�޸�-��Ʒ��Ϣ", width: 800, height: 650,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.DJBH };//�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  Cp_productgrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = Cp_productgrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJBH);//�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 Cp_productgrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "Cp_productData.aspx?method=Cp_product_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         Cp_productgrid.reload();
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
     Cp_productgrid.load();
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
     var columns = Cp_productgrid.getBottomColumns();
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


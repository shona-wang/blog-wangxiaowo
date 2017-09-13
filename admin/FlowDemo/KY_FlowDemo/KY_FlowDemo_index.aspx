 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_FlowDemo_Index.aspx.cs" Inherits="FlowDemo_KY_FlowDemo_KY_FlowDemo_index" %>
 
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-folderopen" plain="true" onclick="OpenFlowLook">�鿴����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <span class="separator"></span><a id="A1" class="mini-button" iconcls="icon-addfolder" plain="true" onclick="OpenYiJian()">�鿴�������</a> 
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KY_FlowDemodatagrid" class="mini-datagrid" style="height: 98%;" url="KY_FlowDemoData.aspx?method=KY_FlowDemo_PageJson_SelectWhere" idfield="DJBH" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="XM"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="NL"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="SFZH"  width="120" headeralign="center" allowsort="true"  >
        ���֤��
        </div>
        <div field="CSRQ"  width="120" headeralign="center" allowsort="true"  >
        ��������
        </div>
        <div field="LRRY"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
        <div field="LRRQ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ¼������
        </div>
        <div field="DJZT"  width="120" headeralign="center" allowsort="true"  >
        ����״̬
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var KY_FlowDemogrid = mini.get("KY_FlowDemodatagrid");
    KY_FlowDemogrid.load();
        //���
     function add() {
          mini.open({
          url: "../FlowDemo/KY_FlowDemo/KY_FlowDemo_Edit.aspx",//�˴�ע���޸�
          title: "����-����������", width: 550, height: 300,
          onload: function() {
              var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              KY_FlowDemogrid.reload();
          }
     });
    }
      //�޸�
      function edit() {
      var row =KY_FlowDemogrid.getSelected();
      if (row) {
          mini.open({
              url:"../FlowDemo/KY_FlowDemo/KY_FlowDemo_Edit.aspx",
              title: "�޸�-����������", width: 550, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.DJBH };//�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  KY_FlowDemogrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = KY_FlowDemogrid.getSelecteds();
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
                 KY_FlowDemogrid.loading("�����У����Ժ�......");
                 $.ajax({
                     url: "KY_FlowDemoData.aspx?method=KY_FlowDemo_Deletes&&DJBH=" + id,//�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         KY_FlowDemogrid.reload();
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
     KY_FlowDemogrid.load();
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
     var columns = KY_FlowDemogrid.getBottomColumns();
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

   function OpenFlowLook() {
       var row = KY_FlowDemogrid.getSelected();
       mini.open({
           url: "../Flows/FlowLook.aspx?DJBH=" + row.DJBH,
           title: "���̲鿴",
           width: 550,
           height: 600

       });
   }
   function OpenYiJian() {
       var row = KY_FlowDemogrid.getSelected();
       mini.open({
           url: "../Flows/Flow_YiJian.aspx?billcode=" + row.DJBH,
           title: "�鿴�������",
           width: 650,
           height: 380
       });
   } 
     
   
 </script>


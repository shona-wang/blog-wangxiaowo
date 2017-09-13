 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_MessageWelcome_Index.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageWelcome_WeiXin_MessageWelcome_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
   <%--  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
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
    <%--<a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>--%>
   <%-- <span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_MessageWelcomedatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_MessageWelcomeData.aspx?method=WeiXin_MessageWelcome_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="WelcomeContent"  width="120" headeralign="center" allowsort="true"  >
        ��ӭ����
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ¼������
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var WeiXin_MessageWelcomegrid = mini.get("WeiXin_MessageWelcomedatagrid");
    WeiXin_MessageWelcomegrid.load();
        //���
     function add() {
          mini.open({
          url: "../WeiXinAspx/WeiXin_MessageWelcome/WeiXin_MessageWelcome_Edit.aspx",//�˴�ע���޸�
          title: "����-΢�Ż�ӭ��", width: 530, height: 250,
          onload: function() {
             var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              WeiXin_MessageWelcomegrid.reload();
          }
     });
    }
      //�޸�
      function edit() {
      var row =WeiXin_MessageWelcomegrid.getSelected();
      if (row) {
          mini.open({
              url:"../WeiXinAspx/WeiXin_MessageWelcome/WeiXin_MessageWelcome_Edit.aspx",
              title: "�޸�-΢�Ż�ӭ��", width: 650, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.ID };//�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  WeiXin_MessageWelcomegrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = WeiXin_MessageWelcomegrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.ID);//�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 WeiXin_MessageWelcomegrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "WeiXin_MessageWelcomeData.aspx?method=WeiXin_MessageWelcome_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         WeiXin_MessageWelcomegrid.reload();
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
     WeiXin_MessageWelcomegrid.load();
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
     var columns = WeiXin_MessageWelcomegrid.getBottomColumns();
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


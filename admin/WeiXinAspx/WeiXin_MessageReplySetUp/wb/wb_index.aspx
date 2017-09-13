<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wb_index.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageReplySetUp_wb_wb_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head id="Head1" runat="server">
     <title></title>
     <script src="../../../scripts/boot.js" type="text/javascript"></script>
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
  <%--  <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>--%>
    <%--<span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_MessageReplySetUpdatagrid" class="mini-datagrid" style="height: 98%;" url="../WeiXin_MessageReplySetUpData.aspx?method=WeiXin_MessageReplySetUp_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="MessagTiele"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="MessagContentAndId"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="MessagDescription"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ¼��ʱ��
        </div>
        <%--<div field="MessageXuHao"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ���
        </div>--%>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var WeiXin_MessageReplySetUpgrid = mini.get("WeiXin_MessageReplySetUpdatagrid");
    WeiXin_MessageReplySetUpgrid.load({LX:'WB'});
    //���
     function add() {
          mini.open({
          url: "../WeiXinAspx/WeiXin_MessageReplySetUp/wb/Edit.aspx", //�˴�ע���޸�
          title: "����-�ı���Ϣ", width: 480, height: 300,
          onload: function() {
              var iframe = this.getIFrameEl();
              var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              WeiXin_MessageReplySetUpgrid.reload();
          }
     });
    }
      //�޸�
      function edit() {
      var row =WeiXin_MessageReplySetUpgrid.getSelected();
      if (row) {
          mini.open({
          url: "../WeiXinAspx/WeiXin_MessageReplySetUp/wb/Edit.aspx", //�˴�ע���޸�
              title: "�޸�-�ı���Ϣ", width: 480, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.ID };//�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  WeiXin_MessageReplySetUpgrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = WeiXin_MessageReplySetUpgrid.getSelecteds();
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
                 WeiXin_MessageReplySetUpgrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "../WeiXin_MessageReplySetUpData.aspx?method=WeiXin_MessageReplySetUp_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         WeiXin_MessageReplySetUpgrid.reload();
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
     WeiXin_MessageReplySetUpgrid.load();
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
     var columns = WeiXin_MessageReplySetUpgrid.getBottomColumns();
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


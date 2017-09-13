 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_Message_index_ChaXun.aspx.cs" Inherits="WeiXinAspx_WeiXin_Message_WeiXin_Message_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_Messagedatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_MessageData.aspx?method=WeiXin_Message_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="toUserName"  width="120" headeralign="center" allowsort="true">
        ���շ�΢�ź�
        </div>
        <div field="FromUserName"  width="120" headeralign="center" allowsort="true">
        ���ͷ�΢�ź�
        </div>
        <div field="MsgType"  width="120" headeralign="center" allowsort="true">
        ����
        </div>
        <div field="Content"  width="120" headeralign="center" allowsort="true">
        ��Ϣ����
        </div>
          <div field="CreateTime"  width="120" headeralign="center" allowsort="true">
        ����
        </div>
       <%-- <div field="Location_X"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="Location_Y"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="Scale"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="Label"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="PicUrl"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="MessageDateTime"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>--%>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var WeiXin_Messagegrid = mini.get("WeiXin_Messagedatagrid");
    WeiXin_Messagegrid.load();
     //ˢ��
     function reload() {
     mini.get("Where").setValue('');
     WeiXin_Messagegrid.load();
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
     var columns = WeiXin_Messagegrid.getBottomColumns();
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


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Weixin_MenuModes_Index.aspx.cs" Inherits="WeiXinAspx_Weixin_MenuModes_Weixin_MenuModes_index" %>
 
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
<%--    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>--%>
<%--    <span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="Weixin_MenuModesdatagrid" class="mini-datagrid" style="height: 98%;" url="Weixin_MenuModesData.aspx?method=Weixin_MenuModes_Json_getSelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="MenuKey"  width="120" headeralign="center" allowsort="true"  >
        Key���
        </div>
        <div field="MenuHftypy"  width="120" headeralign="center" allowsort="true"  >
        ��Ϣ����
        </div>
      <%--  <div field="MenuHfCountType"  width="120" headeralign="center" allowsort="true"  >
          ���ͷ���
        </div>--%>
        <div field="MenuHfCount"  width="120" headeralign="center" allowsort="true"  >
        ��Ϣ����
        </div>
        <div field="DataTable"  width="120" headeralign="center" allowsort="true"  >
        ��ѯ�����ݱ�
        </div>
        <div field="SqlText"  width="120" headeralign="center" allowsort="true"  >
        ��ѯʱsql���
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
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
    var Weixin_MenuModesgrid = mini.get("Weixin_MenuModesdatagrid");
    Weixin_MenuModesgrid.load();
        //���
    function add() {
        debugger;
        var gridcount = Weixin_MenuModesgrid.getData().length;
        if (gridcount <15) {
            mini.open({
                url: "../WeiXinAspx/Weixin_MenuModes/Weixin_MenuModes_Edit.aspx", //�˴�ע���޸�
                title: "����-�ظ���������", width: 600, height: 200,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Add" };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    Weixin_MenuModesgrid.reload();
                }
            });
        }
        else {
            mini.alert("��ʾ:���15��,�����������!");
        }
    }
      //�޸�
      function edit() {
      var row =Weixin_MenuModesgrid.getSelected();
      if (row) {
          mini.open({
              url:"../WeiXinAspx/Weixin_MenuModes/Weixin_MenuModes_Edit.aspx",
              title: "�޸�-�ظ���������", width: 600, height: 200,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.ID };//�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  Weixin_MenuModesgrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = Weixin_MenuModesgrid.getSelecteds();
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
                 Weixin_MenuModesgrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "Weixin_MenuModesData.aspx?method=Weixin_MenuModes_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         Weixin_MenuModesgrid.reload();
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
     Weixin_MenuModesgrid.load();
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
     var columns = Weixin_MenuModesgrid.getBottomColumns();
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


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_AccountContro_Index.aspx.cs" Inherits="WeiXinAspx_WeiXin_AccountContro_WeiXin_AccountContro_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
<%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
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
<%--    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">��ѯ</a>--%>
 <%--   <span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">�༭</a>
     <span class="separator"></span><a class="mini-button" iconcls="icon-find" onclick="sz()" plain="true">����</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">��ӡԤ��</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_AccountControdatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_PageJson_SelectWhere" idfield="DJKEY" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="MC"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="TX"  width="120" headeralign="center" allowsort="true"  >
        ͷ��
        </div>
        <div field="DLYX"  width="120" headeralign="center" allowsort="true"  >
        ��¼����
        </div>
        <div field="YSID"  width="120" headeralign="center" allowsort="true"  >
        ԭʼID
        </div>
        <div field="WXH"  width="120" headeralign="center" allowsort="true"  >
        ΢�ź�
        </div>
        <div field="LX"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="RZQK"  width="120" headeralign="center" allowsort="true"  >
        ��֤���
        </div>
        <div field="ZTXX"  width="120" headeralign="center" allowsort="true"  >
        ������Ϣ
        </div>
        <div field="JS"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="SZDZ"  width="120" headeralign="center" allowsort="true"  >
        ���ڵ�ַ
        </div>
        <div field="EWM"  width="120" headeralign="center" allowsort="true"  >
        ��ά��
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա����
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
    var WeiXin_AccountControgrid = mini.get("WeiXin_AccountControdatagrid");
    WeiXin_AccountControgrid.load();
        //���
    function add() {
        mini.open({
            url: "../WeiXinAspx/WeiXin_AccountContro/WeiXin_AccountContro_Edit.aspx", //�˴�ע���޸�
            title: "����-��ҵ΢�ź�", width: 600, height: 650,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                WeiXin_AccountControgrid.reload();
            }
        });
    }
      //�޸�
    function edit() {
        var row = WeiXin_AccountControgrid.getSelected();
        if (row) {
            mini.open({
                url: "../WeiXinAspx/WeiXin_AccountContro/WeiXin_AccountContro_Edit.aspx",
                title: "�޸�-��ҵ΢�ź�", width: 600, height: 650,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.DJKEY }; //�˴���Ҫ�ֶ���������������������̫���ж���
                    iframe.contentWindow.SetData(data); //������ҳ��ĺ���
                },
                ondestroy: function(action) {
                    WeiXin_AccountControgrid.reload();
                }
            });
        } else {
            mini.alert("��ʾ:��ѡ��һ����¼!");
        }
    }
     //ɾ��
     function dels() {
     var rows = WeiXin_AccountControgrid.getSelecteds();
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
                 WeiXin_AccountControgrid.loading("�����У����Ժ�......");
                 $.ajax({
                     url: "WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_Deletes&&DJBH=" + id,//�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         WeiXin_AccountControgrid.reload();
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
     WeiXin_AccountControgrid.load();
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
             var Where = iframe.contentWindow.GetData(); //������ҳ��ĺ���
             mini.get("Where").setValue(Where);
             grid.load({ Where: Where });
         }
     });
   }
     //�߼���ѯ���ú���
     function _getColumns() {
     var columns = WeiXin_AccountControgrid.getBottomColumns();
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
   WeiXin_AccountControgrid.on("drawcell", function(e) {
       var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
       //���Ա��ı��滻��ͼƬ
       if (column.field == "TX") {
           e.cellHtml = '<img  src="../../UploadFiles/' + e.value + '" style="width: 150px; height: 150px;" />';
       }
       if (column.field == "EWM") {
           e.cellHtml = '<img  src="../../UploadFiles/' + e.value + '" style="width: 150px; height: 150px;" />';
       }
   })
   function sz() {
       var row = WeiXin_AccountControgrid.getSelected();
       if (row) {
           var tab = { PARENTID: row.DJKEY, TEXT: row.MC, URL: '../WeiXinAspx/MenuIndex.aspx?WeiXinCode=' + row.YSID, IMAGE: 'icon-node' };  //����ģ��һ��tab
           parent.AddshowTab(tab);
       } else {
           mini.alert("��ʾ:��ѡ��һ����¼!");
       }
   }
 </script>


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GenZong_Index.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GenZong_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>�ͻ�������Ϣ-����ҳ��</title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

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
      <span class="separator"></span><a class="mini-button" iconcls="icon-zoomin" onclick="Map()" plain="true">¼������λ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
    <input id="Where" name="Where" class="mini-hidden" />
     <input id="DJBH" name="DJBH" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KH_GenZongdatagrid" class="mini-datagrid" style="height: 98%;" url="KH_GenZongData.aspx?method=KH_GenZong_Json_getSelectWhere" idfield="GZBH" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
           <div field="GZNR"  width="120" headeralign="center" allowsort="true"  >
        ��������
        </div>
        <div field="LXRQ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ��ϵ����
        </div>
        <div field="JD"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="WD"  width="120" headeralign="center" allowsort="true"  >
        ά��
        </div>
        <div field="DZ"  width="120" headeralign="center" allowsort="true"  >
        ¼��λ��
        </div>
        <div field="CZSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        ����ʱ��
        </div>
         <div field="user_ID"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var KH_GenZonggrid = mini.get("KH_GenZongdatagrid");
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("DJBH").setValue(DJBH);
        KH_GenZonggrid.load({ DJBH: mini.get("DJBH").getValue() });
    });
        //���
     function add() {
         mini.open({
             url: "../CustomersAspx/KH_GenZong/KH_GenZong_Edit.aspx", //�˴�ע���޸�
             title: "����-�ͻ�������Ϣ", width: 550, height: 450,
             onload: function() {
                 //debugger;
                 var iframe = this.getIFrameEl();
                 var data = { action: "Add", Cust_ID: mini.get("DJBH").getValue() };
                 iframe.contentWindow.SetData(data);
             },
             ondestroy: function(action) {
                 KH_GenZonggrid.reload();
             }
         });
    }
      //�޸�
      function edit() {
      var row =KH_GenZonggrid.getSelected();
      if (row) {
          mini.open({
              url:"../CustomersAspx/KH_GenZong/KH_GenZong_Edit.aspx",
              title: "�޸�-�ͻ�������Ϣ", width: 550, height: 450,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  //var data = { action: "Edit", DJBH: row.DJBH };//�˴���Ҫ�ֶ���������������������̫���ж���
                  var data = { action: "Edit", GZBH: row.GZBH, Cust_ID: mini.get("DJBH").getValue() }; //�˴���Ҫ�ֶ���������������������̫���ж���
                  iframe.contentWindow.SetData(data); //������ҳ��ĺ���
              },
              ondestroy: function(action) {
                  KH_GenZonggrid.reload();
              }
          });
      } else {
          mini.alert("��ʾ:��ѡ��һ����¼!");
      }
  }
     //ɾ��
     function dels() {
     var rows = KH_GenZonggrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.GZBH);//�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 KH_GenZonggrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "KH_GenZongData.aspx?method=KH_GenZong_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         KH_GenZonggrid.reload();
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
     KH_GenZonggrid.load();
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
     var columns = KH_GenZonggrid.getBottomColumns();
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
   //��ͼ
   function Map() {
       //debugger;
       var row = KH_GenZonggrid.getSelected();
       if (row) {
           mini.open({
           url:  "../CustomersAspx/KH_Customers/KH_Map.htm?MapJD=" + row.JD + "&&MapWD=" + row.WD + "&&Cust_Name=" + row.DZ, //�˴�ע���޸�
               title: "����¼��λ��", width: 550, height: 450,
               onload: function() {
                  
               },
               ondestroy: function(action) {
                  
               }
           });
       }
       else {
           mini.alert("��ѡ��һ����¼");
       }
   }
 </script>


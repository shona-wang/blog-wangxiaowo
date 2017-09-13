 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Customers_Index.aspx.cs" Inherits="CustomersAspx_KH_Customers_KH_Customers_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>�ͻ�����������ҳ��</title>
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
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">ɾ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-zoomin" onclick="Map()" plain="true">�ͻ�λ��</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="Lxr()" plain="true">��ϵ�˹���</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="GenZongClick()" plain="true">������Ϣ����</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">�ر�</a>
  <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KH_Customersdatagrid" class="mini-datagrid" style="height: 100%;" url="KH_CustomersData.aspx?method=KH_Customers_PageJson_SelectWhere" idfield="Cust_ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
         <div field="Cust_Rate"  width="120" headeralign="center" allowsort="true"  >
        �ͻ��ȼ�
        </div>
        <div field="Cust_Habit"  width="120" headeralign="center" allowsort="true"  >
        �ͻ�״̬
        </div>
        <div field="Cust_SerialNO"  width="120" headeralign="center" allowsort="true"  >
        �ͻ����
        </div>
        <div field="Cust_Name"  width="120" headeralign="center" allowsort="true"  >
        �ͻ�����
        </div>
        <div field="Cust_PostCode"  width="120" headeralign="center" allowsort="true"  >
        ��������
        </div>
        <div field="Cust_Address"  width="120" headeralign="center" allowsort="true"  >
        ��ַ
        </div>
        <div field="Cust_HomePage"  width="120" headeralign="center" allowsort="true"  >
        ��˾��ҳ
        </div>
        <div field="Cust_City"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
        <div field="Contact_JingDu"  width="120" headeralign="center" allowsort="true"  >
        ����
        </div>
         <div field="Contact_WeiDu"  width="120" headeralign="center" allowsort="true"  >
        γ��
        </div>
        <div field="Cust_YeWuRenYuanName"  width="120" headeralign="center" allowsort="true"  >
        ҵ����Ա
        </div>
        <div field="Cust_Type"  width="120" headeralign="center" allowsort="true"  >
        �ͻ�����
        </div>
        <div field="Cust_Source"  width="120" headeralign="center" allowsort="true"  >
        �ͻ���Դ
        </div>
        <div field="Cust_Trade"  width="120" headeralign="center" allowsort="true"  >
        ��ҵ����
        </div>
        <div field="Cust_Memo"  width="120" headeralign="center" allowsort="true"  >
        ��ע
        </div>
         <div field="Cust_IsDelete"  width="120" headeralign="center" allowsort="true"  >
        �Ƿ�����ɾ��
        </div>
         <div field="Cust_RegTime"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        �Ǽ�ʱ��
        </div>
        <div field="User_ID"  width="120" headeralign="center" allowsort="true"  >
        ¼����Ա
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var KH_Customersgrid = mini.get("KH_Customersdatagrid");
    KH_Customersgrid.load({ zt: 'zhgl' });
        //���
    function add() {
        mini.open({
            url: "../CustomersAspx/KH_Customers/KH_Customers_Edit.aspx", //�˴�ע���޸�
            title: "����-�ͻ�����", width: 700, height: 300,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add",zt:'zhgl' };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                KH_Customersgrid.reload();
            }
        });
    }
      //�޸�
    function edit() {
        var row = KH_Customersgrid.getSelected();
        if (row) {
            mini.open({
                url: "../CustomersAspx/KH_Customers/KH_Customers_Edit.aspx",
                title: "�޸�-�ͻ�����", width: 700, height: 300,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.Cust_ID,zt:'zhgl'}; //�˴���Ҫ�ֶ���������������������̫���ж���
                    iframe.contentWindow.SetData(data); //������ҳ��ĺ���
                },
                ondestroy: function(action) {
                    KH_Customersgrid.reload();
                }
            });
        } else {
            mini.alert("��ʾ:��ѡ��һ����¼!");
        }
    }
     //ɾ��
    function dels() {
        var rows = KH_Customersgrid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("ȷ��ɾ��ѡ�м�¼��", "ȷ����",
         function(action) {
             if (action == "ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.Cust_ID); //�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 KH_Customersgrid.loading("�����У����Ժ�......");
                 $.ajax({
                 url: "KH_CustomersData.aspx?method=KH_Customers_Deletes&&DJBH=" + id, //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         KH_Customersgrid.reload();
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
        KH_Customersgrid.load({ zt: 'zhgl' });
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
               // debugger;
                var iframe = this.getIFrameEl();
                var Where = iframe.contentWindow.GetData(); //������ҳ��ĺ���
                mini.get("Where").setValue(Where);
                KH_Customersgrid.load({zt: 'zhgl',Where: Where });
            }
        });
    }
     //�߼���ѯ���ú���
    function _getColumns() {
        var columns = KH_Customersgrid.getBottomColumns();
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
    ///
    function Lxr() {
        var row = KH_Customersgrid.getSelected();
        if (row) {
            var Dm_Url = "../CustomersAspx/KH_Contact/KH_Contact_index.aspx?DJBH=" + row.Cust_ID;
            var tab = { PARENTID: row.Cust_ID, TEXT: row.Cust_Name + '-��ϵ��', URL: Dm_Url, IMAGE: 'icon-edit' };  //����ģ��һ��tab
            parent.AddshowTab(tab);
        }
        else {
            mini.alert("��ѡ��һ����¼");
        }
    }
    function GenZongClick() {
        var row = KH_Customersgrid.getSelected();
        if (row) {
            var Dm_Url = "../CustomersAspx/KH_GenZong/KH_GenZong_index.aspx?DJBH=" + row.Cust_ID;
            var tab = { PARENTID: "GZ" + row.Cust_ID, TEXT: row.Cust_Name + '-������Ϣ', URL: Dm_Url, IMAGE: 'icon-edit' };  //����ģ��һ��tab
            parent.AddshowTab(tab);
        }
        else {
            mini.alert("��ѡ��һ����¼");
        }
    }
    //��ͼ
    function Map() {
        var row = KH_Customersgrid.getSelected();
        if (row) {
            var Dm_Url = "../CustomersAspx/KH_Customers/KH_Map.htm?MapJD=" + row.Contact_JingDu + "&&MapWD=" + row.Contact_WeiDu + "&&Cust_Name=" + row.Cust_Name;
            var tab = { PARENTID: "Map" + row.Cust_ID, TEXT: row.Cust_Name + '-����λ��', URL: Dm_Url, IMAGE: 'icon-edit' };  //����ģ��һ��tab
            parent.AddshowTab(tab);
        }
        else {
            mini.alert("��ѡ��һ����¼");
        }
    }
 </script>


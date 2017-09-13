 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Customers_index_ChaXun.aspx.cs" Inherits="CustomersAspx_KH_Customers_KH_Customers_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-zoomin" onclick="Map()" plain="true">客户位置</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-folder" onclick="XXXX()" plain="true">详细信息</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KH_Customersdatagrid" class="mini-datagrid" style="height: 100%;" url="KH_CustomersData.aspx?method=KH_Customers_PageJson_SelectWhere" idfield="Cust_ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
         <div field="Cust_Rate"  width="120" headeralign="center" allowsort="true"  >
        客户等级
        </div>
        <div field="Cust_Habit"  width="120" headeralign="center" allowsort="true"  >
        客户状态
        </div>
        <div field="Cust_SerialNO"  width="120" headeralign="center" allowsort="true"  >
        客户编号
        </div>
        <div field="Cust_Name"  width="120" headeralign="center" allowsort="true"  >
        客户名称
        </div>
        <div field="Cust_PostCode"  width="120" headeralign="center" allowsort="true"  >
        邮政编码
        </div>
        <div field="Cust_Address"  width="120" headeralign="center" allowsort="true"  >
        地址
        </div>
        <div field="Cust_HomePage"  width="120" headeralign="center" allowsort="true"  >
        公司主页
        </div>
        <div field="Cust_City"  width="120" headeralign="center" allowsort="true"  >
        城市
        </div>
        <div field="Contact_JingDu"  width="120" headeralign="center" allowsort="true"  >
        经度
        </div>
         <div field="Contact_WeiDu"  width="120" headeralign="center" allowsort="true"  >
        纬度
        </div>
        <div field="Cust_YeWuRenYuanName"  width="120" headeralign="center" allowsort="true"  >
        业务人员
        </div>
        <div field="Cust_Type"  width="120" headeralign="center" allowsort="true"  >
        客户类型
        </div>
        <div field="Cust_Source"  width="120" headeralign="center" allowsort="true"  >
        客户来源
        </div>
        <div field="Cust_Trade"  width="120" headeralign="center" allowsort="true"  >
        行业类型
        </div>
        <div field="Cust_Memo"  width="120" headeralign="center" allowsort="true"  >
        备注
        </div>
         <div field="Cust_IsDelete"  width="120" headeralign="center" allowsort="true"  >
        是否允许删除
        </div>
         <div field="Cust_RegTime"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        登记时间
        </div>
        <div field="User_ID"  width="120" headeralign="center" allowsort="true"  >
        录入人员
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
     mini.parse();
     var KH_Customersgrid = mini.get("KH_Customersdatagrid");
     KH_Customersgrid.load({ zt: 'chcx' });
     function XXXX() {
         debugger;
         var row = KH_Customersgrid.getSelected();
         if (row) {
             var Dm_Url = "../CustomersAspx/KH_Customers/KH_ChaXun_Tab.aspx?Cust_ID=" + row.Cust_ID;
             var tab = { PARENTID: 'KHTables' + row.Cust_ID, TEXT: row.Cust_Name + '-详细信息', URL: Dm_Url, IMAGE: 'icon-edit' };  //首先模拟一个tab
             parent.AddshowTab(tab);
         }
         else {
             mini.alert("请选中一条记录");
         }
     }
     //刷新
     function reload() {
         mini.get("Where").setValue('');
         KH_Customersgrid.load({ zt: 'chcx' });
     }
     //打印
     function print() {
         mini.alert('未实现');
     }
     //高级查询
     function SeelctCx() {
         var columns = _getColumns();
         mini.open({
             url: "GaoJiChaXun.aspx?Cols=" + columns,
             title: "高级查询", width: 800, height: 300,
             ondestroy: function() {
                 // debugger;
                 var iframe = this.getIFrameEl();
                 var Where = iframe.contentWindow.GetData(); //调用子页面的函数
                 mini.get("Where").setValue(Where);
                 KH_Customersgrid.load({ zt: 'chcx' ,Where: Where });
             }
         });
     }
     //高级查询调用函数
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
     //关闭窗口
     function CloseWindow(action) {
         if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
         else window.close();
     }
     //地图
     function Map() {
         var row = KH_Customersgrid.getSelected();
         if (row) {
             var Dm_Url = "../CustomersAspx/KH_Customers/KH_Map.htm?MapJD=" + row.Contact_JingDu + "&&MapWD=" + row.Contact_WeiDu + "&&Cust_Name=" + row.Cust_Name;
             var tab = { PARENTID: "Map" + row.Cust_ID, TEXT: row.Cust_Name + '-地理位置', URL: Dm_Url, ICON: 'icon-edit' };  //首先模拟一个tab
             parent.AddshowTab(tab);
         }
         else {
             mini.alert("请选中一条记录");
         }
     }
 </script>


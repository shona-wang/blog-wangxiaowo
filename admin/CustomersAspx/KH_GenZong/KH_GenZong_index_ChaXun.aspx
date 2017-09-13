 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GenZong_index_ChaXun.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GenZong_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>客户跟踪信息-查询页面</title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
    <%-- <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
  <a class="mini-button" iconcls="icon-folderopen" onclick="gzxx()" plain="true">详细信息</a> 
 </div>
  <input id="DJBH" name="DJBH" class="mini-hidden" />
  <div class="mini-fit">
    <div id="KH_GenZongdatagrid" class="mini-datagrid" style="height: 98%;" url="KH_GenZongData.aspx?method=KH_GenZong_Json_getSelectWhere" idfield="GZBH" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
           <div field="GZNR"  width="120" headeralign="center" allowsort="true"  >
        跟踪内容
        </div>
        <div field="LXRQ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        联系日期
        </div>
       <div field="JD"  width="120" headeralign="center" allowsort="true"  >
        经度
        </div>
        <div field="WD"  width="120" headeralign="center" allowsort="true"  >
        维度
        </div>
        <div field="DZ"  width="120" headeralign="center" allowsort="true"  >
        录入位置
        </div>
        <div field="CZSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        创建时间
        </div>
         <div field="user_ID"  width="120" headeralign="center" allowsort="true"  >
        录入人员
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
     //修改
     function gzxx() {
         var row = KH_GenZonggrid.getSelected();
         if (row) {
             mini.open({
             url: "../CustomersAspx/KH_GenZong/KH_GenZong_xx.aspx?GZBH=" + row.GZBH,
                 title: "查看-客户跟踪信息", width: 550, height: 400,
                 onload: function() {
                     
                 },
                 ondestroy: function(action) {
                     
                 }
             });
         } else {
             mini.alert("提示:请选中一条记录!");
         }
     }
 </script>


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Weixin_MenuModes_index_ChaXun.aspx.cs" Inherits="WeiXinAspx_Weixin_MenuModes_Weixin_MenuModes_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">打印预览</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="Weixin_MenuModesdatagrid" class="mini-datagrid" style="height: 98%;" url="Weixin_MenuModesData.aspx?method=Weixin_MenuModes_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="MenuKey"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="MenuHftypy"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="MenuHfCountType"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="DataTable"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="MenuHfCount"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="AccountNum"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="LLRYDWID"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="LLRYDWMC"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="LRRYZH"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true">
        XXXX
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true">
        XXXX
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
     //刷新
     function reload() {
     mini.get("Where").setValue('');
     Weixin_MenuModesgrid.load();
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
             var iframe = this.getIFrameEl();
             Where = iframe.contentWindow.GetData(); //调用子页面的函数
             mini.get("Where").setValue(Where);
             grid.load({ Where: Where });
         }
       });
    }
     //高级查询调用函数
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
     //关闭窗口
     function CloseWindow(action) {
       if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
       else window.close();
     }
 </script>


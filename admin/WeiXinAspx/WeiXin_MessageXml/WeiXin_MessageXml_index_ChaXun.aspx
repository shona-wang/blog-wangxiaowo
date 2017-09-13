 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_MessageXml_index_ChaXun.aspx.cs" Inherits="WeiXinAspx_WeiXin_MessageXml_WeiXin_MessageXml_index_ChaXun" %>
 
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_MessageXmldatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_MessageXmlData.aspx?method=WeiXin_MessageXml_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="XMLContent"  width="120" headeralign="center" allowsort="true">
        发送/接收XML
        </div>
        <div field="MessageType"  width="120" headeralign="center" allowsort="true">
        分类
        </div>
        <div field="MessageDateTime"  width="120" headeralign="center" allowsort="true">
        时间
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var WeiXin_MessageXmlgrid = mini.get("WeiXin_MessageXmldatagrid");
    WeiXin_MessageXmlgrid.load();
     //刷新
     function reload() {
     mini.get("Where").setValue('');
     WeiXin_MessageXmlgrid.load();
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
     var columns = WeiXin_MessageXmlgrid.getBottomColumns();
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


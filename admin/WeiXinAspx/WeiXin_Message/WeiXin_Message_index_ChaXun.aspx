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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">打印预览</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_Messagedatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_MessageData.aspx?method=WeiXin_Message_PageJson_SelectWhere" idfield="ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="toUserName"  width="120" headeralign="center" allowsort="true">
        接收方微信号
        </div>
        <div field="FromUserName"  width="120" headeralign="center" allowsort="true">
        发送方微信号
        </div>
        <div field="MsgType"  width="120" headeralign="center" allowsort="true">
        类型
        </div>
        <div field="Content"  width="120" headeralign="center" allowsort="true">
        信息内容
        </div>
          <div field="CreateTime"  width="120" headeralign="center" allowsort="true">
        日期
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
     //刷新
     function reload() {
     mini.get("Where").setValue('');
     WeiXin_Messagegrid.load();
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
     //关闭窗口
     function CloseWindow(action) {
       if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
       else window.close();
     }
 </script>


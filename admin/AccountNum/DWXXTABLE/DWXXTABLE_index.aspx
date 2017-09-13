 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="DWXXTABLE_Index.aspx.cs" Inherits="AccountNum_DWXXTABLE_DWXXTABLE_index" %>
 
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
    <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">编辑</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">删除</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="DWXXTABLEdatagrid" class="mini-datagrid" style="height: 98%;" url="DWXXTABLEData.aspx?method=DWXXTABLE_PageJson_SelectWhere" idfield="DJKEY" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="AccountNum"  width="120" headeralign="center" allowsort="true"  >
        帐套号
        </div>
        <div field="DWMC"  width="120" headeralign="center" allowsort="true"  >
        帐套名称
        </div>
        <div field="JZSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        建账时间
        </div>
        <div field="SRM"  width="120" headeralign="center" allowsort="true"  >
        排序号
        </div>
     <%--   <div field="BS"  width="120" headeralign="center" allowsort="true"  >
        标识
        </div>--%>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var DWXXTABLEgrid = mini.get("DWXXTABLEdatagrid");
    DWXXTABLEgrid.load();
        //添加
     function add() {
          mini.open({
          url: "DWXXTABLE_Edit.aspx",//此处注意修改
          title: "新增-帐套号", width: 400, height: 170,
          onload: function() {
              var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              DWXXTABLEgrid.reload();
          }
     });
    }
      //修改
      function edit() {
      var row =DWXXTABLEgrid.getSelected();
      if (row) {
          mini.open({
              url:"DWXXTABLE_Edit.aspx",
              title: "修改-帐套号", width: 400, height: 170,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.DJKEY }; //此处需要手动调整，代码生成器不做太多判断了
                  iframe.contentWindow.SetData(data); //调用子页面的函数
              },
              ondestroy: function(action) {
                  DWXXTABLEgrid.reload();
              }
          });
      } else {
          mini.alert("提示:请选中一条记录!");
      }
  }
     //删除
     function dels() {
     var rows = DWXXTABLEgrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("确定删除选中记录吗？", "确定？",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJKEY);//此处需要手动调整
                 }
                 var id = ids.join(',');
                 DWXXTABLEgrid.loading("操作中，请稍后......");
                 $.ajax({
                     url: "DWXXTABLEData.aspx?method=DWXXTABLE_Deletes&&DJBH=" + id,//此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         DWXXTABLEgrid.reload();
                     },
                     error: function() {
                     }
                 });
             }
         });
     } else {
        mini.alert("请选中一条记录");
     }
  }
     //刷新
     function reload() {
     mini.get("Where").setValue('');
     DWXXTABLEgrid.load();
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
     var columns = DWXXTABLEgrid.getBottomColumns();
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


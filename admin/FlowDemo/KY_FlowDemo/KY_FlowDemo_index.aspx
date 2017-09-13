 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_FlowDemo_Index.aspx.cs" Inherits="FlowDemo_KY_FlowDemo_KY_FlowDemo_index" %>
 
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">编辑</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">删除</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">打印预览</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-folderopen" plain="true" onclick="OpenFlowLook">查看流程</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <span class="separator"></span><a id="A1" class="mini-button" iconcls="icon-addfolder" plain="true" onclick="OpenYiJian()">查看处理意见</a> 
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="KY_FlowDemodatagrid" class="mini-datagrid" style="height: 98%;" url="KY_FlowDemoData.aspx?method=KY_FlowDemo_PageJson_SelectWhere" idfield="DJBH" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="XM"  width="120" headeralign="center" allowsort="true"  >
        姓名
        </div>
        <div field="NL"  width="120" headeralign="center" allowsort="true"  >
        年龄
        </div>
        <div field="SFZH"  width="120" headeralign="center" allowsort="true"  >
        身份证号
        </div>
        <div field="CSRQ"  width="120" headeralign="center" allowsort="true"  >
        出生日期
        </div>
        <div field="LRRY"  width="120" headeralign="center" allowsort="true"  >
        录入人员
        </div>
        <div field="LRRQ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        录入日期
        </div>
        <div field="DJZT"  width="120" headeralign="center" allowsort="true"  >
        单据状态
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var KY_FlowDemogrid = mini.get("KY_FlowDemodatagrid");
    KY_FlowDemogrid.load();
        //添加
     function add() {
          mini.open({
          url: "../FlowDemo/KY_FlowDemo/KY_FlowDemo_Edit.aspx",//此处注意修改
          title: "新增-工作流测试", width: 550, height: 300,
          onload: function() {
              var iframe = this.getIFrameEl();
             var data = { action: "Add" };
              iframe.contentWindow.SetData(data);
          },
          ondestroy: function(action) {
              KY_FlowDemogrid.reload();
          }
     });
    }
      //修改
      function edit() {
      var row =KY_FlowDemogrid.getSelected();
      if (row) {
          mini.open({
              url:"../FlowDemo/KY_FlowDemo/KY_FlowDemo_Edit.aspx",
              title: "修改-工作流测试", width: 550, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", DJBH: row.DJBH };//此处需要手动调整，代码生成器不做太多判断了
                  iframe.contentWindow.SetData(data); //调用子页面的函数
              },
              ondestroy: function(action) {
                  KY_FlowDemogrid.reload();
              }
          });
      } else {
          mini.alert("提示:请选中一条记录!");
      }
  }
     //删除
     function dels() {
     var rows = KY_FlowDemogrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("确定删除选中记录吗？", "确定？",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJBH);//此处需要手动调整
                 }
                 var id = ids.join(',');
                 KY_FlowDemogrid.loading("操作中，请稍后......");
                 $.ajax({
                     url: "KY_FlowDemoData.aspx?method=KY_FlowDemo_Deletes&&DJBH=" + id,//此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         KY_FlowDemogrid.reload();
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
     KY_FlowDemogrid.load();
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
     var columns = KY_FlowDemogrid.getBottomColumns();
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

   function OpenFlowLook() {
       var row = KY_FlowDemogrid.getSelected();
       mini.open({
           url: "../Flows/FlowLook.aspx?DJBH=" + row.DJBH,
           title: "流程查看",
           width: 550,
           height: 600

       });
   }
   function OpenYiJian() {
       var row = KY_FlowDemogrid.getSelected();
       mini.open({
           url: "../Flows/Flow_YiJian.aspx?billcode=" + row.DJBH,
           title: "查看处理意见",
           width: 650,
           height: 380
       });
   } 
     
   
 </script>


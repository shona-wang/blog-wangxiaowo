 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GenZong_Index.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GenZong_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>客户跟踪信息-管理页面</title>
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
   <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">编辑</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">删除</a>
      <span class="separator"></span><a class="mini-button" iconcls="icon-zoomin" onclick="Map()" plain="true">录入数据位置</a>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
     <input id="DJBH" name="DJBH" class="mini-hidden" />
 </div>
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
        //添加
     function add() {
         mini.open({
             url: "../CustomersAspx/KH_GenZong/KH_GenZong_Edit.aspx", //此处注意修改
             title: "新增-客户跟踪信息", width: 550, height: 450,
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
      //修改
      function edit() {
      var row =KH_GenZonggrid.getSelected();
      if (row) {
          mini.open({
              url:"../CustomersAspx/KH_GenZong/KH_GenZong_Edit.aspx",
              title: "修改-客户跟踪信息", width: 550, height: 450,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  //var data = { action: "Edit", DJBH: row.DJBH };//此处需要手动调整，代码生成器不做太多判断了
                  var data = { action: "Edit", GZBH: row.GZBH, Cust_ID: mini.get("DJBH").getValue() }; //此处需要手动调整，代码生成器不做太多判断了
                  iframe.contentWindow.SetData(data); //调用子页面的函数
              },
              ondestroy: function(action) {
                  KH_GenZonggrid.reload();
              }
          });
      } else {
          mini.alert("提示:请选中一条记录!");
      }
  }
     //删除
     function dels() {
     var rows = KH_GenZonggrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("确定删除选中记录吗？", "确定？",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.GZBH);//此处需要手动调整
                 }
                 var id = ids.join(',');
                 KH_GenZonggrid.loading("操作中，请稍后......");
                 $.ajax({
                 url: "KH_GenZongData.aspx?method=KH_GenZong_Deletes&&DJBH=" + id, //此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         KH_GenZonggrid.reload();
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
     KH_GenZonggrid.load();
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
     //关闭窗口
     function CloseWindow(action) {
       if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
       else window.close();
   }
   //地图
   function Map() {
       //debugger;
       var row = KH_GenZonggrid.getSelected();
       if (row) {
           mini.open({
           url:  "../CustomersAspx/KH_Customers/KH_Map.htm?MapJD=" + row.JD + "&&MapWD=" + row.WD + "&&Cust_Name=" + row.DZ, //此处注意修改
               title: "数据录入位置", width: 550, height: 450,
               onload: function() {
                  
               },
               ondestroy: function(action) {
                  
               }
           });
       }
       else {
           mini.alert("请选中一条记录");
       }
   }
 </script>


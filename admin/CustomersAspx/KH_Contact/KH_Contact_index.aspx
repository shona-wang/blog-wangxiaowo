 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_Index.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>客户联系人-管理页面</title>
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
    <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">编辑</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">删除</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">打印预览</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="DJBH" name="DJBH" class="mini-hidden" />
    
 </div>
  <div class="mini-fit">
    <div id="KH_Contactdatagrid" class="mini-datagrid" style="height: 98%;" url="KH_ContactData.aspx?method=KH_Contact_Json_getSelectWhere" idfield="Contact_ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
       <%-- <div field="Cust_ID"  width="120" headeralign="center" allowsort="true"  >
        客户单据号
        </div>--%>
        <div field="Contact_Name"  width="120" headeralign="center" allowsort="true"  >
        联系人
        </div>
        <div field="Contact_Sex"  width="120" headeralign="center" allowsort="true"  >
        性别
        </div>
        <div field="Contact_Birthday"  width="120" headeralign="center" allowsort="true"  >
        生日
        </div>
        <div field="Contact_Department"  width="120" headeralign="center" allowsort="true"  >
        部门
        </div>
        <div field="Contact_Func"  width="120" headeralign="center" allowsort="true"  >
        职务
        </div>
        <div field="Contact_IsMain"  width="120" headeralign="center" allowsort="true"  >
        是否主要联系人
        </div>
        <div field="Contact_PhoneWork"  width="120" headeralign="center" allowsort="true"  >
        办公电话
        </div>
        <div field="Contact_Fax"  width="120" headeralign="center" allowsort="true"  >
        传真
        </div>
        <div field="Contact_Mobile"  width="120" headeralign="center" allowsort="true"  >
        手机号
        </div>
        <div field="Contact_PhoneHome"  width="120" headeralign="center" allowsort="true"  >
        家庭电话
        </div>
        <div field="Contact_Mail"  width="120" headeralign="center" allowsort="true"  >
        电子邮件
        </div>
        <div field="Contact_Address"  width="120" headeralign="center" allowsort="true"  >
        地址
        </div>
        <div field="Contact_QQ"  width="120" headeralign="center" allowsort="true"  >
        QQ号
        </div>
        <div field="Contact_Memo"  width="120" headeralign="center" allowsort="true"  >
        备注
        </div>
        <div field="LRRY"  width="120" headeralign="center" allowsort="true"  >
         录入人员
        </div>
        <div field="LRSJ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
         录入时间
        </div>
      </div>
    </div>
  </div>
 </body>
 </html>
 <script type="text/javascript">
    mini.parse();
    var KH_Contactgrid = mini.get("KH_Contactdatagrid");
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("DJBH").setValue(DJBH);
        KH_Contactgrid.load({DJBH:mini.get("DJBH").getValue()});
    });
    
        //添加
     function add() {
         mini.open({
             url: "../CustomersAspx/KH_Contact/KH_Contact_Edit.aspx", //此处注意修改
             title: "新增-客户联系人", width: 550, height: 300,
             onload: function() {
                 //debugger;
                 var iframe = this.getIFrameEl();
                 var data = { action: "Add", Cust_ID: mini.get("DJBH").getValue() };
                 iframe.contentWindow.SetData(data);
             },
             ondestroy: function(action) {
                 KH_Contactgrid.reload();
             }
         });
    }
      //修改
    function edit() {
        //debugger;
      var row =KH_Contactgrid.getSelected();
      if (row) {
          mini.open({
              url:"../CustomersAspx/KH_Contact/KH_Contact_Edit.aspx",
              title: "修改-客户联系人", width: 550, height: 300,
              onload: function() {
                  var iframe = this.getIFrameEl();
                  var data = { action: "Edit", Contact_ID: row.Contact_ID, Cust_ID: mini.get("DJBH").getValue() }; //此处需要手动调整，代码生成器不做太多判断了
                  iframe.contentWindow.SetData(data); //调用子页面的函数
              },
              ondestroy: function(action) {
                  KH_Contactgrid.reload();
              }
          });
      } else {
          mini.alert("提示:请选中一条记录!");
      }
  }
     //删除
     function dels() {
     var rows = KH_Contactgrid.getSelecteds();
     if (rows.length > 0) {
         mini.confirm("确定删除选中记录吗？", "确定？",
         function(action) {
             if (action =="ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.Contact_ID); //此处需要手动调整
                 }
                 var id = ids.join(',');
                 KH_Contactgrid.loading("操作中，请稍后......");
                 $.ajax({
                 url: "KH_ContactData.aspx?method=KH_Contact_Deletes&&DJBH=" + id, //此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         KH_Contactgrid.reload();
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
     KH_Contactgrid.load();
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
     var columns = KH_Contactgrid.getBottomColumns();
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


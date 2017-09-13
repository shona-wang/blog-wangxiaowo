 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiXin_AccountContro_Index.aspx.cs" Inherits="WeiXinAspx_WeiXin_AccountContro_WeiXin_AccountContro_index" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
<%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
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
<%--    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a>--%>
 <%--   <span class="separator"></span>--%><a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> 
    <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()" plain="true">编辑</a>
     <span class="separator"></span><a class="mini-button" iconcls="icon-find" onclick="sz()" plain="true">设置</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
  <span class="separator"></span><a class="mini-button" iconcls="icon-remove" onclick="dels()" plain="true">删除</a>
<%--    <span class="separator"></span><a class="mini-button" iconcls="icon-print" onclick="print()" plain="true">打印预览</a>--%>
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
    <input id="Where" name="Where" class="mini-hidden" />
 </div>
  <div class="mini-fit">
    <div id="WeiXin_AccountControdatagrid" class="mini-datagrid" style="height: 98%;" url="WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_PageJson_SelectWhere" idfield="DJKEY" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
        <div type="checkcolumn">
        </div>
        <div field="MC"  width="120" headeralign="center" allowsort="true"  >
        名称
        </div>
        <div field="TX"  width="120" headeralign="center" allowsort="true"  >
        头像
        </div>
        <div field="DLYX"  width="120" headeralign="center" allowsort="true"  >
        登录邮箱
        </div>
        <div field="YSID"  width="120" headeralign="center" allowsort="true"  >
        原始ID
        </div>
        <div field="WXH"  width="120" headeralign="center" allowsort="true"  >
        微信号
        </div>
        <div field="LX"  width="120" headeralign="center" allowsort="true"  >
        类型
        </div>
        <div field="RZQK"  width="120" headeralign="center" allowsort="true"  >
        认证情况
        </div>
        <div field="ZTXX"  width="120" headeralign="center" allowsort="true"  >
        主体信息
        </div>
        <div field="JS"  width="120" headeralign="center" allowsort="true"  >
        介绍
        </div>
        <div field="SZDZ"  width="120" headeralign="center" allowsort="true"  >
        所在地址
        </div>
        <div field="EWM"  width="120" headeralign="center" allowsort="true"  >
        二维码
        </div>
        <div field="LRRYXM"  width="120" headeralign="center" allowsort="true"  >
        录入人员姓名
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
    var WeiXin_AccountControgrid = mini.get("WeiXin_AccountControdatagrid");
    WeiXin_AccountControgrid.load();
        //添加
    function add() {
        mini.open({
            url: "../WeiXinAspx/WeiXin_AccountContro/WeiXin_AccountContro_Edit.aspx", //此处注意修改
            title: "新增-企业微信号", width: 600, height: 650,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                WeiXin_AccountControgrid.reload();
            }
        });
    }
      //修改
    function edit() {
        var row = WeiXin_AccountControgrid.getSelected();
        if (row) {
            mini.open({
                url: "../WeiXinAspx/WeiXin_AccountContro/WeiXin_AccountContro_Edit.aspx",
                title: "修改-企业微信号", width: 600, height: 650,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.DJKEY }; //此处需要手动调整，代码生成器不做太多判断了
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                },
                ondestroy: function(action) {
                    WeiXin_AccountControgrid.reload();
                }
            });
        } else {
            mini.alert("提示:请选中一条记录!");
        }
    }
     //删除
     function dels() {
     var rows = WeiXin_AccountControgrid.getSelecteds();
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
                 WeiXin_AccountControgrid.loading("操作中，请稍后......");
                 $.ajax({
                     url: "WeiXin_AccountControData.aspx?method=WeiXin_AccountContro_Deletes&&DJBH=" + id,//此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         WeiXin_AccountControgrid.reload();
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
     WeiXin_AccountControgrid.load();
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
             var Where = iframe.contentWindow.GetData(); //调用子页面的函数
             mini.get("Where").setValue(Where);
             grid.load({ Where: Where });
         }
     });
   }
     //高级查询调用函数
     function _getColumns() {
     var columns = WeiXin_AccountControgrid.getBottomColumns();
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
   WeiXin_AccountControgrid.on("drawcell", function(e) {
       var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
       //将性别文本替换成图片
       if (column.field == "TX") {
           e.cellHtml = '<img  src="../../UploadFiles/' + e.value + '" style="width: 150px; height: 150px;" />';
       }
       if (column.field == "EWM") {
           e.cellHtml = '<img  src="../../UploadFiles/' + e.value + '" style="width: 150px; height: 150px;" />';
       }
   })
   function sz() {
       var row = WeiXin_AccountControgrid.getSelected();
       if (row) {
           var tab = { PARENTID: row.DJKEY, TEXT: row.MC, URL: '../WeiXinAspx/MenuIndex.aspx?WeiXinCode=' + row.YSID, IMAGE: 'icon-node' };  //首先模拟一个tab
           parent.AddshowTab(tab);
       } else {
           mini.alert("提示:请选中一条记录!");
       }
   }
 </script>


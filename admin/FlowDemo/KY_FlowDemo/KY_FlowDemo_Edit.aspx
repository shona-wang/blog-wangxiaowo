 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_FlowDemo_Edit.aspx.cs" Inherits="FlowDemo_KY_FlowDemo_KY_FlowDemo_Edit" %>
 
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
        <a class="mini-button" iconcls="icon-add" onclick="SaveData" plain="true">保存提交</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="SaveData"
            plain="true">保存关闭</a><span class="separator"></span> <a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a>
    </div>
 <form id="form1">
   <table style="text-align: right; width: 500px;">
    <tr>
     <td style="text-align:right;">姓名</td>
    <td style="text-align:left;"><input id="XM" name="XM" class="mini-textbox" required="true"/></td>
    <td style="text-align:right;">年龄</td>
     <td style="text-align:left;"><input id="NL" name="NL" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">身份证号</td>
    <td style="text-align:left;"><input id="SFZH" name="SFZH" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">出生日期</td>
     <td style="text-align:left;"><input id="CSRQ" name="CSRQ" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
       <td style="text-align:right;">选择流程</td>
    <td style="text-align:left;" colspan="3">
        <input id="LC" name="LC" class="mini-combobox" textfield="MC" valuefield="NODE_ID"
                    url="../../Flows/Flows_Data.aspx?method=Get_SelTable06"  showNullItem="true"/>
    </td> 
    </tr>
    <tr>
     <td colspan="4" style="text-align: center;">
           <input id="mytype" name="mytype" class="mini-hidden" />
           <input id="DJBH" name="DJBH" class="mini-hidden" />
            <input id="BCBS" name="BCBS" class="mini-hidden" />
     </td>
     </tr>
   </table>
 </form>
 </body>
 </html>
 <script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
   //保存函数
    function SaveData(e) {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        if (e.source.text == "保存关闭") {
            mini.get("BCBS").setValue("BCGB");
        }
        else {
            //debugger;
            mini.get("BCBS").setValue("BCTJ");
            var vv = mini.get("LC").getValue();
            if (mini.get("LC").getValue() == "" || mini.get("LC").getValue() ==undefined) {
                mini.alert("请选择流程");
                return
            }
        }
        $.ajax({
        url: "KY_FlowDemoData.aspx?method=KY_FlowDemo_Insert",
        data: { data: json },
        type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("提示:数据操作失败!");
                }
                else {
                    CloseWindow();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    ////////////////////
    //标准方法接口定义
    function SetData(data) {
       if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
           $.ajax({
            url: "KY_FlowDemoData.aspx?method=KY_FlowDemo_Json_SelectWhere&DJBH=" + data.DJBH,
                cache: false,
               success: function(text) {
                   var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                }
           });
        }
        else {
            mini.get("mytype").setValue("Add");
        }
    }
  //关闭
  function CloseWindow(action) {
  if (action == "close" && form.isChanged()) {
      if (confirm("数据被修改了，是否先保存？")) {
          return false;
      }
   }
  if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
    else window.close();
  }
 </script>


 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_Edit.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title></title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
   <%--  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />--%>
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
 <form id="form1">
   <table style="text-align: right; width: 500px;">
    <tr>
     <td style="text-align:right;">联系人姓名</td>
    <td style="text-align:left;"><input id="Contact_Name" name="Contact_Name" class="mini-textbox" required="true"/></td>
    <td style="text-align:right;">生日</td>
     <td style="text-align:left;"><input id="Contact_Birthday" name="Contact_Birthday" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">性别</td>
    <td style="text-align:left;"><%--<input id="Contact_Sex" name="Contact_Sex" class="mini-textbox" required="false"/>--%>
    <select id="Contact_Sex" name="Contact_Sex" class="mini-radiobuttonlist">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
    </td>
    <td style="text-align:right;">QQ号</td>
     <td style="text-align:left;"><input id="Contact_QQ" name="Contact_QQ" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">部门</td>
    <td style="text-align:left;"><input id="Contact_Department" name="Contact_Department" class="mini-textbox" /></td>
    <td style="text-align:right;">职务</td>
     <td style="text-align:left;"><input id="Contact_Func" name="Contact_Func" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">是否主要联系人</td>
    <td style="text-align:left;"><%--<input id="Contact_IsMain" name="Contact_IsMain" class="mini-textbox" required="false"/>--%>
       <select id="Contact_IsMain" name="Contact_IsMain" class="mini-radiobuttonlist">
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
    </td>
    <td style="text-align:right;">办公电话</td>
     <td style="text-align:left;"><input id="Contact_PhoneWork" name="Contact_PhoneWork" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">传真</td>
    <td style="text-align:left;"><input id="Contact_Fax" name="Contact_Fax" class="mini-textbox" /></td>
    <td style="text-align:right;">手机号</td>
     <td style="text-align:left;"><input id="Contact_Mobile" name="Contact_Mobile" class="mini-textbox" required="true"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">家庭电话</td>
    <td style="text-align:left;"><input id="Contact_PhoneHome" name="Contact_PhoneHome" class="mini-textbox" /></td>
    <td style="text-align:right;">电子邮件</td>
     <td style="text-align:left;"><input id="Contact_Mail" name="Contact_Mail" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td style="text-align:right;">地址</td>
    <td style="text-align:left;"><input id="Contact_Address" name="Contact_Address" class="mini-textbox" /></td>
    <td style="text-align:right;">备注</td>
     <td style="text-align:left;"><input id="Contact_Memo" name="Contact_Memo" class="mini-textbox" /></td>
    </tr>
    <tr>
     <td colspan="4" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">关闭</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="Contact_ID" name="Contact_ID" class="mini-hidden" />
        <input id="Cust_ID" name="Cust_ID" class="mini-hidden" />
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
    function SaveData() {
    //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "KH_ContactData.aspx?method=KH_Contact_Insert",
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
        debugger;
        if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
           $.ajax({
           url: "KH_ContactData.aspx?method=KH_Contact_Json_SelectWhere&DJBH=" + data.Contact_ID,
                cache: false,
               success: function(text) {
                   var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    mini.get("Cust_ID").setValue(data.Cust_ID);
                    mini.get("Contact_ID").setValue(data.Contact_ID);
                    
                }
           });
        }
        else {
            debugger;
            mini.get("mytype").setValue("Add");
            mini.get("Cust_ID").setValue(data.Cust_ID);
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


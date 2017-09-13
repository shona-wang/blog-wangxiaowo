<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_xx.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_xx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户-联系人查看页面</title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
  <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
    <td style="text-align:left;"><input id="Contact_Name" name="Contact_Name" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">生日</td>
     <td style="text-align:left;"><input id="Contact_Birthday" name="Contact_Birthday" class="mini-textbox" required="false"/></td>
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
     <td style="text-align:left;"><input id="Contact_QQ" name="Contact_QQ" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">部门</td>
    <td style="text-align:left;"><input id="Contact_Department" name="Contact_Department" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">职务</td>
     <td style="text-align:left;"><input id="Contact_Func" name="Contact_Func" class="mini-textbox" required="false"/></td>
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
    <td style="text-align:left;"><input id="Contact_Fax" name="Contact_Fax" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">手机号</td>
     <td style="text-align:left;"><input id="Contact_Mobile" name="Contact_Mobile" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">家庭电话</td>
    <td style="text-align:left;"><input id="Contact_PhoneHome" name="Contact_PhoneHome" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">电子邮件</td>
     <td style="text-align:left;"><input id="Contact_Mail" name="Contact_Mail" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">地址</td>
    <td style="text-align:left;"><input id="Contact_Address" name="Contact_Address" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">备注</td>
     <td style="text-align:left;"><input id="Contact_Memo" name="Contact_Memo" class="mini-textbox" required="false"/></td>
    </tr>
   </table>
 </form>
 <input id="Contact_ID" name="Contact_ID" class="mini-hidden" />
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");

    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        var Contact_ID = Request["Contact_ID"];
        mini.get("Contact_ID").setValue(Contact_ID);
        $.ajax({
            url: "KH_ContactData.aspx?method=KH_Contact_Json_SelectWhere&DJBH=" + Contact_ID,
            cache: false,
            success: function(text) {
                var o = mini.decode(text);
                form.setData(o);
                labelModel();
            }
        });
    });

    function labelModel() {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(true);     //只读
            if (c.setIsValid) c.setIsValid(true);      //去除错误提示
            if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
        }
    }
   
 </script>
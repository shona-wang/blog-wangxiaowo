<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_XX.aspx.cs" Inherits="CustomersAspx_KH_Customers_KH_XX" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户信息-查看页面</title>
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
             #Cust_SerialNO
             {
                 width: 193px;
             }
             #Cust_Name
             {
                 width: 190px;
             }
             #Cust_City
             {
                 width: 191px;
             }
             #Cust_Rate
             {
                 width: 190px;
             }
             #Cust_Type
             {
                 width: 189px;
             }
             #Cust_Trade
             {
                 width: 188px;
             }
             .style1
             {
                 width: 222px;
             }
             #Cust_Address
             {
                 width: 237px;
             }
             #Cust_PostCode
             {
                 width: 235px;
             }
             #Cust_HomePage
             {
                 width: 234px;
             }
             #Cust_Habit
             {
                 width: 233px;
             }
             #Cust_Source
             {
                 width: 232px;
             }
             #Cust_Memo
             {
                 width: 232px;
             }
    .asLabel .mini-textbox-input,
    .asLabel .mini-buttonedit-border,
    .asLabel .mini-buttonedit-input,
    .asLabel .mini-textboxlist-border
    {
        border:0;background:none;cursor:default;
    }
    .asLabel .mini-buttonedit-button,
    .asLabel .mini-textboxlist-close
    {
        display:none;
    }
    .asLabel .mini-textboxlist-item
    {
        padding-right:8px;
    } 
     </style>
</head>
<body>
<fieldset id="fd1" style="width:100%;">
        <legend>客户信息</legend>
   <form id="form1">
   <table style="text-align: right; width: 739px; height: 272px;">
    <tr>
     <td style="text-align:right;">客户编号:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_SerialNO" name="Cust_SerialNO" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">地址:</td>
     <td style="text-align:left;"><input id="Cust_Address" name="Cust_Address" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">客户名称:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Name" name="Cust_Name" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">邮政编码:</td>
     <td style="text-align:left;"><input id="Cust_PostCode" name="Cust_PostCode" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">城市:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_City" name="Cust_City" class="mini-textbox" required="false"/></td>
    <td style="text-align:right;">公司主页:</td>
     <td style="text-align:left;"><input id="Cust_HomePage" name="Cust_HomePage" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">客户等级:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Rate" name="Cust_Rate" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHDJ" /></td>
    <td style="text-align:right;">客户状态:</td>
     <td style="text-align:left;"><input id="Cust_Habit" name="Cust_Habit" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHZT"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">客户类型:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Type" name="Cust_Type" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHLX"/></td>
    <td style="text-align:right;">客户来源:</td>
     <td style="text-align:left;"><input id="Cust_Source" name="Cust_Source" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHLY"/></td>
    </tr>
    <tr>
     <td style="text-align:right;">行业类别:</td>
    <td style="text-align:left;" class="style1"><input id="Cust_Trade" name="Cust_Trade" class="mini-combobox" valuefield="MC" textfield="MC" url="../../WindowsAspx/AspxDate.aspx?method=Select_Where&&YWLX=KHHY"/></td>
    <td style="text-align:right;">备注:</td>
     <td style="text-align:left;"><input id="Cust_Memo" name="Cust_Memo" class="mini-textbox" required="false"/></td>
    </tr>
    <tr>
     <td colspan="4" style="text-align: center;">
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="Cust_ID" name="Cust_ID" class="mini-hidden" />
     </td>
     </tr>
   </table>
 </form>
 </fieldset>
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");

    $(window).load(function() {
        debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("Cust_ID").setValue(DJBH);
        $.ajax({
            url: "KH_CustomersData.aspx?method=KH_Customers_Json_SelectWhere&DJBH=" + DJBH,
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
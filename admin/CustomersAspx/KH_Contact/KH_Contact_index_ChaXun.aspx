 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_Contact_index_ChaXun.aspx.cs" Inherits="CustomersAspx_KH_Contact_KH_Contact_index_ChaXun" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>客户联系人-查询页面</title>
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
  <a class="mini-button" iconcls="icon-folderopen" onclick="lxrxx()" plain="true">详细信息</a> 
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
        debugger;
        var Request = new QueryString();
        var DJBH = Request["DJBH"];
        mini.get("DJBH").setValue(DJBH);
        KH_Contactgrid.load({DJBH:mini.get("DJBH").getValue()});
    });
    //修改
    function lxrxx() {
        //debugger;
        var row = KH_Contactgrid.getSelected();
        if (row) {
            mini.open({
            url: "../CustomersAspx/KH_Contact/KH_Contact_xx.aspx?Contact_ID=" + row.Contact_ID,
                title: "客户-联系人信息", width: 600, height: 300,
                onload: function() {

                },
                ondestroy: function(action) {

                }
            });
        } else {
            mini.alert("提示:请选中一条记录!");
        }
    }
 </script>


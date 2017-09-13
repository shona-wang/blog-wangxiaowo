<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_ChaXun_Tab.aspx.cs" Inherits="CustomersAspx_KH_Customers_KH_ChaXun_Tab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../scripts/boot.js" type="text/javascript"></script>
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script><style type="text/css">
        body
        {
            margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
        }   
        </style> 
</head>
<body>
   <div id="tabs1" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
     onactivechanged="onTabsActiveChanged" 
>
    <div title="客户信息" >
         <iframe  id="KHXX" frameborder="0" name="main" style="width:100%;height:100%;" border="0"></iframe>
    </div>
    <div title="联系人信息"  >
        <iframe  id="LXRXX" frameborder="0" name="main" style="width:100%;height:100%;" border="0"></iframe>
    </div>
    <div title="跟踪信息" >
         <iframe  id="GZXX" frameborder="0" name="main" style="width:100%;height:100%;" border="0"></iframe>
    </div>
</div>
 <input id="Cust_ID" name="Cust_ID" class="mini-hidden"  />
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var Request = new QueryString();
    mini.get("Cust_ID").setValue(Request["Cust_ID"]);
    function onTabsActiveChanged(e) {
        //debugger;
        var Cust_ID = mini.get("Cust_ID").getValue();
        var mainframe;
        if (e.tab.title == "客户信息") {
            mainframe = document.getElementById("KHXX");
            mainframe.src = "../KH_Customers/KH_XX.aspx?DJBH=" + mini.get("Cust_ID").getValue();
        }
        if (e.tab.title == "联系人信息") {
            mainframe = document.getElementById("LXRXX");
            mainframe.src = "../KH_Contact/KH_Contact_index_ChaXun.aspx?DJBH=" + mini.get("Cust_ID").getValue();
        }
        if (e.tab.title == "跟踪信息") {
            mainframe = document.getElementById("GZXX");
            mainframe.src = "../KH_GenZong/KH_GenZong_index_ChaXun.aspx?DJBH=" + mini.get("Cust_ID").getValue();
        }
    }
     </script>
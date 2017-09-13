<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GenZong_xx.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GenZong_xx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户-跟踪信息查看页面</title>
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
             #GZNR
             {
                 width: 360px;
                 height: 169px;
             }
             #fileupload1
             {
                 width: 294px;
             }
             .style1
             {
                 width: 79px;
             }
             #JD
             {
                 width: 358px;
             }
             #WD
             {
                 width: 357px;
             }
             #LXRQ
             {
                 width: 355px;
             }
             .style2
             {
                 width: 107px;
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
   <form id="form1">
   <table style="text-align: right; width: 500px;">
    <tr>
     <td style="text-align:right;" class="style2">跟踪内容</td>
    <td style="text-align:left;"><input id="GZNR" name="GZNR" class="mini-textarea" required="false"/></td>
    </tr>
    <tr>
     <td style="text-align:right;" class="style2">联系日期</td>
    <td style="text-align:left;" class="style1"><input id="LXRQ" name="LXRQ" class="mini-datepicker" allowInput="flase" required="false"/></td>
    </tr>
      <tr>
      <td class="style2"></td>
            <td style="text-align: left">
                <div id="listbox2" class="mini-listbox" style="width: 360px; height: 100px;" value=""
                    showcheckbox="true" multiselect="false" showallcheckbox="false">
                    <div property="columns">
                        <div type="indexcolumn" style="width: 6px;" headeralign="center">
                            序号</div>
                        <div header="文件名" field="Docname" renderer="DownLoad" style="text-align: center">
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="GZBH" name="GZBH" class="mini-hidden" />
        <input id="Cust_ID" name="Cust_ID" class="mini-hidden"/>
     </td>
     </tr>
   </table>
 </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
     $(window).load(function() {
         var Request = new QueryString();
         var GZBH = Request["GZBH"];
         mini.get("GZBH").setValue(GZBH);
         $.ajax({
             url: "KH_GenZongData.aspx?method=KH_GenZong_Json_SelectWhere&DJBH=" + GZBH,
             cache: false,
             success: function(text) {
                 debugger;
                 var o = mini.decode(text);
                 form.setData(o);
                 var url = "../../WindowsAspx/AspxDate.aspx?method=FJ_Select&DJBH=" + GZBH;
                 var listbox = new mini.get("listbox2");
                 listbox.load(url);
                 labelModel()
             }
         });
     });
 //下载
 function DownLoad(e) {
     var rows = e.row;
     var s = ' <a  href="../../UploadFiles/' + e.item.FPath + '">' + e.value + '</a>';
     return s;
 }
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
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GengZong_TongJi_index.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GengZong_TongJi_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>跟踪信息录入统计</title>
      <script src="../../scripts/boot.js" type="text/javascript"></script>
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
    <a class="mini-button" iconcls="icon-search" onclick="SeelctCx()" plain="true">查询</a><span class="separator"></span>
     <a class="mini-button" iconcls="icon-reload" onclick="sx()" plain="true">刷新</a><span class="separator"></span>
     <a class="mini-button" iconcls="icon-node" onclick="gzxx()" plain="true">详细信息</a> 
     
    <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
 </div>
  <fieldset id="fd1" style="width:98%;">
        <legend>查询条件</legend>        用户: <input id="yhm" name="yhm" class="mini-buttonedit" onbuttonclick="onButtonEdit"
                    allowinput="false" />        开始日期:<input id="KSRQ" name="KSRQ" class="mini-datepicker"  style="width: 150px;" format="yyyy-MM-dd" allowInput="false"/>        至:<input id="JZRQ" name="JZRQ" class="mini-datepicker"  style="width: 150px;" format="yyyy-MM-dd" allowInput="false"/></fieldset>
<div class="mini-fit">
    <div id="KH_Customersdatagrid" class="mini-datagrid" style="height: 100%;" url="KH_GenZongData.aspx?method=KH_GenZong_Tongji" idfield="Cust_ID" allowresize="true" pagesize="100" allowcellselect="true" multiselect="true">
      <div property="columns">
         <div type="checkcolumn">
        </div>
        <div field="LXRQ"  width="120" headeralign="center" allowsort="true"  dateFormat="yyyy-MM-dd">
        联系日期
        </div>
        <div field="GZNR"  width="120" headeralign="center" allowsort="true"  >
        跟踪内容
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
    var KH_Customersgrid = mini.get("KH_Customersdatagrid");
    KH_Customersgrid.load({yhm:'',ksrq:'',jzrq:''});
    var btnEdit = mini.get("yhm");
    function onButtonEdit(e) {
        //var btnEdit = this;
        mini.open({
        url: "UserSinglePossessive.aspx",
            showMaxButton: false,
            title: "人选选择",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                        //debugger;
                        btnEdit.setValue(data.XX);
                        btnEdit.setText(data.XX);
                    }
                }
            }
        });
    }
    function SeelctCx() {
        KH_Customersgrid.load({ yhm: mini.get("yhm").getValue(), ksrq: mini.get("KSRQ").getValue(), jzrq: mini.get("JZRQ").getValue() });
    }
    function gzxx() {
        var row = KH_Customersgrid.getSelected();
        if (row) {
            mini.open({
                url: "../CustomersAspx/KH_GenZong/KH_GenZong_xx.aspx?GZBH=" + row.GZBH,
                title: "查看-客户跟踪信息", width: 550, height: 400,
                onload: function() {

                },
                ondestroy: function(action) {

                }
            });
        } else {
            mini.alert("提示:请选中一条记录!");
        }
    }
    function sx() {
        mini.get("yhm").setValue('');
        mini.get("yhm").setText('');
        mini.get("KSRQ").setValue('');
        mini.get("JZRQ").setValue('');
        KH_Customersgrid.load({ yhm: mini.get("yhm").getValue(), ksrq: mini.get("KSRQ").getValue(), jzrq: mini.get("JZRQ").getValue() });
    }
</script>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="User_DataRoles_serup.aspx.cs" Inherits="WindowsAspx_User_DataRoles_serup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户数据范围设置</title>
      <script src="../scripts/boot.js" type="text/javascript"></script>
 <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
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
     <div class="mini-toolbar">
          <a class="mini-button" iconcls="icon-save" onclick="UserDataRolesSave()"
                plain="true">保存</a> <span class="separator"></span>
             
                <a class="mini-button" iconcls="icon-close"
                    onclick="CloseWindow()" plain="true">关闭</a>
        </div><table>
   <tr>
     <td>
      <fieldset id="fd1" style="width:201px; height:550px;">
        <legend>用户</legend>
    <div id="listbox1" class="mini-listbox" style="width:200px;height:96%;"
    textField="XX" valueField="YHM" 
    url="AspxDate.aspx?method=Select_Rydj" onitemclick="ListItemClick">
</div>
</fieldset>
     </td>
     <td>
     <fieldset id="Fieldset1" style="width:201px; height:550px;">
        <legend>用户数据范围设置</legend>
        <div id="SJFW"  class="mini-checkboxlist" repeatItems="1" repeatLayout="table" multiSelect="false"
        textField="text" valueField="id" 
        url="DateFanWei.txt" >
    </div>
</fieldset>
     </td>
   </tr>
</table>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var ListBox = mini.get("listbox1");
    var ListBoxSJFW = mini.get("SJFW");
    $(window).load(function() {
        ListBoxLoad();
        ListBox.select(0);
        SJFWLoad();
    })
    function ListBoxLoad(){
        var SJFW="";
        $.ajax({
            url: "AspxDate.aspx?method=getUserSjfw",
            cache: false,
            success: function(text) {
                SJFW = text;
                RemoListBox(SJFW);
            }
        });
    }
    function RemoListBox(SJFW) {
        var items = [];
        if (SJFW == "XSBM") {
            var QB = ListBoxSJFW.getItem('QB');
            items[0] = QB;
            ListBoxSJFW.removeItems(items);
        }
        if (SJFW == "SZBM") {
            var QB = ListBoxSJFW.getItem('QB');
            var XSBM = ListBoxSJFW.getItem('XSBM');
            items[0] = QB;
            items[1] = XSBM;
            ListBoxSJFW.removeItems(items);
        }
        if (SJFW == "BR" || SJFW == "") {
            var QB = ListBoxSJFW.getItem('QB');
            var XSBM = ListBoxSJFW.getItem('XSBM');
            var SZBM = ListBoxSJFW.getItem('SZBM');
            items[0] = QB;
            items[1] = XSBM;
            items[2] = SZBM;
            ListBoxSJFW.removeItems(items);
        }
    }
    function ListItemClick() {
        SJFWLoad();
    }
    function SJFWLoad() {
        $.ajax({
        url: "AspxDate.aspx?method=RydjGetuser&yhm=" + ListBox.getValue(),
            cache: false,
            success: function(text) {
                //debugger;
                var o = mini.decode(text);
                ListBoxSJFW.setValue(o.SJFW);
            }
        });
    }
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function UserDataRolesSave() {
        //debugger;
        if (ListBox.getValue() != "") {
            $.ajax({
                url: "AspxDate.aspx?method=UpdateRydjDataRoles",
                data: { Userid: ListBox.getValue(), SJFW: ListBoxSJFW.getValue() },
                type: "post",
                success: function(text) {
                    if (text != -1) {
                        mini.alert("设置成功!");
                    } else {
                    mini.alert("设置失败!");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }
        else {
            mini.alert("请您选择用户!");
        }
    }
</script>
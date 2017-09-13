<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employees_TreeEdit.aspx.cs" Inherits="WindowsAspx_Employees_TreeEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>组织机构编辑页面</title>
     <script src="../scripts/boot.js" type="text/javascript"></script>
    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
        .style1
        {
            width: 92px;
        }
        .style2
        {
            width: 256px;
        }
        .style3
        {
            width: 72px;
        }
        #btnEdit1
        {
            width: 173px;
        }
        .mini-textbox
        {
            width: 170px;
        }
    </style>
</head>
<body>
 <form id="form1" method="post">
 <br />
    <table style="width: 681px;">
       <tr>
          <td class="style1" style="text-align: right">上级部门:</td>
          <td class="style2">
             <input id="btnEdit1" name="FJDDM" class="mini-buttonedit" onbuttonclick="onButtonEdit"
                    allowinput="false" />
                     <a class="mini-button" iconcls="icon-upgrade" onclick="Clert()"></a>
          </td>
          <td class="style3" style="text-align: right">编码:</td>
          <td>
              <input name="BM" class="mini-textbox"/>
          </td>
       </tr>
       <tr>
          <td class="style1" style="text-align: right">名称:</td>
          <td class="style2">
              <input name="MC" class="mini-textbox"/>
          </td>
          <td class="style3" style="text-align: right">邮编</td>
          <td>
              <input name="ZYYW" class="mini-textbox"/>
          </td>
       </tr>
       <tr>
          <td class="style1" style="text-align: right">电话:</td>
          <td class="style2">
             <input name="DH" class="mini-textbox"/>
          </td>
          <td class="style3" style="text-align: right">联系人</td>
          <td>
              <input name="LXR" class="mini-textbox"/>
          </td>
       </tr>
       <tr>
          <td class="style1" style="text-align: right">位置:</td>
          <td class="style2">
               <input name="WZ" class="mini-textbox"/>
          </td>
          <td class="style3" style="text-align: right">其他:</td>
          <td>
              <input name="QT" class="mini-textbox"/>
          </td>
       </tr>
       <tr>
          <td class="style1" style="text-align: right">经度:</td>
          <td class="style2">
               <input name="JD" class="mini-textbox"/>
          </td>
          <td class="style3" style="text-align: right">纬度:</td>
          <td>
              <input name="WD" class="mini-textbox"/>
          </td>
       </tr>
       <tr>
          <td colspan="4" style=" text-align:center">
              <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="onCancel">关闭</a>
                <input name="DWID" class="mini-hidden"/>
                <input name="JDDM" class="mini-hidden"/>
                <input id="XH" name="XH" class="mini-hidden"/>
          </td>
       </tr>
    </table>
    </form>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("form1");
    var btnEdit = mini.get("btnEdit1");
    //部门选择
    function onButtonEdit(e) {
        //var btnEdit = this;
        mini.open({
            url: "EmpTree.aspx",
            showMaxButton: false,
            title: "选择树",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                       //debugger;
                        //var dwid = _dwid(data.id);
                        btnEdit.setValue(data.ID);
                        btnEdit.setText(data.TEXT);
                    }
                }
            }
        });
    }
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }
    //取消
    function onCancel(e) {
        CloseWindow("cancel");
    }

    //标准方法接口定义
    function SetData(data) {
        if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            //debugger;
            data = mini.clone(data);
            $.ajax({
                url: "AspxDate.aspx?method=SelectTable38Where&DWID=" + data.DWID,
                cache: false,
                success: function(text) {
                    //debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    btnEdit.setValue(o.FJDDM);
                    btnEdit.setText(o.FJDDMTEXT);

                }
            });
        }
        else {
            btnEdit.setValue(data.DWID);
            btnEdit.setText(data.MC);
            mini.get("xh").setValue(data.xh);
        }
    }
    function SaveData() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;

        var json = mini.encode([o]);
        $.ajax({
        url: "AspxDate.aspx?method=EmployeesTreeSaveA",
            data: { data: json },
            cache: false,
            success: function(text) {
                if (text == 1) {
                    CloseWindow("save");
                    
                }
                else {
                    mini.alert("保存失败!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    function Clert() {
        btnEdit.setValue('');
        btnEdit.setText('');
    }
</script>
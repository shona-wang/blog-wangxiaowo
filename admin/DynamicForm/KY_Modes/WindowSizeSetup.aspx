<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WindowSizeSetup.aspx.cs" Inherits="DynamicForm_KY_Modes_WindowSizeSetup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>窗口大小设置</title>
    <script src="../../scripts/boot.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1">
    <table>
       <tr>
         <td>名称:</td>
         <td>
          <input id="TEXT" name="TEXT" class="mini-textbox" required="true"/>
         </td>
       </tr>
       <tr>
         <td>宽度:</td>
         <td>
          <input id="WIDTH" name="WIDTH" class="mini-spinner" minvalue="20" maxvalue="2000" required="true" />
         </td>
       </tr>
       <tr>
         <td>高度:</td>
         <td>
            <input id="HEIGTH" name="HEIGTH" class="mini-spinner" minvalue="20" maxvalue="2000" required="true" />
         </td>
       </tr>
       <tr>
         <td colspan="2" style=" text-align:center;">
             <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="CloseWindow">关闭</a>
                <input id="JDDM" name="JDDM" class="mini-hidden" />  
                <input id="mytype" name="mytype" class="mini-hidden" value="Edit"/>  
         </td>
       </tr>
    </table>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    mini.parse();
    //标准方法接口定义
    function SetData(data) {
        mini.get("WIDTH").setValue(data.WIDTH);
        mini.get("HEIGTH").setValue(data.HEIGTH);
        mini.get("JDDM").setValue(data.JDDM);
        mini.get("TEXT").setValue(data.TEXT);
    }
    var form = new mini.Form("form1");
    //保存函数
    function SaveData() {
        //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "KY_ModesData.aspx?method=KY_ModesType_Insert",
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
    
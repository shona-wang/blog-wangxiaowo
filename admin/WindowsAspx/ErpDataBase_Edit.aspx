<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErpDataBase_Edit.aspx.cs" Inherits="WindowsAspx_ErpDataBase_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加表字段</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>
      <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height:100%;
        }
    </style>
</head>
<body>
     <form id="form1" method="post">
         <table style="width: 327px">
             <tr>
                <td style="text-align: right">字段类型:</td>
                <td>
                <input id="ZDLX" name="ZDLX" class="mini-combobox" required="true" onvaluechanged="valuechange"/>
                </td>
             </tr>
             <tr>
                <td style="text-align: right">字段名称:</td>
                <td> <input id="ZDMC" name="ZDMC" class="mini-textbox" required="true" onvaluechanged="JYCF()"/></td>
             </tr>
             
             <tr>
                <td style="text-align: right">字段长度:</td>
                <td>
                  <input id="ZDCD" name="ZDCD" class="mini-spinner"  minValue="1" maxValue="80000" />
                </td>
             </tr>
              <tr>
                <td style="text-align: right">小数位数:</td>
                <td>
                   <input id="XSWS" name="XSWS" class="mini-spinner"  minValue="0" maxValue="5" enabled="false"/>
                </td>
             </tr>
             <tr>
                <td colspan="2" style="text-align: center;">
                 <a class="mini-button" iconcls="icon-save" onclick="SaveData()">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="onCancel">关闭</a>
                </td>
             </tr>
         </table>
         <input id="BMC" name="BMC" class="mini-hidden" />
     </form>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var ZDDate = [{ id: 'varchar', text: 'Varchar' }, { id: 'char', text: 'Char' }, { id: 'text', text: 'Text' }, { id: 'image', text: 'Image' }, { id: 'int', text: 'Int' }, { id: 'decimal', text: 'Decimal' }, { id: 'numeric', text: 'Numeric' }, { id: 'datetime', text: 'Datetime'}];
    mini.get("ZDLX").setData(ZDDate);
    var form = new mini.Form("form1");
    var ZDMC = mini.getbyName("ZDMC");
    $(window).load(function() {
        var Request = new QueryString();
        var DataTableName = Request["DataTableName"];
        mini.get("BMC").setValue(DataTableName);
    });



    function SaveData() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        $.ajax({
        url: "AspxDate.aspx?method=ColmSave",
            data: { data: json },
            cache: false,
            success: function(text) {
                if (text == -1) {
                    mini.alert("保存成功,您可以继续添加!");
                    ZDMC.setValue("");
                    ZDMC.focus();
                }
                else {
                    mini.alert("保存失败!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                
            }
        });
    }
    function JYCF() {
        $.ajax({
        url: "AspxDate.aspx?method=DataComCount&DataTableName=" + mini.get("BMC").getValue() + "&&DataColmName=" + mini.get("ZDMC").getValue(),
            type: "post",
            success: function(text) {
                if (text > 0) {
                    mini.alert("字段名称重复,请重新输入!");
                    
                    ZDMC.setValue("");
                    ZDMC.focus();
                }
            }
        });
    }
    function valuechange(e) {
        var val = e.value;
        var ZDCD = mini.get("ZDCD");
        var XSWS = mini.get("XSWS");
        if (val == "varchar") {
            ZDCD.setValue(50);
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
        if (val == "char") {
            ZDCD.setValue(10);
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
        if (val == "text") {
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
        if (val == "image") {
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
        if (val == "int") {
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
        if (val == "decimal") {
            ZDCD.setValue(18);
            XSWS.setEnabled(true);
            XSWS.setValue(0);
        }
        if (val == "numeric") {
            ZDCD.setValue(18);
            XSWS.setEnabled(true);
            XSWS.setValue(0);
        }
        if (val == "datetime") {
            XSWS.setEnabled(false);
            XSWS.setValue(0);
        }
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
    </script>
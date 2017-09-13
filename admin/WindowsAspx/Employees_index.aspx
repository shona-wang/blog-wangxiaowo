<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employees_index.aspx.cs"
    Inherits="WindowsAspx_Employees_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script src="../scripts/boot.js" type="text/javascript"></script>
 <style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;
    } 
        </style>  
</head>
<body>
        <div class="mini-toolbar" style="border-bottom: 0; padding: 2px;">
            <%-- <a class="mini-button" iconcls="icon-add" onclick="addRow()" plain="true">增加</a>
                        <span class="separator"></span>--%><a class="mini-button" iconcls="icon-remove" onclick="removeRow()"
                            plain="true">删除</a> <span class="separator"></span><a class="mini-button" iconcls="icon-save"
                                onclick="saveData()" plain="true">保存</a> <span class="separator"></span>
                        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">关闭</a>
                        请注意:有子节点的节点不能直接删除!
        </div>
    <div id="datagrid1" class="mini-datagrid" style="width:100%; height:91%;" url="AspxDate.aspx?method=EmployeesGet"
        idfield="JDDM" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcelledit="true" allowcellselect="true"
        multiselect="true" allowAlternating="true" showColumnsMenu="true">
        <div property="columns">
            <div type="checkcolumn">
            </div>
            <div field="BMBM" vtype="required" requiredErrorText="单位编码不能为空" headeralign="center" allowsort="true">
                单位编码
                <input property="editor" class="mini-textbox" style="width: 100%;" />
            </div>
            <div field="BMMC" vtype="required" requiredErrorText="单位不能为空"  headeralign="center" allowsort="true">
                单位名称
                <input property="editor" class="mini-textbox" style="width: 100%;" />
            </div>
            <div field="DWID" headeralign="center" allowsort="true">
                单位ID
                <input class="mini-textbox" style="width: 100%;" />
            </div>
            <div field="JDDM" headeralign="center" allowsort="true">
                代码
                <input class="mini-textbox" style="width: 100%;" />
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        //加载绑定
        mini.parse();
        var grid = mini.get("datagrid1");
        grid.load();
        grid.hideColumn(4); //隐藏最后一列
        //grid.hideColumn();
        //操作
        function addRow() {
            var newRow = { JDDM: "" };
            newRow.DWBM = "";
            newRow.BMMC = "";
            newRow.DWID = "";
            var number = grid.getData().length;
            grid.addRow(newRow, number);
        }
        function removeRow() {
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
                grid.removeRows(rows, true);
            }
        }
        function saveData() {
            grid.validate();
            if (grid.isValid() == false) {
                var error = grid.getCellErrors()[0];
                grid.beginEditCell(error.record, error.column);
                return;
            }
            grid.cancelEdit();
            debugger;
            var data = grid.getChanges();
            var json = mini.encode(data);
            grid.loading("保存中，请稍后......");
            $.ajax({
                url: "AspxDate.aspx?method=EmployeesSave",
                data: { data: json },
                type: "post",
                success: function(text) {
                    var Mes = mini.decode(text);
                    if (Mes.messageid == "1") {
                        grid.reload();
                    } else {
                        mini.alert(Mes.messageContent);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }
        //关闭窗口
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>

</body>
</html>

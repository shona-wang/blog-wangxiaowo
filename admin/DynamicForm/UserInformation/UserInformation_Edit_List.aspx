<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserInformation_Edit_List.aspx.cs"
    Inherits="DynamicForm_UserInformation_UserInformation_Edit_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

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
        &nbsp;&nbsp;&nbsp; 行:<input id="rowscount" style="width: 40px;" class="mini-spinner"
            minvalue="1" maxvalue="20" />
        <span class="separator"></span><a class="mini-button" iconcls="icon-add" onclick="addrows"
            plain="true">增加明细</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                onclick="removerows" plain="true">删除明细</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-save" onclick="SaveData" plain="true">保存</a>
        <span class="separator"></span><a class="mini-button" iconcls="icon-close" onclick="CloseWindow"
            plain="true">关闭</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" idfield="DJKEY"
            allowresize="true" idfield="DJKEY" allowcelledit="true" editnextonenterkey="true"
            allowcellselect="true" multiselect="true" showpager="false" allowSortColumn="false">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <% =Html("UserInformation")%>
                <%--<div field="SFDY" width="120" headeralign="center" allowsort="true">
                    是否党员
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="YHM" width="120" headeralign="center" allowsort="true">
                    用户名
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="XX" width="120" headeralign="center" allowsort="true">
                    用户姓名
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="JG" width="120" headeralign="center" allowsort="true">
                    籍贯
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="NL" width="120" headeralign="center" allowsort="true">
                    年龄
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="SFZH" width="120" headeralign="center" allowsort="true">
                    身份证号
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="BYSJ" width="120" headeralign="center" allowsort="true">
                    毕业时间
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="ZW" width="120" headeralign="center" allowsort="true">
                    职位
                <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="XZZ" width="120" headeralign="center" allowsort="true">
                    现住址
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="JTZZ" width="120" headeralign="center" allowsort="true">
                    家庭住址
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>
                <div field="BZ" width="120" headeralign="center" allowsort="true">
                    备注
                    <input property="editor" class="mini-textbox" style="width: 100%;" />
                </div>--%>
            </div>
        </div>
    </div>
    <input id="FL" name="FL" class="mini-hidden" />
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    //标准方法接口定义
    function SetData(data) {
        if (data.action == "Add") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            mini.get("FL").setValue(data.FL);
        }

    }
    //保存函数
    function SaveData() {
        grid.clearSelect(false);
        var cnt_bc = grid.getData().length;
        if (cnt_bc < 1) {
            mini.alert("明细不能少于一条");
            return;
        }
        grid.commitEdit(); //提交所有行
        grid.validate();
        if (grid.isValid() == false) {
            var error = grid.getCellErrors()[0];
            grid.beginEditCell(error.record, error.column);
            return;
        }
        var data_ = grid.getData();
        var json_data = mini.encode(data_);
        $.ajax({
            url: "UserInformationData.aspx?method=UserInformation_ListInsert",
            data: { data: json_data, TableName: mini.get("FL").getValue() },
            type: "post",
            success: function(text) {
                if (text > 0) {
                    CloseWindow();
                } else {
                    mini.alert("提示:保存数据出现错误!");
                }
            }
        });
    }
    //增加明细行
    function addrows() {
        //判断行数是否为空
        var Hs_Count = mini.get("rowscount").getValue();
        if (Hs_Count == 0) {
            mini.alert("行数最少一条！")
        }
        else {
            //行数不为零  添加新行
            for (var i = 0, n = Hs_Count; i < n; i++) {
                var cnt = i;
                var newRow = {};
                var gridcount = grid.getData().length;
                grid.addRow(newRow, gridcount);
                grid.validateRow(newRow);   //加入新行
            }
        }
    }
    //移除行
    function removerows() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            grid.removeRows(rows, true);
        }
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


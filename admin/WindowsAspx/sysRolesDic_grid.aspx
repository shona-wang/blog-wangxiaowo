<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysRolesDic_grid.aspx.cs"
    Inherits="WindowsAspx_sysRolesDic_grid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>角色选择grid</title>

    <script src="../scripts/boot.js" type="text/javascript"></script>
 <style type="text/css">
    html,body
    {
        padding:0;
        margin:0;
        border:0;     
        width:100%;
        height:100%;
        overflow:hidden;   
    }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="text-align: center; line-height: 30px;" borderstyle="border:0;">
        <label>
            角色名称:</label>
        <input id="key" class="mini-textbox" style="width: 150px;" onenter="onKeyEnter" />
        <a class="mini-button" style="width: 60px;" onclick="search()">查询</a>
    </div>
    <div class="mini-fit">
        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" url="AspxDate.aspx?method=sysRolesDicindex"
            idfield="ROLEID" allowresize="true" sizeList=[50,100,300,500] pagesize="50" allowcellselect="true" multiselect="true">
            <div property="columns">
                <div type="checkcolumn">
                </div>
                <div field="ROLENAME" width="120" headeralign="center" allowsort="true">
                    角色名称
                </div>
                <div field="DEACRIPTION" width="120" headeralign="center" allowsort="true">
                    角色描述
                </div>
            </div>
        </div>
    </div>
    <div class="mini-toolbar" style="text-align: center; padding-top: 8px; padding-bottom: 8px;"
        borderstyle="border:0;">
        <a class="mini-button" style="width: 60px;" onclick="onOk()">确定</a> <span style="display: inline-block;
            width: 25px;"></span><a class="mini-button" style="width: 60px;" onclick="onCancel()">
                取消</a>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    //加载绑定
    mini.parse();
    var grid = mini.get("datagrid1");
    grid.load();
    function GetData() {
        var rows = grid.getSelecteds();
        var ids = [], texts = [];
        for (var i = 0, l = rows.length; i < l; i++) {
            var row = rows[i];
            ids.push(row.ROLEID);
            texts.push(row.ROLENAME);
        }
        var data = {};
        data.id = ids.join(",");
        data.text = texts.join(",");
        return data;
    }
    //查询
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function onOk() {
        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("cancel");
    }   
</script>


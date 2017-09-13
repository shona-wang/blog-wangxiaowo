<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysGroupPower_setup.aspx.cs" Inherits="WindowsAspx_sysGroupPower_setup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="../scripts/boot.js" type="text/javascript"></script>
      <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
     <style type="text/css">
    .function-item 
    {
        margin-left:5px;
        margin-right:5px;
    }
    .function-item input
    {
        vertical-align:bottom;
    }
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
   <div class="mini-toolbar" style="text-align:left;" borderstyle="border-left:0;border-top:0;border-right:0;">
        <a class="mini-button" iconCls="icon-save" onclick="SaveRoles()" plain="true">保存</a>
        <span class="separator"></span>
        <a class="mini-button" iconCls="icon-cancel" onclick="CloseWindow()" plain="true">关闭</a>
        <input id="RoleID" name="RoleID" class="mini-hidden"/>
    </div>
    <div class="mini-fit">
   <div id="treegrid1" class="mini-treegrid" style="width:100%;height:100%;"     
    treeColumn="powertext" idField="powerid" parentField="parentid" resultAsTree="false"  
    allowResize="true" expandOnLoad="true" showTreeIcon="true"
    allowSelect="false" allowCellSelect="false" enableHotTrack="false"
    ondrawcell="ondrawcell" showCheckBox="true"  checkRecursive="true" autoCheckParent="true" 
>
    <div property="columns">
        <div type="indexcolumn"></div>
        <div name="powertext" field="powertext" width="300px" >模块名称</div>
        <div name="target" field="target" width="50px" >类型</div>
        <div field="functions" width="100%">权限</div>
    </div>
</div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var treegrid = mini.get("treegrid1");
     $(window).load(function() {
     var Request = new QueryString();
     mini.get("RoleID").setValue(Request["RoleID"]);
     treegrid.load("AspxDate.aspx?method=sysGroupPowerGet&RoleID=" + mini.get("RoleID").getValue());
 })
 var showAllSelect = true;
    function ondrawcell(e) {
        //debugger;
        var tree = e.sender,
            rowindex = e.rowIndex, //当前行
            rowid = e.row._id; //当前行索引行id
        rowspowerid = e.row.powerid, //当前行id
            record = e.record,
            column = e.column,
            field = e.field,
            id = record[treegrid.getIdField()],
            funs = record.functions;

        function createCheckboxs(funs) {
            if (!funs) return "";
            var html = "";
            if (showAllSelect) {
                var value = record.checkAll !== false ? "全选" : "取消";

                var clickFn = 'checkAllFunc(\'' + id + '\', this)';
                html += '<input onclick="' + clickFn + '" type="button" value="' + value + '" style="border:solid 1px #aaa;"/>';
                //html+=' <a class="mini-button" onclick="' + clickFn + '" >'+value+'</a> ';
            }
            for (var i = 0, l = funs.length; i < l; i++) {
                var fn = funs[i];
                var clickFn = 'checkFunc(\'' + id + '\',\'' + fn.powerid + '\', this.checked,\'' + rowspowerid + '\')';
                var checked = fn.checked ? 'checked' : '';
                html += '<label class="function-item"><input id="' + rowid + '" onclick="' + clickFn + '" ' + checked + ' type="checkbox" name="'
                        + fn.powerid + '" hideFocus/>' + fn.powertext + '</label>';
            }
            return html;
        }

        if (field == 'functions') {
            e.cellHtml = createCheckboxs(funs);
        }
    }

    function SaveRoles() {
        var data = treegrid.getData();
        var json = mini.encode(data);
        $.ajax({
            url: "AspxDate.aspx?method=sysGroupPowerSave&RoleID=" + mini.get("RoleID").getValue(),
            data: { data: json },
            type: "post",
            success: function(text) {
                var o = mini.decode(text);
                mini.alert(o.messageContent);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }
    function checkFunc(id, action, checked, rowid) {
        //debugger;
        var record = treegrid.getRecord(id);
        if (!record) return;
        var funs = record.functions;
        if (!funs) return;
        function getAction(action) {
            for (var i = 0, l = funs.length; i < l; i++) {
                var o = funs[i];
                if (o.powerid == action) return o;
            }
        }
        var obj = getAction(action);
        if (!obj) return;
        obj.checked = checked;

        if (obj.checked) {
            var rows = treegrid.getRow(rowid);
            treegrid.checkNode(rows); ;
        }

    }
    function checkAllFunc(id, btn) {
        var record = treegrid.getRecord(id);
        if (!record) return;
        var funs = record.functions;
        if (!funs) return;
        var checked = record.checkAll !== false;
        for (var i = 0, l = funs.length; i < l; i++) {
            var o = funs[i];
            o.checked = checked;
        }
        record.checkAll = !checked;
        treegrid.updateRow(record);
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();

    }
</script>
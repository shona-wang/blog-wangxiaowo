<%@ Page Language="C#" AutoEventWireup="true" CodeFile="User_SysRolesPerson_setup.aspx.cs" Inherits="WindowsAspx_User_SysRolesPerson_setup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>单用户权限设置</title>
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
          <a class="mini-button" iconcls="icon-save" onclick="SysGroupPowerUserSave()"
                plain="true">保存</a> <span class="separator"></span>
            <%-- <a class="mini-button" iconcls="icon-save" onclick="onLoginClick()"
                plain="true">清除权限</a>     
              <span class="separator"></span>  --%>
                <a class="mini-button" iconcls="icon-close"
                    onclick="CloseWindow()" plain="true">关闭</a>
             <input id="Userid" name="Userid" class="mini-hidden"/>
        </div>
<table>
   <tr>
     <td>
     <fieldset id="Fieldset1" style="width:201px; height:550px;">
        <legend>用户拥有角色</legend>
  <ul id="tree1" class="mini-tree"   style="width: 200px; height:96%;"
         textField="ROLENAME" idField="ROLEID" parentField="FJD" resultAsTree="false"  
        allowSelect="false" enableHotTrack="false" expandOnLoad="true"
        showCheckBox="true" checkRecursive="false" autoCheckParent="true" checkedField="CHECKED">
        </ul>
</fieldset>
     </td>
     <td>
      <fieldset id="Fieldset2" style="width:710px; height:550px;">
        <legend>用户拥有菜单访问权限</legend>
      <div id="treegrid1" class="mini-treegrid" style="width:100%;height:96%;"     
    treeColumn="powertext" idField="powerid" parentField="parentid" resultAsTree="false"  
    allowResize="false" expandOnLoad="true" showTreeIcon="true"
    allowSelect="false" allowCellSelect="false" enableHotTrack="false"
    ondrawcell="ondrawcell" showCheckBox="true"  checkRecursive="true" autoCheckParent="true" 
>
    <div property="columns">
        <div type="indexcolumn"></div>
        <div name="powertext" field="powertext" width="200px" >模块名称</div>
        <div name="target" field="target" width="50px" >类型</div>
        <div field="functions" width="100%">权限</div>
    </div>
</div>
</fieldset>
     </td>
   </tr>
</table>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    var treegrid = mini.get("treegrid1");
    $(window).load(function() {
    var Request = new QueryString();
    mini.get("Userid").setValue(Request["Userid"]);
        treeload(mini.get("Userid").getValue());
        treegriedload(mini.get("Userid").getValue());
    })
    function treeload(LoginID) {
        tree.load("AspxDate.aspx?method=sysRolesDicAndsysEmpRolesUser&LoginID=" + LoginID);
        expandAll();
    }
    //展开所有节点
    function expandAll() {
        tree.expandAll();
    }
    function treegriedload(LoginID) {
        treegrid.load("AspxDate.aspx?method=sysGroupPowerUser&LoginID=" + LoginID);
    }
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

    function SysGroupPowerUserSave() {
        //debugger;
        if (mini.get("Userid").getValue() != "") {
            var data = treegrid.getData();
            var json = mini.encode(data);
            var treedata = tree.getValue(true);
            var treejson = mini.encode(treedata);
            $.ajax({
            url: "AspxDate.aspx?method=SysGroupPowerUserSave&Userid=" + mini.get("Userid").getValue(),
            data: { Roles: treedata, MenuJson: json },
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
        else {
            mini.alert("请您选择用户!");
        }
    }
</script>
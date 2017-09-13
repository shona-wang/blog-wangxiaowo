<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Menu_Edit.aspx.cs" Inherits="WindowsAspx_Menu_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>菜单维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        body
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
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <a id="add" class="mini-button" iconcls="icon-add" plain="true" onclick="addRow()"
            enabled="false">增加</a> <span class="separator"></span><a id="del" class="mini-button"
                iconcls="icon-remove" plain="true" onclick="removeRow()" enabled="false">删除</a>
        <span class="separator"></span><a id="save" class="mini-button" iconcls="icon-save"
            plain="true" onclick="saveData()" enabled="false">操作保存</a> <span class="separator">
        </span><a id="joinbutton" class="mini-button" iconcls="icon-save" plain="true" onclick="ButtonSetup()"
            enabled="false">关联按钮</a> <span class="separator"></span><a id="sy" class="mini-button"
                iconcls="icon-upload" onclick="moveUp" plain="true" enabled="false">上移</a>
        <span class="separator"></span><a id="xy" class="mini-button" iconcls="icon-download"
            onclick="moveDown" plain="true" enabled="false">下移</a> <span class="separator">
        </span><a id="px" class="mini-button" iconcls="icon-save" plain="true" onclick="SaveDataOrder()"
            enabled="false">排序保存</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a> <span class="separator"></span>
        请注意:有子节点的节点不能直接删除!
    </div>
    <div class="mini-splitter" style="width: 100%; height: 94%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()">
                    刷新</a> <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()">
                        展开</a> <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()">
                            折叠</a>
            </div>
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" iconfield="IMAGE" url="AspxDate.aspx?method=MenuLeftGet"
                    style="width: 100%; height: 100%" showtreeicon="true" textfield="POWERTEXT" idfield="POWERID"
                    parentfield="PARENTID" resultastree="false">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                    url="AspxDate.aspx?method=MenuRightGet" idfield="POWERID" allowresize="true"
                    sizeList=[50,100,300,500] pagesize="50" allowcelledit="true" allowcellselect="true" multiselect="true"
                    editnextonenterkey="true" allowcellvalid="true" allowalternating="true" showcolumnsmenu="true">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="POWERTEXT" width="100" vtype="required" requirederrortext="节点名称不能为空"
                            headeralign="center" allowsort="true">
                            节点名称
                            <input property="editor" class="mini-textbox" style="width: 100%;" required="true" />
                        </div>
                        <div field="PARENTID" name="PARENTID" width="100" headeralign="center" allowsort="true">
                            父节点编号
                            <input class="mini-textbox" style="width: 100%;" />
                        </div>
                        <div field="POWERIDTEXT" name="POWERIDTEXT" width="100" headeralign="center" allowsort="true">
                            父节点名称
                            <input property="editor" class="mini-buttonedit" onbuttonclick="onMenuEdit" style="width: 100%;"
                                allowinput="false" />
                        </div>
                        <div field="NAVIGATEURL" width="500" headeralign="center" allowsort="true">
                            菜单路径
                            <input property="editor" class="mini-textbox" style="width: 100%;" />
                        </div>
                        <div type="comboboxcolumn" autoshowpopup="TARGET" name="TARGET" field="TARGET" width="60"
                            allowsort="true" align="center" headeralign="center">
                            链接目标
                            <input property="editor" class="mini-combobox" style="width: 100%;" data="TargetDate" />
                        </div>
                        <div field="IMAGE" name="Image" width="60">
                            图标
                            <input property="editor" class="mini-buttonedit" onbuttonclick="onMButtonEdit" style="width: 100%;" allowinput="false"/>
                        </div>
                        <div type="comboboxcolumn" autoshowpopup="true" name="LML" field="LML" width="100"
                            allowsort="true" align="center" headeralign="center">
                            状态
                            <input property="editor" class="mini-combobox" style="width: 100%;" data="ThpeDate" />
                        </div>
                        <div type="comboboxcolumn" autoshowpopup="true" name="SFFZ" field="SFFZ" width="100"
                            allowsort="true" align="center" headeralign="center">
                            是/否复制
                            <input property="editor" class="mini-combobox" style="width: 100%;" data="SFFZDate" />
                        </div>
                        <div field="XH" width="50" headeralign="center" allowsort="true">
                            排序号
                        </div>
                        <div field="POWERID" width="120" headeralign="center" allowsort="true">
                            节点编号
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    var ThpeDate = [{ id: '1', text: '正在使用' }, { id: '0', text: '停用'}];
    var IconDate = [{ id: 'icon-addfolder', text: '根' }, { id: 'icon-edit', text: '叶'}];
    var TargetDate = [{ id: 'Iframe', text: 'Iframe' }, { id: 'Open', text: 'Open'}];
    var SFFZDate = [{ id: '否', text: '否' }, { id: '是', text: '是'}];

    mini.parse();

    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        var ButtonObject;
        var add = mini.get("add");
        var save = mini.get("save");
        var del = mini.get("del");
        var joinbutton = mini.get("joinbutton");
        var sy = mini.get("sy");
        var xy = mini.get("xy");
        var px = mini.get("px");
        $.ajax({
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {
                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (add.getText() == ButtonObject[i].POWERTEXT) {
                        add.setEnabled(zt);
                    }
                    if (save.getText() == ButtonObject[i].POWERTEXT) {
                        save.setEnabled(zt);
                    }
                    if (del.getText() == ButtonObject[i].POWERTEXT) {
                        del.setEnabled(zt);
                    }
                    if (joinbutton.getText() == ButtonObject[i].POWERTEXT) {
                        joinbutton.setEnabled(zt);
                    }
                    if (sy.getText() == ButtonObject[i].POWERTEXT) {
                        sy.setEnabled(zt);
                    }
                    if (xy.getText() == ButtonObject[i].POWERTEXT) {
                        xy.setEnabled(zt);
                    }
                    if (px.getText() == ButtonObject[i].POWERTEXT) {
                        px.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    var tree = mini.get("tree1");
    var grid = mini.get("grid1");
    grid.load({ dept_id: "0" });
    tree.expandLevel(0); //展开一级节点
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    tree.selectNode(node); //选中第一个根节点
    //grid.hideColumn(10);
    //        grid.on("load", function() {
    ////        grid.mergeColumns(["parentid", "poweridtext"]);
    //        });
    //grid.hideColumn(2);//隐藏最后一列
    tree.on("nodeselect", function(e) {
        grid.load({ dept_id: e.node.POWERID });
    });
    tree.expandLevel(1); //展开一级节点
    //////////////////////////////////////////////
    function addRow() {
        var node = tree.getSelectedNode();
        if (node) {
            var newRow = {}; //name: "New Row"
            //newRow.POWERID = "";
            newRow.POWERTEXT = "";
            newRow.NAVIGATEURL = "";
            newRow.PARENTID = node.POWERID;
            newRow.IMAGE = 'addfolder.gif';
            newRow.TARGET = 'Iframe';
            newRow.LML = '1';
            newRow.JDDM = "";
            var number = grid.getData().length;
            newRow.XH = number + 1;
            newRow.SFFZ = '否';
            grid.addRow(newRow, number);
        }
        else {
            var newRow = {}; //name: "New Row"
            //newRow.POWERID = "";
            newRow.POWERTEXT = "";
            newRow.NAVIGATEURL = "";
            newRow.PARENTID = '0';
            newRow.IMAGE = 'addfolder.gif';
            newRow.TARGET = 'Iframe';
            newRow.LML = '1';
            newRow.JDDM = "";
            var number = grid.getData().length;
            newRow.XH = number + 1;
            newRow.SFFZ = '否';
            grid.addRow(newRow, number);
        }
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
        var data = grid.getChanges();
        var json = mini.encode(data);
        grid.loading("保存中，请稍后......");
        $.ajax({
            url: "AspxDate.aspx?method=MenuSave",
            data: { data: json },
            type: "post",
            success: function(text) {
                grid.reload();
                tree.load("AspxDate.aspx?method=MenuLeftGet");
                tree.expandLevel(1);
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
    //选择
    function onMButtonEdit(e) {
        var btnEdit = this;
        mini.open({
            url: bootPATH + "../WindowsAspx/Icons_index.aspx",
            title: "图标选择",
            width: 300,
            height: 600,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //必须
                    if (data) {
                        btnEdit.setValue(data.icon);
                        btnEdit.setText(data.icon);
                    }
                }
            }
        });
    }
    var parentid = "";
    function onMenuEdit(e) {
        var btnEdit = this;
        mini.open({
            url: bootPATH + "../WindowsAspx/MenuTreeList.aspx",
            title: "父菜单选择",
            width: 300,
            height: 600,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);    //必须
                    if (data) {
                        var row = grid.getSelected();
                        grid.updateRow(row, { PARENTID: data.POWERID });
                        btnEdit.setText(data.TEXT);
                        btnEdit.setValue(data.TEXT);
                    }
                }
            }
        });
    }

    grid.on("drawcell", function(e) {
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
        if (column.field == "IMAGE") {
            e.cellHtml = "<img src='../scripts/miniui/themes/icons/" + value + "' />";
        }
        if (parentid != "") {
            if (column.field == "parentid") {
                e.cellHtml = parentid;
                record.parentid = parentid;
                parentid = "";
            }
        }
    });
    function ButtonSetup() {
        var node = tree.getSelectedNode();
        var parentid = node.POWERID;
        var powertext = node.POWERTEXT;
        mini.open({
            url: bootPATH + "../WindowsAspx/Menu_AndButtonSetup_index.aspx?parentid=" + parentid + "&&powertext=" + powertext,
            title: powertext + "-按钮设置",
            width: 700,
            height: 600
        });
    }
    function moveUp() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index - 1);
        }
    }
    function moveDown() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);

            grid.moveRow(row, index + 2);
        }
    }
    function SaveDataOrder() {
        var GridData = grid.getData();
        var GridJson = mini.encode(GridData);
        $.ajax({
        url: "AspxDate.aspx?method=UpDisplay_Zb_XuHao",
        data: { data: GridJson },
        type: "post",
            success: function(text) {
                if (text != -1) {
                    grid.reload();
                    tree.load("AspxDate.aspx?method=MenuLeftGet");
                    tree.expandLevel(1);
                }
                else {
                    mini.alert("数据操作出现问题!");
                }
            },
            error: function() {
            }
        });
    }

    function expandLevel() {
        tree.expandAll();
    }
    function collapseLevel() {
        tree.collapseLevel(1);
    }
    function treereload() {
        tree.load("AspxDate.aspx?method=MenuLeftGet");
    }
</script>


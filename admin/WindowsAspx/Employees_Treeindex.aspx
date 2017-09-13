<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employees_Treeindex.aspx.cs"
    Inherits="WindowsAspx_Employees_Treeindex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>部门维护</title>

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
    <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <a id="add" class="mini-button" iconcls="icon-add" plain="true" onclick="addRow()"
                        enabled="false">增加</a> <span class="separator"></span><a id="edit" class="mini-button"
                            iconcls="icon-edit" plain="true" onclick="edit()" enabled="false">编辑</a>
                    <span class="separator"></span><a id="del" class="mini-button" iconcls="icon-remove"
                        plain="true" onclick="removeRow()" enabled="false">删除</a> <span class="separator">
                    </span><a id="delg" class="mini-button" iconcls="icon-remove" plain="true" onclick="getGen()"
                        enabled="false">删除根节点</a> <span class="separator"></span><a id="sy" class="mini-button"
                            iconcls="icon-upload" onclick="moveUp" plain="true" enabled="false">上移</a>
                    <span class="separator"></span><a id="xy" class="mini-button" iconcls="icon-download"
                        onclick="moveDown" plain="true" enabled="false">下移</a> <span class="separator">
                    </span><a id="save" class="mini-button" iconcls="icon-save" plain="true" onclick="saveData()"
                        enabled="false">保存</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                            onclick="CloseWindow()" plain="true">关闭</a> <span class="separator"></span>
                    请注意:有子节点的节点不能直接删除!
                </td>
            </tr>
        </table>
    </div>
    <div class="mini-splitter" style="width: 100%; height: 93%;">
        <div size="200" showcollapsebutton="true">
         <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                     <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()" >刷新</a>
                     <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()" >展开</a>
                     <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()" >折叠</a>
             </div>
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" iconfield="IMAGE" url="AspxDate.aspx?method=EmpSelect"
                    style="width: 100%;" showtreeicon="true" textfield="TEXT" idfield="ID" parentfield="PID"
                    resultastree="false">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="grid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;"
                    url="AspxDate.aspx?method=getdepartment" showfilterrow="false" allowcellselect="true"
                    sizeList=[50,100,300,500] pagesize="50" allowcelledit="true" multiselect="true" allowalternating="true"
                    showcolumnsmenu="true">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="MC" width="120" headeralign="center" allowsort="true">
                            名称
                        </div>
                        <div field="BM" width="120" headeralign="center" allowsort="true">
                            编码
                        </div>
                        <div field="DH" width="120" headeralign="center" allowsort="true">
                            电话
                        </div>
                        <div field="LXR" width="120" headeralign="center" allowsort="true">
                            联系人
                        </div>
                        <div field="WZ" width="120" headeralign="center" allowsort="true">
                            位置
                        </div>
                        <div field="ZYYW" width="120" headeralign="center" allowsort="true">
                            邮编
                        </div>
                        <div field="DWID" width="120" headeralign="center" allowsort="true">
                            单位ID
                        </div>
                        <div field="DDM" width="120" headeralign="center" allowsort="true">
                            节点代码
                        </div>
                          <div field="JD" width="120" headeralign="center" allowsort="true">
                            经度
                        </div>
                        <div field="WD" width="120" headeralign="center" allowsort="true">
                            纬度
                        </div>
                       <div field="XH" width="120" headeralign="center" allowsort="true">
                            序号
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    $(window).load(function() {
        var Request = new QueryString();
        ButtonRoles(Request["MenuBh"]);
    })
    function ButtonRoles(MenuBh) {
        
        var ButtonObject;
        var add = mini.get("add");
        var edit = mini.get("edit");
        var del = mini.get("del");
        var delg = mini.get("delg");
        var save = mini.get("save");
        var sy = mini.get("sy");
        var xy = mini.get("xy");

        $.ajax({
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {
            //debugger;
                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (add.getText() == ButtonObject[i].POWERTEXT) {
                        add.setEnabled(zt);
                    }
                    if (edit.getText() == ButtonObject[i].POWERTEXT) {
                        edit.setEnabled(zt);
                    }
                    if (del.getText() == ButtonObject[i].POWERTEXT) {

                        del.setEnabled(zt);
                    }
                    if (delg.getText() == ButtonObject[i].POWERTEXT) {
                        delg.setEnabled(zt);
                    }
                    if (save.getText() == ButtonObject[i].POWERTEXT) {
                        save.setEnabled(zt);
                    }
                    if (sy.getText() == ButtonObject[i].POWERTEXT) {
                        sy.setEnabled(zt);
                    }
                    if (xy.getText() == ButtonObject[i].POWERTEXT) {
                        xy.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }

    var tree = mini.get("tree1");
    var grid = mini.get("grid1");
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    tree.selectNode(node); //选中第一个根节点
    //debugger;
    //var nodeid =node.id;
    grid.load({ dept_id: node.ID });
    grid.hideColumn(7);
    grid.hideColumn(8);
    tree.on("nodeselect", function(e) {
        grid.load({ dept_id: e.node.ID });
    });


    tree.expandLevel(0); //展开一级节点
    //////////////////////////////////////////////
    function addRow() {
        //        var number = grid.getData().length;
        //        var node = tree.getSelectedNode();
        //        if (node) {
        //            var newRow = {}; //name: "New Row"
        //            newRow.BM = "";
        //            newRow.BMMC = "";
        //            newRow.DWID = "";
        //            newRow.dept_id = node.id;
        //            grid.addRow(newRow, number);
        //        }
        //        else {
        //            var newRow = {}; //name: "New Row"
        //            newRow.BM = "";
        //            newRow.BMMC = "";
        //            newRow.DWID = "";
        //            newRow.dept_id = "01";

        //            grid.addRow(newRow, number);
        //        }
        var node = tree.getSelectedNode();
        var number = grid.getData().length+1;
        mini.open({
            url: "Employees_TreeEdit.aspx",
            title: "新增组织机构", width: 700, height: 250,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "Add", DWID: node.ID, MC: node.TEXT, xh: number };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
            grid.reload();
            tree.load();
            tree.expandLevel(0); //展开一级节点
            }
        });
       
    }
    //编辑
    function edit() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "Employees_TreeEdit.aspx",
                title: "编辑组织机构", width: 700, height: 250,
                onload: function() {
                    //debugger;
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DWID: row.DWID };
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                    grid.reload();
                },
                ondestroy: function(action) {
                    grid.reload();
                    tree.load();
                    tree.expandLevel(0); //展开一级节点
                }
            });

        } else {
            //debugger;
            var node = tree.getSelectedNode();
            mini.open({
                url: "Employees_TreeEdit.aspx",
                title: "编辑组织机构", width: 700, height: 250,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DWID: node.DWID };
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                    grid.reload();
                },
                ondestroy: function(action) {
                    grid.reload();
                    tree.load();
                    tree.expandLevel(0); //展开一级节点
                }
            });
        }
    }
    function removeRow() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.DWID);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=EmpDeletes&DWID=" + id,
                        success: function(text) {
                            if (text != -1) {
                                grid.reload();
                                //tree.url("AspxDate.aspx?method=EmpSelect");
                                tree.load(); 
                                tree.expandLevel(0); //展开一级节点
                            }
                            else {
                                mini.alert("删除数据出错!");
                            }
                        },
                        error: function() {
                        }
                    });

                }
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
    function saveData() {
        var GridData = grid.getData();
        var GridJson = mini.encode(GridData);
        grid.loading("保存中，请稍后......");
        $.ajax({
            url: "AspxDate.aspx?method=EmployeesTreeSave",
            data: { data: GridJson },
            type: "post",
            success: function(text) {
                if (text != -1) {
                    grid.reload();
                    
                }
                else {
                    mini.alert("数据操作出现问题!");
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
    function getGen() {
        //debugger;
        mini.open({
            url: "Employees_index.aspx",
            title: "操作组织机构", width: 700, height: 400,
            onload: function() {

            },
            ondestroy: function(action) {
                grid.reload();
            }
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


    function expandLevel() {
        tree.expandAll();
    }
    function collapseLevel() {
        tree.collapseLevel(1);
    }
    function treereload() {
        tree.load("AspxDate.aspx?method=EmpSelect");
    }
</script>


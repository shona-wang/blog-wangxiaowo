<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employees_Rolesindex.aspx.cs"
    Inherits="WindowsAspx_Employees_Rolesindex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>组织机构权限设置主页面</title>

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
        <a id="upqx" class="mini-button" iconcls="icon-add" plain="true" onclick="OpenRoles()"
            enabled="false">设置权限</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                onclick="CloseWindow()" plain="true">关闭</a>
    </div>
    <div class="mini-splitter" style="width: 100%; height: 92%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()">
                    刷新</a> <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()">
                        展开</a> <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()">
                            折叠</a>
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
                        <div field="JD" width="120" headeralign="center" allowsort="true">
                            经度
                        </div>
                        <div field="WD" width="120" headeralign="center" allowsort="true">
                            纬度
                        </div>
                        <div field="XH" width="120" headeralign="center" allowsort="true">
                            序号
                        </div>
                        <div field="JDDM" width="120" headeralign="center" allowsort="true">
                            节点代码
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
        var upqx = mini.get("upqx");
     
        $.ajax({
            url: "AspxDate.aspx?method=ButtonRoles&MenuBh=" + MenuBh,
            success: function(text) {

                ButtonObject = mini.decode(text);
                for (var i = 0; i < ButtonObject.length; i++) {
                    var zt = true;
                    if (ButtonObject[i].ZT == "flase") {
                        zt = false;
                    }
                    if (upqx.getText() == ButtonObject[i].POWERTEXT) {
                        upqx.setEnabled(zt);
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
    grid.load({ dept_id: node.ID });
    grid.hideColumn(7); //隐藏最后一列
    tree.on("nodeselect", function(e) {
        grid.load({ dept_id: e.node.ID });
    });
    tree.expandLevel(0); //展开一级节点
    //////////////////////////////////////////////
    function OpenRoles() {
        //
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "Employees_Rolesindex_setup.aspx?DWID=" + row.DWID,
                title: "设置-[" + row.MC + "]部门权限", width:1000, height: 600,
                onload: function() {

                },
                ondestroy: function(action) {
                    //grid.reload();
                }
            });

        } else {
        var node = tree.getSelectedNode();
        //debugger;
            mini.open({
            url: "Employees_Rolesindex_setup.aspx?DWID=" + node.DWID,
                title: "设置-[" + node.TEXT + "]部门权限", width: 1000, height: 600,
                onload: function() {

                },
                ondestroy: function(action) {
                    //grid.reload();
                }
            });
        }
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
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


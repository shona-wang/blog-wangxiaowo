<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_Modes_Index.aspx.cs" Inherits="DynamicForm_KY_Modes_KY_Modes_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
--%>
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
        <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">增加</a> <span
            class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()"
                plain="true">编辑</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                    onclick="dels()" plain="true">删除</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">刷新</a>
        <span class="separator"></span><a id="sy" class="mini-button" iconcls="icon-upload"
            onclick="moveUp" plain="true">上移</a> <span class="separator"></span><a id="xy" class="mini-button"
                iconcls="icon-download" onclick="moveDown" plain="true">下移</a> <span class="separator">
                </span><a id="px" class="mini-button" iconcls="icon-save" plain="true" onclick="SaveDataOrder()">
                    排序保存</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                        onclick="CloseWindow()" plain="true">关闭</a>
        <input id="Where" name="Where" class="mini-hidden" />
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
                <ul id="tree1" iconfield="IMAGE" class="mini-tree" url="KY_ModesData.aspx?method=KY_ModelTypeAll" style="width: 100%;"
                    showtreeicon="true" textfield="TEXT" idfield="JDDM" parentfield="FJDDM" resultastree="false" contextmenu="#treeMenu">
                </ul>
                 <ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpenTree">
                    <li name="OpenSel" iconcls="icon-move" onclick="onOpenSel">修改弹出大小</li>
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="KY_Modesdatagrid" class="mini-datagrid" style="height: 98%;" url="KY_ModesData.aspx?method=KY_Modes_PageJson_SelectWhere"
                    idfield="DJKEY" allowresize="true" sizeList=[50,100,300,500] pagesize="100" allowcellselect="true" multiselect="true">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="KJID" width="120" headeralign="center" allowsort="true">
                            控件ID
                        </div>
                        <div field="KJMS" width="120" headeralign="center" allowsort="true">
                            控件描述
                        </div>
                        <div field="KJLX" width="120" headeralign="center" allowsort="true" renderer="onColTypesRenderer">
                            控件类型
                        </div>
                        <div field="ZDCD" width="120" headeralign="center" allowsort="true">
                            最大长度
                        </div>
                        <div field="SFWK" width="120" headeralign="center" allowsort="true">
                            是否允许为空
                        </div>
                        <div field="KJGD" width="120" headeralign="center" allowsort="true">
                            控件高度
                        </div>
                        <div field="SFHB" width="120" headeralign="center" allowsort="true">
                            是否合并
                        </div>
                        <div field="XSSX" width="120" headeralign="center" allowsort="true">
                            显示顺序
                        </div>
                        <div field="SJY" width="120" headeralign="center" allowsort="true">
                            数据源
                        </div>
                        <div field="GLZDBM" width="120" headeralign="center" allowsort="true">
                            关联字典表名
                        </div>
                        <div field="SFXS" width="120" headeralign="center" allowsort="true">
                            是否不显示
                        </div>
                        <div field="SFJSHJ" width="120" headeralign="center" allowsort="true">
                            是否计算合计
                        </div>
                        <div field="JSGS" width="120" headeralign="center" allowsort="true">
                            计算公式
                        </div>
                        <div field="HZZD" width="120" headeralign="center" allowsort="true">
                            汇总字段
                        </div>
                        <div field="MRZ" width="120" headeralign="center" allowsort="true">
                            默认值
                        </div>
                        <div field="SFXY" width="120" headeralign="center" allowsort="true">
                            是否效验
                        </div>
                        <div field="XYFS" width="120" headeralign="center" allowsort="true">
                            效验公式
                        </div>
                        <div field="LBSFXS" width="120" headeralign="center" allowsort="true">
                            列表是否不显示
                        </div>
                        <div field="FL" width="120" headeralign="center" allowsort="true">
                            分类
                        </div>
                        <div field="LRSJ" width="120" headeralign="center" allowsort="true" dateformat="yyyy-MM-dd">
                            创建时间
                        </div>
                        <div field="LRRYXM" width="120" headeralign="center" allowsort="true">
                            创建人账号
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="JDDM" name="JDDM" class="mini-hidden" />
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var KY_Modesgrid = mini.get("KY_Modesdatagrid");
    KY_Modesgrid.load();
    var tree = mini.get("tree1");
    tree.expandLevel(0); //展开一级节点
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    tree.selectNode(node); //选中第一个根节点
    tree.on("nodeselect", function(e) {//点击节点事件
        mini.get("JDDM").setValue(e.node.JDDM);
        KY_Modesgrid.load({ JDDM: e.node.JDDM }); //按节点查询
    });
    //添加
    function add() {
        if (mini.get("JDDM").getValue() != "KY") {
            mini.open({
                url: "../DynamicForm/KY_Modes/KY_Modes_Edit.aspx", //此处注意修改
                title: "新增-属性", width: 550, height: 650,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Add", FL: mini.get("JDDM").getValue() };
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function(action) {
                    KY_Modesgrid.reload();
                }
            });
        }
    }
    //修改
    function edit() {
        var row = KY_Modesgrid.getSelected();
        if (row) {
            mini.open({
                url: "../DynamicForm/KY_Modes/KY_Modes_Edit.aspx",
                title: "修改-属性", width: 550, height: 650,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.DJKEY }; //此处需要手动调整，代码生成器不做太多判断了
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                },
                ondestroy: function(action) {
                    KY_Modesgrid.reload();
                }
            });
        } else {
            mini.alert("提示:请选中一条记录!");
        }
    }
    //删除
    function dels() {
        var rows = KY_Modesgrid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("如果删除字段,将连数据表的字段数据一起删除,确定要删除吗？", "确定？",
         function(action) {
             if (action == "ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJKEY); //此处需要手动调整
                 }
                 var id = ids.join(',');
                 KY_Modesgrid.loading("操作中，请稍后......");
                 $.ajax({
                     url: "KY_ModesData.aspx?method=KY_Modes_Deletes&&DJBH=" + id + "&&FL=" + mini.get("JDDM").getValue(), //此处需要手动调整
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("提示:删除错误!");
                         }
                         KY_Modesgrid.reload();
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
    //刷新
    function reload() {
        mini.get("Where").setValue('');
        KY_Modesgrid.load();
    }
    //打印
    function print() {
        mini.alert('未实现');
    }
    //高级查询
    function SeelctCx() {
        var columns = _getColumns();
        mini.open({
            url: "GaoJiChaXun.aspx?Cols=" + columns,
            title: "高级查询", width: 800, height: 300,
            ondestroy: function() {
                var iframe = this.getIFrameEl();
                Where = iframe.contentWindow.GetData(); //调用子页面的函数
                mini.get("Where").setValue(Where);
                grid.load({ Where: Where });
            }
        });
    }
    //高级查询调用函数
    function _getColumns() {
        var columns = KY_Modesgrid.getBottomColumns();
        function getColumns(columns) {
            columns = columns.clone();
            for (var i = columns.length - 1; i >= 0; i--) {
                var column = columns[i];
                if (!column.field) {
                    columns.removeAt(i);
                } else {
                    var c = { header: column.header, field: column.field };
                    columns[i] = c;
                }
            }
            return columns;
        }
        var columns = getColumns(columns);
        var json = mini.encode(columns);
        return json;
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
        tree.collapseLevel(0);
    }
    function treereload() {
        tree.reload();
    }
    var ColTypes = [
                   { id: '1', text: '单行文本框' },
                   { id: '2', text: '多行文本框' },
                   { id: '3', text: '下拉框' },
                   { id: '4', text: '日期框' },
                   { id: '5', text: '数字框' },
                   { id: '6', text: '单选按钮' },
                   { id: '7', text: '复选框' },
                   { id: '8', text: '复选框组' },
                   { id: '9', text: '弹出选择' },
                   { id: '10', text: '隐藏域' }
                   ];
    function onColTypesRenderer(e) {
        for (var i = 0, l = ColTypes.length; i < l; i++) {
            var g = ColTypes[i];
            if (g.id == e.value) return g.text;
        }
        return "";
    }
    function moveUp() {
        var row = KY_Modesgrid.getSelected();
        if (row) {
            var index = KY_Modesgrid.indexOf(row);
            KY_Modesgrid.moveRow(row, index - 1);
        }
    }
    function moveDown() {
        var row = KY_Modesgrid.getSelected();
        if (row) {
            var index = KY_Modesgrid.indexOf(row);

            KY_Modesgrid.moveRow(row, index + 2);
        }
    }
    function SaveDataOrder() {
        var GridData = KY_Modesgrid.getData();
        var GridJson = mini.encode(GridData);
        $.ajax({
            url: "KY_ModesData.aspx?method=UpModel_Zb_XuHao&data=" + GridJson,
            success: function(text) {
                if (text != -1) {
                    KY_Modesgrid.reload();
                }
                else {
                    mini.alert("数据操作出现问题!");
                }
            },
            error: function() {
            }
        });
    }
    //Tree右键菜单
    function onBeforeOpenTree(e) {
        //debugger;
        var menu = e.sender;
        //var tree = mini.get("tree1");

        var node = tree.getSelectedNode();
        if (!node) {
            e.cancel = true;
            return;
        }
        if (node.JDDM == "") {
            e.cancel = true;
            //阻止浏览器默认右键菜单
            e.htmlEvent.preventDefault();
            return;
        }

        ////////////////////////////////
        var removeItem = mini.getbyName("OpenSel", menu);
        removeItem.show();
        removeItem.enable();
    }
    function onOpenSel(e) {
//        debugger;
        var node = tree.getSelectedNode();
        mini.open({
        url: "../DynamicForm/KY_Modes/WindowSizeSetup.aspx?Cols=",
            title: node.TEXT+"-窗口大小设置", width: 240, height: 180,
            onload: function() {
            var data = { JDDM: node.JDDM, TEXT: node.TEXT,WIDTH: node.WIDTH, HEIGTH: node.HEIGTH };
                var iframe = this.getIFrameEl();
                iframe.contentWindow.SetData(data); //调用子页面的函数
                
               
            }
        });
    }
</script>


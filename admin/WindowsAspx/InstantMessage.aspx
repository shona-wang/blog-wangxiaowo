<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InstantMessage.aspx.cs" Inherits="WindowsAspx_InstantMessage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

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
    <div class="mini-splitter" style="width: 100%; height: 98%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()">
                    刷新</a> <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()">
                        展开</a> <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()">
                            折叠</a>
            </div>
            <div class="mini-fit">
                <ul id="tree1" class="mini-tree" iconfield="IMAGES" style="width: 100%; height: 100%"
                    showtreeicon="true" textfield="MC" idfield="JDDM" parentfield="FJDDM" resultastree="false"
                    onnodeselect="onNodeSelect" contextmenu="#treeMenu">
                </ul>
                <ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpenTree">
                    <li name="OpenSel" iconcls="icon-move" onclick="onOpenSel">历史记录</li>
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div showcollapsebutton="false" style="border: 0; width: 100%; height: 800px;">
                <!--Tabs-->
                <div id="mainTabs" class="mini-tabs" activeindex="0" style="width: 100%; height: 100%;"
                    contextmenu="#tabsMenu">
                </div>
                <ul id="tabsMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
                    <li onclick="closeTab">关闭标签页</li>
                    <li onclick="closeAllBut">关闭其他标签页</li>
                    <li onclick="closeAll">关闭所有标签页</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    $(window).load(function() {
        TreeLoad();
    })
    function TreeLoad() {
        tree.setUrl("AspxDate.aspx?method=SelectUserType");
        tree.expandLevel(0);
    }
    var tabs = mini.get("mainTabs");
    function showTab(node) {
        var id = "tab$" + node.JDDM;
        var tab = tabs.getTab(id);
        if (!tab) {
            tab = {};
            tab.name = id;
            tab.title = "与" + node.USERTEXT + "聊天中...";
            tab.showCloseButton = true;
            tab.iconCls = node.IMAGES;
            tab.url = "../InstantMessageHtml/InstantMessage.htm?Userid=" + node.JDDM + "&&username=" + node.USERTEXT; //+ node.URL;
            tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }
    function onNodeSelect(e) {
        var node = e.node;
        var isLeaf = e.isLeaf;

        if (isLeaf) {
            if (node.FL != "BM") {
                showTab(node);
            }
        }
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
        if (node.JDDM=="" && node.FL == "BM") {
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
        var node = tree.getSelectedNode();
        mini.alert("你好");
    }
    setInterval(treereload, 5000);
    function treereload() {
        tree.reload();
        tree.expandLevel(0);
    }
    function expandLevel() {
        tree.expandAll();
    }
    function collapseLevel() {
        tree.collapseLevel(1);
    }


    //右键关闭标签

    var currentTab = null;
    function onBeforeOpen(e) {
        var a = e.htmlEvent;
        currentTab = tabs.getTabByEvent(e.htmlEvent);
        if (!currentTab) {
            e.cancel = true;
        }
    }
    //关闭本选项卡
    function closeTab() {
        tabs.removeTab(currentTab);
    }
    //关闭其他选项卡
    function closeAllBut() {
        var but = [currentTab];
        but.push(tabs.getTab(0));
        tabs.removeAll(but);
    }
    //关闭所有选项卡
    function closeAll() {

        var but = [currentTab];
        but.push(tabs.getTab(0));
        tabs.removeAll(but);
    }
</script>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuindexBar.aspx.cs" Inherits="WindowsAspx_MenuindexBar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><% =WinTitleName() %></title>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .header
        {
            background: url(../header.gif) repeat-x 0 -1px;
            height: 80px;
        }
        .style1
        {
             width: 629px;
             padding-left:15px;
             height:20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td width="26%" style="text-align: left; ">
                        <img  width="594" height="80" alt=""  src="../Images/ej1.jpg"/><%--src="../Images/ej1.jpg" background: url(../Images/ejbj.jpg)--%>
                    </td>
                    <td width="74%" height="80" style="background: url(../Images/ejbj.jpg)"><%----%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="mini-button"  onclick="onSignout" plain="true">注销系统</a>
                    </td>
            </tr>
        </table>
    </div>
    <ul id="menu1" class="mini-menubar" style="width: 100%;" url="AspxDate.aspx?method=SelectDisplayZbsysEmpRoles"
        onitemclick="onItemClick" textfield="TEXT" idfield="POWERID" parentfield="PARENTID">
    </ul>
    <div class="mini-fit" style="padding-top: 5px;">
        <!--Tabs-->
        <div id="TABS" class="mini-tabs" activeindex="0" style="width: 100%; height: 100%;"
            contextmenu="#tabsMenu">
            <div title="首页" url="<%= HomeUrl() %>" iconCls="icon-home">
            </div>
        </div>
        <ul id="tabsMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
            <li onclick="closeTab">关闭标签页</li>
            <li onclick="closeAllBut">关闭其他标签页</li>
            <li onclick="closeAll">关闭所有标签页</li>
        </ul>
    </div>
    <div style="line-height: 20px; cursor: default">
    <table width="100%">
       <tr>
          <td class="style1"><span><img src="../Images/group.png"  alt=""/> 用户:<%=UserName()%>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/home.png" />部门:<%= EmployeesName()%></span> </td>
          <td>技术支持:<a href="<% = Website() %>" target="_blank"><% =TechnicalSupport()%></a>&nbsp;&nbsp;&nbsp;&nbsp;<% =ContactTelephone() %></td>
       </tr>
    </table>
    </div>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var tabs = mini.get("TABS");
    top["winMenu"] = window;
    function showTab(node) {
        //debugger;
        var id = "tab$" + node.id;
        var tab = tabs.getTab(id);
        if (!tab) {
            tab = {};
            tab.name = id;
            tab.title = node.TEXT;
            tab.showCloseButton = true;
            tab.iconCls = node.ICONCLS;
            //这里拼接了url，实际项目，应该从后台直接获得完整的url地址
            tab.url = "../" + node.URL;

            tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }
    function onItemClick(e) {
        //debugger;
        var item = e.item;
        var isLeaf = e.isLeaf;

        if (isLeaf) {
            showTab(item);
        }
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

    //这里是子页面打开调用的函数
    function AddshowTab(node) {
        //debugger;
        var id = "tab$" + node.powerid;
        var tab = tabs.getTab(id);
        if (!tab) {
            tab = {};
            tab.name = id;
            tab.title = node.TEXT;
            tab.showCloseButton = true;
            tab.iconCls = node.ICONCLS;
            tab.url = node.URL;
            tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }
    function onSignout(e) {
        mini.confirm("确定注销当前登录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    window.location = "Signout.aspx";
                }
            }
        );
    }
//    setInterval(ajaxInterval, 120000);//120000
//    function ajaxInterval() {
//        $.ajax({
//            url: "AspxDate.aspx?method=Js_Interval",
//            success: function(text) {
//              
//            },
//            error: function() {
//            }
//        });
    //    }
    setInterval(notify, 15000);
    var MesShow;
    function notify() {
        $.ajax({
            url: "AspxDate.aspx?method=MessageSelTiXing",
            success: function(text) {
                if (text != "") {
                    MessgetTiXing(text);
                }
                else {
                    if (MesShow != null && MesShow != "undefined") {
                        mini.hideMessageBox(MesShow);
                    }
                }
            },
            error: function() {
            }
        });

    }
    function MessgetTiXing(text) {
        //debugger;
        if (MesShow != null) {
            mini.hideMessageBox(MesShow);
        }
        MesShow = mini.showMessageBox({
            showModal: false,
            height: 150,
            width: 270,
            title: "提示信息",
            //iconCls: "mini-messagebox-tip",
            message: Messagetext(text),
            timeout: 8000,
            x: 'right',
            y: 'bottom'
        });
    }
    function Messagetext(text) {
        var Mes = '<div style="text-align:left; height:100%; width:100%; margin-top:1px;">';
        var txts = mini.decode(text);
        var tabid = getRandomColor();
        for (var i = 0; i < txts.length; i++) {
            tabid = tabid + i;
            Mes += '&nbsp;<img src="../scripts/miniui/themes/icons/tip.png" /><a href="#" onclick="TiXingBstAdd(\'' + txts[i].URL + '\',\'' + txts[i].XXLXMC + '\',\'' + tabid + '\',\'' + txts[i].XXLX + '\')">[' + txts[i].LRRYXM + ']给您发来[' + txts[i].XXLXMC + ']消息</a>&nbsp;<img src="../scripts/miniui/themes/icons/remove.gif" title="忽略提醒" style="text-decoration: none;" onclick="RomTiXing(\'' + txts[i].ID + '\')"/><br />'; //
        }
        Mes += '</div>';
        return Mes;
    }
    function TiXingBstAdd(Url, XXLXMC, _tabid, XXLX) {
        $.ajax({
            url: "AspxDate.aspx?method=MessageUpdateztYWLX&&XXLX=" + XXLX,
            success: function(text) {
                if (text != -1) {
                }
            },
            error: function() {
            }
        });
        var winMenu = top["winMenu"];
        var Dm_Url = Url;
        var tab = { PARENTID: _tabid, TEXT: XXLXMC, URL: Dm_Url, ICON: 'icon-folderopen' };  //首先模拟一个tab
        winMenu.AddshowTab(tab);
    }
    function RomTiXing(ID) {
        $.ajax({
            url: "AspxDate.aspx?method=MessageUpdatezt&&ID=" + ID,
            success: function(text) {
                if (text != -1) {
                    notify();
                }
            },
            error: function() {
            }
        });
    }
    function getRandomColor() {
        return "#" + ("00000" + ((Math.random() * 16777215 + 0.5) >> 0).toString(16)).slice(-6);
    }

    window.onbeforeunload = onbeforeunload_handler;
    function onbeforeunload_handler() {
        TuiChu();
    }
    function TuiChu() {
        $.ajax({
            url: "Signout_JavaScript.aspx",
            type: "post",
            async: false,
            success: function(text) {
            }
        });
    }
</script>


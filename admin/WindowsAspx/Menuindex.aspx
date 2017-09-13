<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Menuindex.aspx.cs" Inherits="WindowsAspx_Menuindex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>
        <% =WinTitleName() %></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <%-- <link type="text/css" href="../scripts/miniui/themes/default/miniui.css" />--%>
    <link type="text/css" href="../Css/blue/KaiYuan_Skin.css" />
    <style type="text/css">
        html, body
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
            background: url(../header.gif) repeat-x;
        }
        .Le
        {
            background: url(../header.gif) repeat-x;
        }
        .header div
        {
            font-family: 'Trebuchet MS' ,Arial,sans-serif;
            font-size: 25px;
            line-height: 60px;
            padding-left: 10px;
            font-weight: bold;
            color: #333;
        }
        body .header .topNav
        {
            position: absolute;
            right: 8px;
            top: 10px;
            font-size: 12px;
            line-height: 25px;
        }
        .header .topNav a
        {
            text-decoration: none;
            color: #222;
            font-weight: normal;
            font-size: 12px;
            line-height: 25px;
            margin-left: 3px;
            margin-right: 3px;
        }
        .header .topNav a:hover
        {
            text-decoration: underline;
            color: Blue;
        }
        .mini-layout-region-south img
        {
            vertical-align: top;
        }
        .style1
        {
            width: 629px;
            padding-left: 15px;
        }
    </style>
</head>
<body>
    <div class="mini-layout" style="width: 100%; height: 100%;">
        <div title="north" region="north" class="header" bodystyle="overflow:hidden;" height="80"
            showheader="false" allowresize="false" style="background: url(../Images/ejbj.jpg)">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="26%" style="text-align: left;">
                        <img width="311" height="80" alt="" src="../Images/ej1.jpg" /><%--src="../Images/ej1.jpg" background: url(../Images/ejbj.jpg)--%>
                    </td>
                    <td width="74%" height="80" style="background: url(../Images/ejbj.jpg)">
                        <%----%>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <div style="position: absolute; right: 14px; bottom: 11px; font-size: 12px; line-height: 25px;
                font-weight: normal; padding-left: 950px;">
                <%--<a class="mini-button  mini-button-iconTop"  onclick="onClick" tooltip="注销系统" plain="true">注销系统</a>--%>
                <a href="#"  onclick="PwdOpen()" title="修改用户密码">
                    <img border="0" src="../Images/btn_hd_support.gif" title="修改用户密码" alt="修改用户密码" /></a>&nbsp;&nbsp;
                <a href="OnlineHelp.htm" target="_blank"  title="在线帮助">
                    <img border="0" src="../Images/btn_hd_help.gif" title="在线帮助" alt="在线帮助" /></a>&nbsp;&nbsp;
                <a href="#" onclick="onSignout()" title="注销">
                    <img border="0" src="../Images/btn_hd_exit.gif" title="注销" alt="注销" /></a>
            </div>
        </div>
        <div title="south" region="south" showsplit="false" showheader="false" height="30">
            <div style="line-height: 20px; cursor: default">
                <table width="100%">
                    <tr>
                        <td class="style1">
                            <span>
                                <img src="../Images/group.png" alt="" />
                                用户:<%=UserName()%>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/home.png" alt="" />部门:<%= EmployeesName()%></span>&nbsp;&nbsp;&nbsp;&nbsp;
                                当前时间:<b id="date"></b>
                        </td>
                        <td>
                            技术支持:<a href="<% = Website() %>" target="_blank"><% =TechnicalSupport()%></a>&nbsp;&nbsp;&nbsp;&nbsp;<% =ContactTelephone() %>
                           <%-- <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=243578072&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:243578072:47" alt="有事Q我" title="有事Q我" /></a>--%>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div title="center" region="center" style="border: 0;" bodystyle="overflow:hidden;">
            <!--Splitter-->
            <div class="mini-splitter" style="width: 100%; height: 100%;" borderstyle="border:0;">
                <div size="180" maxsize="250" minsize="100" showcollapsebutton="true" style="border: 0;">
                    <!--OutlookTree-->
                    <div id="leftTree" class="mini-outlooktree" url="AspxDate.aspx?method=SelectDisplayZbsysEmpRoles"
                        onnodeselect="onNodeSelect" textfield="TEXT" idfield="POWERID" parentfield="PARENTID"
                        iconfield="IMAGE">
                    </div>
                </div>
                <div showcollapsebutton="false" style="border: 0;">
                    <!--Tabs-->
                    <div id="mainTabs" class="mini-tabs" activeindex="0" style="width: 100%; height: 100%;"
                        contextmenu="#tabsMenu">
                        <div title="首页" url="<%= HomeUrl() %>" iconcls="icon-home">
                        </div>
                    </div>
                    <ul id="tabsMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
                        <li onclick="closeTab">关闭标签页</li>
                        <li onclick="closeAllBut">关闭其他标签页</li>
                        <li onclick="closeAll">关闭所有标签页</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var tree = mini.get("leftTree");
    var tabs = mini.get("mainTabs");
    top["winMenu"] = window;
    function showTab(node) {
        //debugger;
        var id = "tab$" + node.POWERID;
        var tab = tabs.getTab(id);
        if (!tab) {
            tab = {};
            tab.name = id;
            tab.title = node.TEXT;
            tab.showCloseButton = true;
            tab.iconCls = node.IMAGE;
            tab.url = "../" + node.URL;
            tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }

    function onNodeSelect(e) {
        //debugger;
        var node = e.node;
        var isLeaf = e.isLeaf;

        if (isLeaf) {
            showTab(node);
        }
    }

    function onQuickClick(e) {
        tree.expandPath("datagrid");
        tree.selectNode("datagrid");
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
        //debugger;
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
        var id = "tab$" + node.PARENTID;
        var tab = tabs.getTab(id);
        if (!tab) {
            tab = {};
            tab.name = id;
            tab.title = node.TEXT;
            tab.showCloseButton = true;
            tab.iconCls = node.IMAGE;
            tab.url = node.URL;
            tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }
    function WincloseTab(node) {
        tabs.removeTab(node);
    }
    function onSignout() {
        mini.confirm("确定注销当前登录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    window.location = "Signout.aspx";
                }
            }
        );
    }
    function PwdOpen() {
        mini.open({
            url: "Pwd_Edit.aspx",
            title: "密码修改", width: 600, height: 300
        });
    }
        setInterval(ReadServerUserTrme,90000);
        function ReadServerUserTrme() {
            $.ajax({
                url: "AspxDate.aspx?method=UpdateSXSJ",
                success: function(text) {

                },
                error: function() {
                }
            });
        }
    setInterval(ReadDateTimeShow, 1000);//1秒
    function ReadDateTimeShow() {
        var year = new Date().getFullYear();
        var month = new Date().getMonth() + 1;
        var day = new Date().getDate();
        var time = new Date().toLocaleTimeString();
        var dayNames = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");  
        var getDay=new Date().getDay();
        var addDate = year + "年" + month + "月" + day + "日(" + dayNames[getDay] + ") " + time;
        $("#date").text(addDate)
    };
    setInterval(notify, 15000);//15秒
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
        //debugger;
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
        if (XXLX != "LT") {
            $.ajax({
                url: "AspxDate.aspx?method=MessageUpdateztYWLX&&XXLX=" + XXLX,
                success: function(text) {
                    if (text != -1) {
                    }
                },
                error: function() {
                }
            });
        }
        var winMenu = top["winMenu"];
        var Dm_Url =Url;
        var tab = { PARENTID: _tabid, TEXT: XXLXMC, URL: Dm_Url, ICON: 'icon-folderopen' };  //首先模拟一个tab
        winMenu.AddshowTab(tab);
    }
    function RomTiXing(ID) {
        //debugger;
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
    function TuiChu()
    {
        $.ajax({
        url: "Signout_JavaScript.aspx",
        type: "post",
        async:false,
            success: function(text) {
            }
        });
    }
</script>


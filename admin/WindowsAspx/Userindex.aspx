<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Userindex.aspx.cs" Inherits="WindowsAspx_Userindex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>账号维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

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
      <a id="ryadd" class="mini-button" iconcls="icon-add" onclick="add()" plain="true"
                        enabled="false">增加</a> <span class="separator"></span><a id="ryedit" class="mini-button"
                            iconcls="icon-edit" onclick="edit()" plain="true" enabled="false">编辑</a>
                    <span class="separator"></span><a id="rydel" class="mini-button" iconcls="icon-remove"
                        onclick="remove()" plain="true" enabled="false">删除</a> <span class="separator">
                    </span>
                    <a id="reload" class="mini-button" iconcls="icon-reload"
                        onclick="reload()" plain="true" enabled="false">刷新</a> <span class="separator">
                    </span>
                    <a id="uppwd" class="mini-button" iconcls="icon-unlock" onclick="CshMM" plain="true"
                        enabled="false">设置密码</a> <span class="separator"></span><a id="upemp" class="mini-button"
                            iconcls="icon-user" onclick="CshMM" plain="true" enabled="false">设置部门</a>
                    <span class="separator"></span><a id="uproles" class="mini-button" iconcls="icon-user"
                        onclick="sysrolessetup" plain="true" enabled="false">设置角色</a> <span class="separator">
                        </span>
                        <a id="Export" class="mini-button" plain="true" iconCls="icon-upload" onclick="ExportExcel()">导出</a>
                        <span class="separator">
                        </span>
                        <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()" plain="true">
                            关闭</a>
                          <input id="key" class="mini-textbox" emptytext="请输入姓名" style="width: 150px;" onenter="onKeyEnter" />
                    <a id="cx" class="mini-button" onclick="search()" plain="true" enabled="false">查询</a>   
    </div>
    <div class="mini-splitter" style="width: 100%; height:90%;">
        <div size="200" showcollapsebutton="true">
              <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                     <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()" >刷新</a>
                     <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()" >展开</a>
                     <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()" >折叠</a>
             </div>
            <div class="mini-fit">
                <ul id="tree1" iconfield="IMAGE" class="mini-tree" url="../WindowsAspx/AspxDate.aspx?method=EmpSelect"
                    style="width: 100%;" showtreeicon="true" textfield="TEXT" idfield="ID" parentfield="PID"
                    resultastree="false">
                </ul>
            </div>
        </div>
        <div showcollapsebutton="true">
            <div class="mini-fit">
                <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowresize="true"
                    url="../WindowsAspx/AspxDate.aspx?method=SearchEmployees" sizeList=[50,100,300,500] pagesize="50" idfield="YHM"
                    multiselect="true" allowalternating="true" showcolumnsmenu="true" showfilterrow="true" contextMenu="#gridMenu">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                         <div field="SRM" width="50" allowsort="true" headerAlign = "center">
                            序号</div>
                        <div field="YHM" width="100" allowsort="true" headerAlign = "center">
                            账号</div>
                            <div field="RELATEDYHM" width="100" allowsort="true" headerAlign = "center">
                            关联账号</div>
                        <div field="XX" width="120" allowsort="true" headerAlign = "center">
                            姓名
                            <input id="nameFilter" property="filter" class="mini-textbox" onvaluechanged="onNameFilterChanged"
                                style="width: 100%;" />
                        </div>
                         <div field="DELETEBS" width="50" allowsort="true" headerAlign = "center">
                            状态</div>
                        <div field="DWMC" width="120" allowsort="true" headerAlign = "center">
                            所属部门</div>
                        <div field="ZWMC" width="120" allowsort="true" headerAlign = "center">
                            职位</div>
                        <div field="ZW" width="120" allowsort="true" headerAlign = "center">
                            手机号</div>
                        <div field="MACID" width="120" allowsort="true" headerAlign = "center">
                            网卡号</div>
                       
                        <div field="SFBD" width="60" allowsort="true" headerAlign = "center">
                            绑定状态</div>
                        <div field="SF" width="60" allowsort="true" headerAlign = "center">
                            是否领导</div>
                        <div field="SF_1" width="60" allowsort="true" headerAlign = "center">
                            首要职位</div>
                        <div field="SF_2" width="70" allowsort="true" headerAlign = "center">
                            领导的主管</div>
                        <div field="SF_3" width="70" allowsort="true" headerAlign = "center">
                            员工的主管</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <ul id="gridMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">              
        <li name="sd" iconCls="icon-lock" onclick="zhcz('锁定')">锁定</li>
	    <li name="js" iconCls="icon-unlock" onclick="zhcz('解锁')">解锁</li>      
    </ul>
<input id="DWID" name="DWID" class="mini-hidden" />
   <iframe id="exportIFrame" style="display:none;"></iframe>
    
    <!--导出Excel相关HTML-->
     <form id="excelForm"  action="User_ExcelDate.aspx" method="post" target="excelIFrame">
        <input type="hidden" name="columns" id="excelData" />
    </form>
    <iframe id="excelIFrame" name="excelIFrame" style="display:none;"></iframe>
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
        var ryadd = mini.get("ryadd");
        var ryedit = mini.get("ryedit");
        var rydel = mini.get("rydel");
        var uppwd = mini.get("uppwd");
        var upemp = mini.get("upemp");
        var uproles = mini.get("uproles");
        var cx = mini.get("cx");
        var Export = mini.get("Export");
        var reload = mini.get("reload");
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
                    if (ryadd.getText() == ButtonObject[i].POWERTEXT) {
                        ryadd.setEnabled(zt);
                    }
                    if (ryedit.getText() == ButtonObject[i].POWERTEXT) {
                        ryedit.setEnabled(zt);
                    }
                    if (rydel.getText() == ButtonObject[i].POWERTEXT) {

                        rydel.setEnabled(zt);
                    }
                    if (uppwd.getText() == ButtonObject[i].POWERTEXT) {
                        var d = ButtonObject[i].zt;
                        uppwd.setEnabled(zt);
                    }
                    if (upemp.getText() == ButtonObject[i].POWERTEXT) {
                        upemp.setEnabled(zt);
                    }
                    if (uproles.getText() == ButtonObject[i].POWERTEXT) {
                        uproles.setEnabled(zt);
                    }
                    if (cx.getText() == ButtonObject[i].POWERTEXT) {
                        cx.setEnabled(zt);
                    }
                    if (Export.getText() == ButtonObject[i].POWERTEXT) {
                        Export.setEnabled(zt);
                    }
                    if (reload.getText() == ButtonObject[i].POWERTEXT) {
                        reload.setEnabled(zt);
                    }
                }
            },
            error: function() {
            }
        });
    }
    var grid = mini.get("datagrid1");
    grid.load();
    grid.sortBy("Srm", "asc");
    var tree = mini.get("tree1");
    tree.expandLevel(0); //展开一级节点
    var root = tree.getRootNode(); //获取所有根节点
    var nodes = tree.getChildNodes(root); //获取根节点集合
    var node = nodes[0]; //获取第一个根节点
    tree.selectNode(node); //选中第一个根节点
    tree.on("nodeselect", function(e) {//点击节点事件
    mini.get("DWID").setValue(e.node.ID);
        grid.load({ dept_id: e.node.ID }); //按节点查询
    });
    function search() {
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    function reload() {
        mini.get("key").setValue("");
        var key = mini.get("key").getValue();
        grid.load({ key: key });
    }
    function onKeyEnter(e) {
        search();
    }
    //删除
    function remove() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("确定删除选中记录吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.YHM);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "AspxDate.aspx?method=RemoveEmployees&id=" + id,
                        success: function(text) {
                            var o = mini.decode(text);
                            mini.alert(o.messageContent);
                            grid.reload();
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
    //设置密码
    function CshMM(e) {
        var rows = grid.getSelecteds();
        var _width, _height, _url, _tiele;
        if (e.source.text == "设置密码") {
            _tiele = "用户-设置密码";
            _width = 450;
            _height = 200;
            _url = "Pwd_Setup.aspx";
        }
        if (e.source.text == "设置部门") {
            _tiele = "用户-设置部门";
            _width = 450;
            _height = 150;
            _url = "user_Empsetup.aspx";
        }

        if (rows.length > 0) {
            var ids = [];
            var yhs = [];
            for (var i = 0, l = rows.length; i < l; i++) {
                var r = rows[i];
                ids.push(r.YHM);
                yhs.push(r.XX);
            }
            var id = ids.join(',');
            var yh = yhs.join(',');
            mini.open({
                url: _url + "?yhm=" + id + "&&xx=" + yhs,
                title: _tiele,
                width: _width,
                height: _height,
                ondestroy: function(action) {
                    grid.reload();
                }
            });
        } else {
            mini.alert("请选中一条记录");
        }
    }
    function sysrolessetup() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "sysRoles_setup.aspx?yhm=" + row.YHM + "&&xx=" + row.XX,
                title: '用户-角色设置',
                width: 650,
                height: 650,
                ondestroy: function(action) {
                    grid.reload();
                }
            });

        } else {
            mini.alert("请选中一条记录");
        }
    }
    //添加
    function add() {
        mini.open({
            url: "UserAddEdit.aspx",
            title: "新增账户", width: 600, height: 300,
            showMaxButton:true,
            onload: function() {
                var iframe = this.getIFrameEl();
                var data = { action: "new" };
                iframe.contentWindow.SetData(data);
            },
            ondestroy: function(action) {
                grid.reload();
            }
        });
    }

    //编辑
    function edit() {
        var row = grid.getSelected();
        if (row) {
            mini.open({
                url: "UserAddEdit.aspx",
                title: "编辑账户", width: 600, height: 300,
                showMaxButton: true,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "edit", yhm: row.YHM };
                    iframe.contentWindow.SetData(data); //调用子页面的函数
                },
                ondestroy: function(action) {
                    grid.reload();
                }
            });

        } else {
            mini.alert("请选中一条记录");
        }
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
    function csopen() {
        var row = grid.getSelected();
        if (row) {
            var data = { action: "edit", yhm: row.YHM };
            var tab = { powerid: 'AddEdit', text: '增加', Url: 'aaa.htm?datacation=' + row.yhm, icon: 'icon-edit' };  //首先模拟一个tab
            parent.AddshowTab(tab);

        } else {
            mini.alert("请选中一条记录");
        }
    }
    function onNameFilterChanged(e) {
        var textbox = e.sender;
        var key = textbox.getValue().toLowerCase();

        grid.filter(function(row) {
            var name = String(row.XX).toLowerCase();
            if (name.indexOf(key) != -1) return true;
            return false;
        });
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
    function ExportExcel() {
        var columns = grid.getBottomColumns();

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
        document.getElementById("excelData").value = json;
        var excelForm = document.getElementById("excelForm");
        excelForm.submit();
    }
    //右键菜单
    function onBeforeOpen(e) {
        var grid = mini.get("datagrid1");
        var menu = e.sender;
        var row = grid.getSelected();
        var editItem = mini.getbyName("sd", menu);
        var removeItem = mini.getbyName("js", menu);
        editItem.show();
        if (row.DELETEBS == "正常") {
            removeItem.disable();
            editItem.enable();
        }
        if (row.DELETEBS == "已锁定") {
            editItem.disable();
            removeItem.enable();
        }

    }
    function zhcz(zt) {
        var row = grid.getSelected();
        mini.confirm("确定" + zt + "选中用户吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    $.ajax({
                        url: "AspxDate.aspx?method=update_zt",
                        data: { yhm: row.YHM, zt: zt },
                        cache: false,
                        success: function(text) {
                            if (text > 0) {
                                grid.reload();
                                mini.alert("提示:设置成功!");
                            } else {
                                mini.alert("提示:设置失败!");
                            }

                        },
                        error: function() {
                        }
                    });

                }
            });
    }
</script>


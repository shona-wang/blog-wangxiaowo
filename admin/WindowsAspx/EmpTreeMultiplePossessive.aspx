﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmpTreeMultiplePossessive.aspx.cs" Inherits="WindowsAspx_EmpTreeMultiplePossessive" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门多选-所有组织机构</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        html, body
        {
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: visible;
        }
    </style>
</head>
<body>
     <div class="mini-toolbar" style="text-align: center; line-height: 30px;" borderstyle="border-left:0;border-top:0;border-right:0;">
        <label>
            名称：</label>
        <input id="key" class="mini-textbox" style="width: 150px;" onenter="onKeyEnter" />
        <a class="mini-button" style="width: 60px;" onclick="search()">查询</a>
    </div>
    <div class="mini-fit">
        <ul id="tree1"  class="mini-tree" style="width: 100%; height: 100%;" showtreeicon="true"
            textfield="text" idfield="id" parentfield="pid" resultastree="false" expandonload="true"
            showCheckBox="true">
    </ul>
    </div>
    <div class="mini-toolbar" style="text-align: center; padding-top: 8px; padding-bottom: 8px;"
        borderstyle="border-left:0;border-bottom:0;border-right:0;">
        <a class="mini-button" style="width: 60px;" onclick="onOk()">确定</a> <span style="display: inline-block;
            width: 25px;"></span><a class="mini-button" style="width: 60px;" onclick="onCancel()">
                取消</a>
    </div>
</body>
</html>
<script type="text/javascript">
    mini.parse();
    var tree = mini.get("tree1");
    tree.load("AspxDate.aspx?method=EmpSelectPossessive");
    function GetData() {
        var rows = tree.getCheckedNodes();
        var ids = [], texts = [];
        for (var i = 0, l = rows.length; i < l; i++) {
            var row = rows[i];
            ids.push(row.id);
            texts.push(row.text);
        }
        var data = {};
        data.jddm = ids.join(",");
        data.jdmc = texts.join(",");
        return data;
    }
    function _dwid(id) {
        var dwid = "";
        $.ajax({
            url: "AspxDate.aspx?method=get_table38&JDDM=" + id,
            type: "post",
            cache: false,
            success: function(text) {
                dwid = text;
            }
        });
        return dwid;
    }
    function search() {
        var key = mini.get("key").getValue();
        if (key == "") {
            tree.clearFilter();
        } else {
            key = key.toLowerCase();
            tree.filter(function(node) {
                var text = node.text ? node.text.toLowerCase() : "";
                if (text.indexOf(key) != -1) {
                    return true;
                }
            });
        }
    }
    function onKeyEnter(e) {
        search();
    }
    function onNodeDblClick(e) {
        onOk();
    }
    //////////////////////////////////
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();
    }

    function onOk() {
        var node = tree.getSelectedNode();
        if (node && tree.isLeaf(node) == false) {
            alert("不能选中父节点");
            return;
        }

        CloseWindow("ok");
    }
    function onCancel() {
        CloseWindow("cancel");
    }
</script>
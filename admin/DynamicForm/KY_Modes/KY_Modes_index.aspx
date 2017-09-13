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
        <a class="mini-button" iconcls="icon-add" onclick="add()" plain="true">����</a> <span
            class="separator"></span><a class="mini-button" iconcls="icon-edit" onclick="edit()"
                plain="true">�༭</a> <span class="separator"></span><a class="mini-button" iconcls="icon-remove"
                    onclick="dels()" plain="true">ɾ��</a> <span class="separator"></span>
        <a class="mini-button" iconcls="icon-reload" onclick="reload()" plain="true">ˢ��</a>
        <span class="separator"></span><a id="sy" class="mini-button" iconcls="icon-upload"
            onclick="moveUp" plain="true">����</a> <span class="separator"></span><a id="xy" class="mini-button"
                iconcls="icon-download" onclick="moveDown" plain="true">����</a> <span class="separator">
                </span><a id="px" class="mini-button" iconcls="icon-save" plain="true" onclick="SaveDataOrder()">
                    ���򱣴�</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                        onclick="CloseWindow()" plain="true">�ر�</a>
        <input id="Where" name="Where" class="mini-hidden" />
    </div>
    <div class="mini-splitter" style="width: 100%; height: 94%;">
        <div size="200" showcollapsebutton="true">
            <div class="mini-toolbar" style="padding: 2px; border-bottom: 0;">
                <a id="a1" class="mini-button" iconcls="icon-reload" plain="true" onclick="treereload()">
                    ˢ��</a> <a id="a2" class="mini-button" iconcls="icon-node" plain="true" onclick="expandLevel()">
                        չ��</a> <a id="a3" class="mini-button" iconcls="icon-folder" plain="true" onclick="collapseLevel()">
                            �۵�</a>
            </div>
            <div class="mini-fit">
                <ul id="tree1" iconfield="IMAGE" class="mini-tree" url="KY_ModesData.aspx?method=KY_ModelTypeAll" style="width: 100%;"
                    showtreeicon="true" textfield="TEXT" idfield="JDDM" parentfield="FJDDM" resultastree="false" contextmenu="#treeMenu">
                </ul>
                 <ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpenTree">
                    <li name="OpenSel" iconcls="icon-move" onclick="onOpenSel">�޸ĵ�����С</li>
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
                            �ؼ�ID
                        </div>
                        <div field="KJMS" width="120" headeralign="center" allowsort="true">
                            �ؼ�����
                        </div>
                        <div field="KJLX" width="120" headeralign="center" allowsort="true" renderer="onColTypesRenderer">
                            �ؼ�����
                        </div>
                        <div field="ZDCD" width="120" headeralign="center" allowsort="true">
                            ��󳤶�
                        </div>
                        <div field="SFWK" width="120" headeralign="center" allowsort="true">
                            �Ƿ�����Ϊ��
                        </div>
                        <div field="KJGD" width="120" headeralign="center" allowsort="true">
                            �ؼ��߶�
                        </div>
                        <div field="SFHB" width="120" headeralign="center" allowsort="true">
                            �Ƿ�ϲ�
                        </div>
                        <div field="XSSX" width="120" headeralign="center" allowsort="true">
                            ��ʾ˳��
                        </div>
                        <div field="SJY" width="120" headeralign="center" allowsort="true">
                            ����Դ
                        </div>
                        <div field="GLZDBM" width="120" headeralign="center" allowsort="true">
                            �����ֵ����
                        </div>
                        <div field="SFXS" width="120" headeralign="center" allowsort="true">
                            �Ƿ���ʾ
                        </div>
                        <div field="SFJSHJ" width="120" headeralign="center" allowsort="true">
                            �Ƿ����ϼ�
                        </div>
                        <div field="JSGS" width="120" headeralign="center" allowsort="true">
                            ���㹫ʽ
                        </div>
                        <div field="HZZD" width="120" headeralign="center" allowsort="true">
                            �����ֶ�
                        </div>
                        <div field="MRZ" width="120" headeralign="center" allowsort="true">
                            Ĭ��ֵ
                        </div>
                        <div field="SFXY" width="120" headeralign="center" allowsort="true">
                            �Ƿ�Ч��
                        </div>
                        <div field="XYFS" width="120" headeralign="center" allowsort="true">
                            Ч�鹫ʽ
                        </div>
                        <div field="LBSFXS" width="120" headeralign="center" allowsort="true">
                            �б��Ƿ���ʾ
                        </div>
                        <div field="FL" width="120" headeralign="center" allowsort="true">
                            ����
                        </div>
                        <div field="LRSJ" width="120" headeralign="center" allowsort="true" dateformat="yyyy-MM-dd">
                            ����ʱ��
                        </div>
                        <div field="LRRYXM" width="120" headeralign="center" allowsort="true">
                            �������˺�
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
    tree.expandLevel(0); //չ��һ���ڵ�
    var root = tree.getRootNode(); //��ȡ���и��ڵ�
    var nodes = tree.getChildNodes(root); //��ȡ���ڵ㼯��
    var node = nodes[0]; //��ȡ��һ�����ڵ�
    tree.selectNode(node); //ѡ�е�һ�����ڵ�
    tree.on("nodeselect", function(e) {//����ڵ��¼�
        mini.get("JDDM").setValue(e.node.JDDM);
        KY_Modesgrid.load({ JDDM: e.node.JDDM }); //���ڵ��ѯ
    });
    //���
    function add() {
        if (mini.get("JDDM").getValue() != "KY") {
            mini.open({
                url: "../DynamicForm/KY_Modes/KY_Modes_Edit.aspx", //�˴�ע���޸�
                title: "����-����", width: 550, height: 650,
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
    //�޸�
    function edit() {
        var row = KY_Modesgrid.getSelected();
        if (row) {
            mini.open({
                url: "../DynamicForm/KY_Modes/KY_Modes_Edit.aspx",
                title: "�޸�-����", width: 550, height: 650,
                onload: function() {
                    var iframe = this.getIFrameEl();
                    var data = { action: "Edit", DJBH: row.DJKEY }; //�˴���Ҫ�ֶ���������������������̫���ж���
                    iframe.contentWindow.SetData(data); //������ҳ��ĺ���
                },
                ondestroy: function(action) {
                    KY_Modesgrid.reload();
                }
            });
        } else {
            mini.alert("��ʾ:��ѡ��һ����¼!");
        }
    }
    //ɾ��
    function dels() {
        var rows = KY_Modesgrid.getSelecteds();
        if (rows.length > 0) {
            mini.confirm("���ɾ���ֶ�,�������ݱ���ֶ�����һ��ɾ��,ȷ��Ҫɾ����", "ȷ����",
         function(action) {
             if (action == "ok") {
                 var ids = [];
                 for (var i = 0, l = rows.length; i < l; i++) {
                     var r = rows[i];
                     ids.push(r.DJKEY); //�˴���Ҫ�ֶ�����
                 }
                 var id = ids.join(',');
                 KY_Modesgrid.loading("�����У����Ժ�......");
                 $.ajax({
                     url: "KY_ModesData.aspx?method=KY_Modes_Deletes&&DJBH=" + id + "&&FL=" + mini.get("JDDM").getValue(), //�˴���Ҫ�ֶ�����
                     success: function(text) {
                         if (text == -1) {
                             mini.alert("��ʾ:ɾ������!");
                         }
                         KY_Modesgrid.reload();
                     },
                     error: function() {
                     }
                 });
             }
         });
        } else {
            mini.alert("��ѡ��һ����¼");
        }
    }
    //ˢ��
    function reload() {
        mini.get("Where").setValue('');
        KY_Modesgrid.load();
    }
    //��ӡ
    function print() {
        mini.alert('δʵ��');
    }
    //�߼���ѯ
    function SeelctCx() {
        var columns = _getColumns();
        mini.open({
            url: "GaoJiChaXun.aspx?Cols=" + columns,
            title: "�߼���ѯ", width: 800, height: 300,
            ondestroy: function() {
                var iframe = this.getIFrameEl();
                Where = iframe.contentWindow.GetData(); //������ҳ��ĺ���
                mini.get("Where").setValue(Where);
                grid.load({ Where: Where });
            }
        });
    }
    //�߼���ѯ���ú���
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
    //�رմ���
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
                   { id: '1', text: '�����ı���' },
                   { id: '2', text: '�����ı���' },
                   { id: '3', text: '������' },
                   { id: '4', text: '���ڿ�' },
                   { id: '5', text: '���ֿ�' },
                   { id: '6', text: '��ѡ��ť' },
                   { id: '7', text: '��ѡ��' },
                   { id: '8', text: '��ѡ����' },
                   { id: '9', text: '����ѡ��' },
                   { id: '10', text: '������' }
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
                    mini.alert("���ݲ�����������!");
                }
            },
            error: function() {
            }
        });
    }
    //Tree�Ҽ��˵�
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
            //��ֹ�����Ĭ���Ҽ��˵�
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
            title: node.TEXT+"-���ڴ�С����", width: 240, height: 180,
            onload: function() {
            var data = { JDDM: node.JDDM, TEXT: node.TEXT,WIDTH: node.WIDTH, HEIGTH: node.HEIGTH };
                var iframe = this.getIFrameEl();
                iframe.contentWindow.SetData(data); //������ҳ��ĺ���
                
               
            }
        });
    }
</script>


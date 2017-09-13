<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_NRGL_CK.aspx.cs" Inherits="WZ_NRGL_WZ_NRGL_CK" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>预览</title>
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     <script src="../swfupload/swfupload.js" type="text/javascript"></script>
     <link rel="stylesheet" href="../../kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="../../kindeditor/plugins/code/prettify.css" />
	 <script charset="utf-8" src="../../kindeditor/kindeditor.js"></script>
	 <script charset="utf-8" src="../../kindeditor/lang/zh_CN.js"></script>
	 <script charset="utf-8" src="../../kindeditor/plugins/code/prettify.js"></script>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <style type="text/css">
        html, body
        {
            font-size: 12px;
            padding: 0;
            margin: 0;
            border: 0;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">       
     <fieldset style="width:800px;border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>基本信息</legend>
        <div id="editForm1" style="padding:5px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:120px;">主标题：</td>
                    <td style="width:260px;"><input id="XWBH" name="XWBH" class="mini-textbox" style="width:100%;" visible="false"><input id="XWZBT" name="XWZBT" class="mini-textbox" style="width:100%;" required="true" requiredErrorText="新闻主标题不能为空"></td>
                    <td style="width:120px;">所属栏目名称：</td>
                    <td style="width:260px;"><input id="LMBH" name="LMBH" class="mini-textbox" style="width:100%;" visible="false"><input id="LMMC" name="LMMC" class="mini-textbox" style="width:100%;" readonly="readonly"/></td>
                </tr>
                <tr>
                    <td>发布者：</td>
                    <td><input id="XWFBZ" name="XWFBZ" class="mini-textbox" style="width:100%;" readonly="readonly" /></td>
                    <td>是否图片新闻：</td>
                    <td>
                   <div id="SFTP" name="SFTP" class="mini-checkbox" checked="false" readOnly="false" text="图片新闻"></div>
                    
                    </td>
                </tr>
                <tr>
                    <td>发布时间：</td>
                    <td> <input id="FBSJ" name="FBSJ" class="mini-datepicker" style="width:100%;" format="yyyy-MM-dd" showOkButton="false" showClearButton="false"/></td>
                    <td>有效天数：</td>
                    <td><input id="SXTS" name="SXTS" class="mini-textbox" style="width:100%;" vtype="int" /></td>
                </tr>
                <tr align="center">
                    <td>
                       <input id="SSZT" name="SSZT" class="mini-textbox" style="width:100%;" emptyText="请选择专题"  visible ="false"  />
                    </td>
                    <td><div id="SFGG" name="SFGG" class="mini-checkbox" checked="false" readOnly="false" text="公告"  visible ="false" ></div></td>
                    <td><div id="SFTZ" name="SFTZ" class="mini-checkbox" checked="false" readOnly="false" text="通知" visible ="false" ></div></td>
                    <td><div id="SFRD" name="SFRD" class="mini-checkbox" checked="false" readOnly="false" text="热点" visible ="false" ></div></td>
                </tr>
            </table>
            <br />
            <textarea id="content1" cols="100" rows="8" style="width:793px;height:300px;visibility:hidden;" class="mini-textarea"></textarea>
        </div>
    </fieldset>
    <input type="hidden" name="_state" id="_state" /> 
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    $(window).load(function() {
    });
    //////////////////////////////////////////////////////
    var editor1;
    KindEditor.ready(function(K) {
        editor1 = K.create('#content1', {
            readonlyMode: true,
            cssPath: '../kindeditor/plugins/code/prettify.css',
            uploadJson: '../kindeditor/upload_json.ashx',
            fileManagerJson: '../kindeditor/file_manager_json.ashx',
            allowFileManager: true,
            afterCreate: function() {
                var self = this;
                K.ctrl(document, 13, function() {
                    self.sync();
                    K('form[name=form1]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function() {
                    self.sync();
                    K('form[name=form1]')[0].submit();
                });
            }
        });
        prettyPrint();
    });

    //标准方法接口定义
    function SetData(data) {
        debugger;
        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenDocInfo&XWBH=" + data.XWBH + "",
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.get("XWBH").setValue(o.XWBH);
                    mini.get("XWZBT").setValue(o.XWZBT);
                    mini.get("LMBH").setValue(o.LMBH);
                    mini.get("LMMC").setValue(o.LMMC);
                    mini.get("LMBH").setValue(o.LMBH);
                    mini.get("XWFBZ").setValue(o.XWFBZ);
                    mini.get("SSZT").setValue(o.SSZT);
                    mini.get("FBSJ").setValue(o.FBSJ);
                    mini.get("SXTS").setValue(o.SXTS);
                    if (o.SFTP == 1) {
                        mini.get("SFTP").setChecked(true);
                    }
                    if (o.SFGG == 1) {
                        mini.get("SFGG").setChecked(true);
                    }
                    if (o.SFTZ == 1) {
                        mini.get("SFTZ").setChecked(true);
                    }
                    if (o.SFRD == 1) {
                        mini.get("SFRD").setChecked(true);
                    }
                    editor1.html(o.XWNR);
                }
            });
        }
    }

    function GetData() {
        var o = form.getData();
        return o;
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }

    //关闭
    function onCloseClick(e) {
        var lookup2 = mini.get("lookup2");
        lookup2.hidePopup();
    }
</script>

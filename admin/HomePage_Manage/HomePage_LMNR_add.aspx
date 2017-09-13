<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomePage_LMNR_add.aspx.cs" Inherits="HomePage_Manage_HomePage_LMNR_add" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>栏目内容维护</title>
    <script type="text/javascript" src="../scripts/boot.js"></script>

    <script src="../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <script src="../swfupload/swfupload.js" type="text/javascript"></script>

    <link rel="stylesheet" href="../kindeditor/themes/default/default.css" />

    <script charset="utf-8" src="../kindeditor/kindeditor-min.js" type="text/javascript"></script>

    <script charset="utf-8" src="../kindeditor/lang/zh_CN.js" type="text/javascript"></script>

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
        textarea
        {
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">
    <input id="mytype" name="mytype" class="mini-hidden" />
    <input id="NRBH" name="NRBH" class="mini-hidden" />
    <input id="LMBH" name="LMBH" class="mini-hidden" />
    <input id="WJM" name="WJM" class="mini-hidden" />
    <input id="YWJM" name="YWJM" class="mini-hidden" />
    <fieldset>
        <legend>标题信息</legend>
        <table>
            <tr>
                <td>
                    主标题：
                </td>
                <td colspan="3">
                    <input id="NRZBT" name="NRZBT" class="mini-textbox" required="true" 
                        style="width: 419px;" />
                </td>
            </tr>
            <tr>
                <td>
                    副标题：
                </td>
                <td colspan="3">
                    <input id="NRFBT" name="NRFBT" class="mini-textbox" style="width: 419px;" />
                </td>
            </tr>
            <tr>
                <td>
                    是否发布：
                </td>
                <td>
                    <input id="FBBS" name="FBBS" class="mini-combobox" textfield="text" valuefield="id"
                        data = "renderFBBS" />
                </td>
                <td>
                    上传图片：
                </td>
                <td>
                    <input id="fileupload1" class="mini-fileupload" name="Fdata" limittype="*.jpg" flashurl="../swfupload/swfupload.swf"
                        uploadurl="../HomePage_Manage/Pic_Upload_data.aspx" onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError"
                        onfileselect="onFileSelect" />
                    <a id="SC" class="mini-button" onclick="startUpload()">上传</a>
                </td>
            </tr>
        </table>
    </fieldset>
    </form>
    <div>
        <textarea id="content1" name="content1" cols="100" rows="8" style="width: 800px;
            height: 400px; visibility: hidden;"></textarea>
    </div>
    <div style="text-align: center; padding: 10px;">
        <a id = "OK" class="mini-button" iconcls="icon-save" onclick="onOk">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="onCancel">取消</a>

    </div>
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
            },
            afterUpload: function(data) { //图片文件上传成功后返回图片路径
                //alert(data);
                debugger;
                //document.getElementById("_path").value = data;//document.getElementById("_path").value + "," + 
                //mini.get("_path").setValue(data);
            }
        });
        //prettyPrint();
    });

    var combobox_FBBS = mini.get("FBBS");
    var renderFBBS = [{ id: 1, text: '是' }, { id: 0, text: '否'}];
    combobox_FBBS.setData(renderFBBS);


    function SetData(data) {
        var data = mini.clone(data);
        if (data.action == "add") {
            mini.get("LMBH").setValue(data.LMBH);
            mini.get("mytype").setValue("Add");
            //var SFTP = mini.get("SFTP").setValue("是");
            mini.get("FBBS").setValue(1);
        }
        if (data.action == "edit") {
            $.ajax({
                url: "HomePage_Manage_data.aspx?method=SearchLMNR&NRBH=" + data.NRBH,
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    editor1.html(o.XXNR);
                    mini.get("fileupload1").setText(o.YWJM);
                    // var SFTP = mini.get("SFTP").setValue("是");
                }
            });
        }
    }

    function onFileSelect(e) {
        //alert("选择文件");
    }

    //上传失败后
    function onUploadError(e) {
        mini.alert("上传失败！");
    }


    //开始上传
    function startUpload() {
        var fileupload = mini.get("fileupload1");
        fileupload.startUpload();
    }
    
    //上传成功后
    function onUploadSuccess(e) {
        mini.get("WJM").setValue(e.serverData);
        var k = mini.get("fileupload1").getText();
        mini.get("YWJM").setValue(k);
        mini.alert("上传成功！");
    }


    function onOk() {
        mini.get("OK").setEnabled(false);
        form.validate();
        if (form.isValid() == false) {
            mini.get("OK").setEnabled(true);
            return;
        }
        debugger;
        var XXNR = editor1.html();
        var data = form.getData();
        var json = mini.encode([data]);
        $.ajax({
        url: "../HomePage_Manage/HomePage_Manage_data.aspx?method=InsertLMNR",
            data: { data: json, XXNR: XXNR },
            type: 'post',
            cache: false,
            success: function(text) {
                if (text != "-1") {
                    mini.alert("保存成功！", "提示",
                    function(action) {
                        debugger;
                        if (action == "ok") {
                            CloseWindow("ok");
                        }
                    });
                }
            }
        });
    }


    function onCancel(action) {
        CloseWindow("cancel");
    }


    //关闭函数
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }



</script>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-column_content.aspx.cs" Inherits="cms_column_add_column_content" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>栏目内容维护</title>
    <script type="text/javascript" src="../../scripts/boot.js"></script>

    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <script src="../../swfupload/swfupload.js" type="text/javascript"></script>

    <link rel="stylesheet" href="../../kindeditor/themes/default/default.css" />

    <script charset="utf-8" src="../../kindeditor/kindeditor-min.js" type="text/javascript"></script>

    <script charset="utf-8" src="../../kindeditor/lang/zh_CN.js" type="text/javascript"></script>
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
    <input id="id" name="id" class="mini-hidden" />
    <input id="columnid" name="columnid" class="mini-hidden" />
    <input id="path" name="path" class="mini-hidden"/>
    <fieldset>
        <legend>标题信息</legend>
        <table>
            <tr>
                <td>
                    主标题：
                </td>
                <td colspan="3">
                    <input id="title" name="title" class="mini-textbox" required="true" 
                        style="width: 419px;" />
                </td>
            </tr>
            <tr>
                <td>
                    副标题：
                </td>
                <td colspan="3">
                    <input id="name" name="name" class="mini-textbox" style="width: 419px;" />
                </td>
            </tr>
            <tr>
                <td>
                    是否发布：
                </td>
                <td>
                   <select name="status" class="mini-combobox" value="0">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </td>
                <td>
                    上传图片：
                </td>
                <td>
                    <input id="fileupload1" class="mini-fileupload" name="Fdata" limittype="*.jpg" flashurl="../../swfupload/swfupload.swf"
                        uploadurl="../service/upload.aspx" onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError"
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
            cssPath: '../../kindeditor/plugins/code/prettify.css',
            uploadJson: '../../kindeditor/upload_json.ashx',
            fileManagerJson: '../../kindeditor/file_manager_json.ashx',
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
                //document.getElementById("_path").value = data;//document.getElementById("_path").value + "," + 
                //mini.get("_path").setValue(data);
            }
        });
        //prettyPrint();
    });


    function SetData(data) {
        var data = mini.clone(data);
        if (data.action == "add") {
            mini.get("columnid").setValue(data.columnid);
        }
        if (data.action == "edit") {
            $.ajax({
                url: "../service/column_content.aspx?method=query&id=" + data.id,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o[0]);
                    editor1.html(o[0].wrap);
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
        mini.get("path").setValue(e.serverData);
        mini.alert("上传成功！");
    }


    function onOk() {
        mini.get("OK").setEnabled(false);
        form.validate();
        if (form.isValid() == false) {
            mini.get("OK").setEnabled(true);
            return;
        }
        var wrap = editor1.html();
        var data = form.getData();
        if (wrap) data.wrap = wrap;
        if (data["id"] == "") {
            delete data.id;
        }
        var json = mini.encode([data]);
        $.ajax({
            url: "../service/column_content.aspx?method=insert",
            data: {
                "data":json
            },
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
            },
            error: function (err) {
                console.log(err);
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

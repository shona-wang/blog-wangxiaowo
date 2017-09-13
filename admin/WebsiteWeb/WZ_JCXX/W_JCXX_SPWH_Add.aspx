<%@ Page Language="C#" AutoEventWireup="true" CodeFile="W_JCXX_SPWH_Add.aspx.cs"
    Inherits="WZ_JCXX_W_JCXX_SPWH_Add" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>视频维护</title>

    <script type="text/javascript" src="../../scripts/boot.js"></script>

    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <script src="../../swfupload/swfupload.js" type="text/javascript"></script>

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
        #fileupload1
        {
            width: 302px;
        }
        #fileupload2
        {
            width: 302px;
        }
        .style1
        {
            width: 163px;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">
    <table style="width: 100%;">
        <tr>
            <td style="width: 80px;">
                视频名称：
            </td>
            <td class="style1">
                <input id="FilmName" name="FilmName" class="mini-textbox" style="width: 200px" required="true"
                    requirederrortext="视频名称不能为空" />
            </td>
            <td style="width: 80px;">
                所属栏目：
            </td>
            <td style="width: 300px;">
                <input id="LMBH" class="mini-combobox" style="width: 200px" textfield="LMMC" valuefield="LMBH"
                    url="../WZ_DealData/DataProcess.aspx?method=SPSSLM" value="" shownullitem="true"
                    allowinput="true" required="true" requirederrortext="所属栏目不能为空" />
            </td>
        </tr>
        <tr>
            <td style="width: 80px;">
                视频类型：
            </td>
            <td class="style1">
                <input id="TypeID" class="mini-combobox" style="width: 200px" textfield="TypeName"
                    valuefield="TypeID" url="../WZ_DealData/DataProcess.aspx?method=SPSSLX" value=""
                    shownullitem="true" allowinput="true" required="true" requirederrortext="视频类型不能为空" />
            </td>
            <td style="width: 80px;">
                发布时间：
            </td>
            <td style="width: 300px;">
                <input id="CreateDate" name="CreateDate" class="mini-datepicker" value="" dateformat="yyyy-MM-dd"
                    style="width: 200px" required="true" requirederrortext="发布日期不能为空" />
            </td>
        </tr>
        <tr>
            <td>
                视频地址
            </td>
            <td class="style1" colspan="3">
                <input id="fileupload1" class="mini-fileupload" name="Fdata" limittype="*.mp4;*.flv;*.f4v"
                    style="width: 240px" flashurl="../../swfupload/swfupload.swf" uploadurl="upload.aspx"
                    onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError" onfileselect="onFileSelect"
                    showuploadprogress="true" onuploadcomplete="uploadcomplete" onuploadprogress="uploadProgress" />
                <div id="htmlContent" style="padding-left: 10px; display: none;">
                    <span id="span1"></span>
                    <br />
                    <img id="img1" width="1px" height="20px" alt="" src="#" />
                </div>
                <a id="SCSP" class="mini-button" iconcls="icon-upload" onclick="startUpload()">上传</a> <span
                    style="color: Red; font-weight: bold;">说明：上传.mp4/.flv/.f4v </span>
            </td>
        </tr>
        <tr>
            <td>
                视频图片
            </td>
            <td class="style1" colspan="3">
                <input id="fileupload2" class="mini-fileupload" name="Fdata1" limittype="*.jpg" style="width: 240px"
                    flashurl="../../swfupload/swfupload.swf" uploadurl="upload1.aspx" onuploadsuccess="onUploadSuccess2"
                    onuploaderror="onUploadError2" onfileselect="onFileSelect2" showuploadprogress="true"
                    onuploadcomplete="uploadcomplete" onuploadprogress="uploadProgress" />
                <%--  <input type="button" value="上传" onclick="startUpload2()"/>--%>
                <div id="htmlContent2" style="padding-left: 10px; display: none;">
                    <span id="span2"></span>
                    <br />
                    <img id="img2" width="1px" height="20px" alt="" src="#" />
                </div>
                <a id="SCTP" class="mini-button" iconcls="icon-upload" onclick="startUpload2()">上传</a> <span
                    style="color: Red; font-weight: bold;">说明：只能上传.jpg </span>
            </td>
        </tr>
    </table>
    <!--按钮菜单功能-->
    <div style="text-align: center; padding: 10px;">
        <a class="mini-button" iconcls="icon-save" onclick="save()">保存</a>
         <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()">关闭</a>
    </div>
    <input type="hidden" name="_state" id="_state" />
    <input type="hidden" name="FilmID" id="FilmID" />
    </form>
</body>
</html>

<script type="text/javascript">

    mini.parse();
    var form = new mini.Form("form1");

    //标准方法接口定义
    function SetData(data) {
        debugger;
        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenSPXX&FilmID=" + data.FilmID + "",
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    document.getElementById("FilmID").value = o.FilmID; //赋值
                    mini.get("FilmName").setValue(o.FilmName);
                    mini.get("LMBH").setText(o.LMMC);
                    mini.get("LMBH").setValue(o.LMBH);
                    mini.get("TypeID").setValue(o.TypeID);
                    mini.get("TypeID").setText(o.TypeName);
                    mini.get("CreateDate").setValue(o.CreateDate);
                    mini.get("fileupload1").setText(o.FilmURL);
                    mini.get("fileupload1").setValue(o.FilmURL);
                    mini.get("fileupload2").setText(o.SPTP);
                    mini.get("fileupload2").setValue(o.SPTP);
                }
            });
        }
        else {
            var t = mini.get("CreateDate");
            t.setValue(new Date());
        }
    }

    //附件1
    function onFileSelect(e) {
        mini.get("fileupload1").setValue(""); //固定状态
        mini.get("SCSP").setEnabled(true);
    }


    function onUploadSuccess(e) {

        mini.alert("上传成功!");
        mini.get("fileupload1").setText(e.serverData);
        mini.get("fileupload1").setValue(e.serverData); //固定状态
        mini.get("SCSP").setEnabled(false);
    }

    var htmlContent = document.getElementById("htmlContent");
    var messageid;
    function htmlClick() {
        htmlContent.style.display = "";
        messageid = mini.showMessageBox({
            width: 250,
            height: 100,
            title: "请等待...",
            html: htmlContent,
            showCloseButton: false
        });
    }

    function uploadProgress(e) {
        var Progress = e;
        var Size = Progress.total; //总大小
        var DqSize = Progress.complete; //当前上传大小
        var bfb = (DqSize / Size) * 100; //计算百分比
        var dqcd = bfb * 2; //当前长度**因为img总长度为200所以*2
        // span.innerHTML = "数据正在上传中...</br>总大小:" + Size + "</br>已上传:" + DqSize;
        // span.innerHTML += "百分比:" + bfb + "-长度:" + dqcd;
        $("#span1").html("已上传:" + Math.round(bfb) + "%");
        $("#img1").attr("width", dqcd + "px");
        $("#img1").attr("src", "../../Images/jdt.png");
    }



    function onUploadError(e) {
        mini.alert("上传失败!" + e);
    }


    function startUpload() {
        var fileupload = mini.get("fileupload1");
        if (fileupload.getText() != "") {
            fileupload.startUpload();
            htmlClick();
        }

    }

    function uploadcomplete() {
        mini.hideMessageBox(messageid);
    }





    //附件2
    function onFileSelect2(e) {
        mini.get("fileupload2").setValue(""); //固定状态
        mini.get("SCTP").setEnabled(true);
    }
    function onUploadSuccess2(e) {
        mini.alert("上传成功!");
        mini.get("fileupload2").setText(e.serverData);
        mini.get("fileupload2").setValue(e.serverData); //固定状态
        mini.get("SCTP").setEnabled(false);
    }


    var htmlContent2 = document.getElementById("htmlContent2");
    var messageid;
    function htmlClick() {
        htmlContent2.style.display = "";
        messageid = mini.showMessageBox({
            width: 250,
            height: 100,
            title: "请等待...",
            html: htmlContent2,
            showCloseButton: false
        });
    }

    function uploadProgress(e) {
        //debugger;
        var Progress = e;
        var Size = Progress.total; //总大小
        var DqSize = Progress.complete; //当前上传大小
        var bfb = (DqSize / Size) * 100; //计算百分比
        var dqcd = bfb * 2; //当前长度**因为img总长度为200所以*2
        // span.innerHTML = "数据正在上传中...</br>总大小:" + Size + "</br>已上传:" + DqSize;
        // span.innerHTML += "百分比:" + bfb + "-长度:" + dqcd;
        $("#span2").html("已上传:" + Math.round(bfb) + "%");
        $("#img2").attr("width", dqcd + "px");
        $("#img2").attr("src", "../../Images/jdt.png");
    }



    function onUploadError2(e) {
        mini.alert("上传失败!");
    }
    function startUpload2() {
        var fileupload = mini.get("fileupload2");
        if (fileupload.getText() != "") {
            fileupload.startUpload();
            htmlClick();
        }

        //        fileupload.startUpload();
    }
    //保存视频
    function save() {
        //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;
        var FilmID = document.getElementById("FilmID").value;
        var LMBH = mini.get("LMBH").getValue();
        var TypeID = mini.get("TypeID").getValue();
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveSP",
            data: { data: json, state: _state, LMBH: LMBH, TypeID: TypeID, FilmID: FilmID },
            type: "post",
            cache: false,
            success: function(text) {
                //成功
                //var mes = mini.decode(text);
                if (text == "ok") {
                    mini.alert("保存成功!");
                    CloseWindow("save");
                }
                else {
                    mini.alert(text);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }
    //关闭窗体
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) {
            window.CloseOwnerWindow(action);
        }
        else window.close();

    }
</script>


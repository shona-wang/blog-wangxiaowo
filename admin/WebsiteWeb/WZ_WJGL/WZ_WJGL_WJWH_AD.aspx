<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_WJGL_WJWH_AD.aspx.cs" Inherits="WZ_WJGL_WZ_WJGL_WJWH_AD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加文件</title>
    <script type="text/javascript" src="../../scripts/boot.js"></script>
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
    </style>
</head>
<body>
    <form id="form1" method="post">
   <fieldset style="width:500px;border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>文件信息</legend>
        <div id="editForm1" style="padding:5px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:80px;">文件名：</td>
                    <td style="width:300px;"><input id="FileName" name="FileName" class="mini-textbox" style="width:200px" required="true" requiredErrorText="文件名不能为空"/><input id="FileID" name="FileID" class="mini-textbox" visible="false"/></td>
                </tr>
                <tr>
                    <td style="width:80px;">所属分类：</td>
                    <td><input id="FileTypeID" name="FileTypeID" class="mini-combobox" style="width:200px;" textField="FileTypeName" valueField="FileTypeID" emptyText="请选择..." url="../WZ_DealData/DataProcess.aspx?method=SelectWJFLCombo" value=""  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/></td>
                </tr>
                <tr>
                    <td style="width:80px;">文件说明：</td>
                    <td><input id="FileNote" name="FileNote" class="mini-textarea" style="width:200px;height:100px"  /></td>
                </tr>
                <tr>
                    <td style="width:80px;">附件：</td>
                    <td>
                        <table align="left">
                            <tr>
                                <td>
                                   <input id="fileupload1" class="mini-fileupload" name="Fdata" limitType="*.*" 
                                    flashUrl="../swfupload/swfupload.swf"
                                    uploadUrl="upload.aspx"
                                    onuploadsuccess="onUploadSuccess" 
                                    onuploaderror="onUploadError" onfileselect="onFileSelect"  showUploadProgress="true"
                                  onuploadcomplete="uploadcomplete" onuploadProgress="uploadProgress"     />
                                    
                                  <%--  <input type="button" value="上传" onclick="startUpload()"/>--%>
                                                                        <div id="htmlContent" style="padding-left:10px;display:none;">
      <span id="span1"></span>
       <br />
       <img id="img1"  width="1px" height="20px"  alt="" src="#"/>
      </div>
                                     <a class="mini-button" iconCls="icon-upload" onclick="startUpload()">上传</a> 
                                    
                                    <input type="button" value="删除附件" onclick="del()" /><br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                <div id="listbox2" class="mini-listbox" style="width:400px;height:120px;" 
                                 value="" showCheckBox="true" multiSelect="true" >     
                                    <div property="columns">
                                        <div header="附件名称" field="FJM"></div>
                                        <div header="地址" field="Path" visible="false"></div>
                                    </div>
                                    
                                </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
        <!--按钮菜单功能-->
        <div style="text-align: center; padding: 10px;">
              <a class="mini-button" iconCls="icon-save" onclick="save()">保存</a>     
        </div>
    <input type="hidden" name="_state" id="_state" />
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");
    //////////////////////////////////////////////////////

    //下达计划
    function save() {
        var o = form.getData();

        form.validate();
        if (form.isValid() == false) return;

        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;
        var fj = mini.get("listbox2").getData();
        var sl = mini.get("listbox2").getCount();
        if (sl == 0) {
            alert("必须选择附件!");
            return;
        }
        var fj1 = mini.encode(fj);
        $.ajax({
        url: "../WZ_DealData/DataProcess.aspx?method=SaveWJ",
            data: { json: json, state: _state, fj: fj1 },
            type: "post",
            cache: false,
            success: function(text) {
                //成功
                var mes = mini.decode(text);
                if (mes.messageid == 1) {
                    //alert("保存成功!");
                    CloseWindow("save");
                }
                else {
                    mini.alert(mes.messageContent);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }

    //标准方法接口定义
    function SetData(data) {
        document.getElementById("_state").value = data.action;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            mini.get("FileID").setValue(data.FileID);
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenWJGL&FileID=" + data.FileID + "",
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.getbyName("FileName").setValue(o.FileName); //赋值
                    mini.getbyName("FileTypeID").setValue(o.FileTypeID);
                    mini.getbyName("FileNote").setValue(o.FileNote);
                    mini.getbyName("FileID").setValue(o.FileID);
                }
            });
            debugger;
            var DJBH = data.FileID;
            var url = "../WZ_DealData/DataProcess.aspx?method=WJFJLoad&FileID=" + DJBH;
            var listbox = new mini.get("listbox2");
            listbox.load(url);
        }
        else {
            //不加载ListBox
        }
    }

    function GetData() {
        var o = form.getData();
        return o;
    }

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) 
            window.CloseOwnerWindow(action);
        else window.close();
    }

    //关闭
    function onCloseClick(e) {

        var lookup2 = mini.get("lookup2");
        lookup2.hidePopup();
    }


    //附件
    function onFileSelect(e) {
        mini.get("fileupload1").setValue(""); //固定状态
    }
    
    
    function onUploadSuccess(e) {
        alert("上传成功：" + e.serverData);

        this.setText("");
           mini.get("fileupload1").setValue(""); //固定状态
//        mini.get("fileupload1").setText(e.serverData);
//        mini.get("fileupload1").setValue(e.serverData); //固定状态
        var Array = [{ "FJM": e.file.name, "Path": "UploadFiles\\WZ_WJGL\\" + e.serverData}];
        var listbox = new mini.get("listbox2");
        var aa = mini.decode(Array[0]);
        listbox.addItem(aa, listbox.getCount() + 1);

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
        $("#img1").attr("src", "../Images/jdt.png");
    }
    
    
    function onUploadError(e) {
        alert("上传失败!")
    }

    function startUpload() {

        var fileupload = mini.get("fileupload1");
        if (fileupload.getText() != "") {
            fileupload.startUpload();
            htmlClick();
        }
        
//        fileupload.startUpload();
    }


    function startUpload() {
        debugger;
        var fileupload = mini.get("fileupload1");
        if (fileupload.getText() != "") {
            fileupload.startUpload();
            htmlClick();
        }

    }

    function uploadcomplete() {
        mini.hideMessageBox(messageid);
    }
    
    

    //删除附件
    function del() {

        var listbox = new mini.get("listbox2");
        var items = listbox.getSelecteds();
        var fj1 = mini.encode(items);
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=DelWJFJ",
            data: { fj: fj1 },
            type: "post",
            cache: false,
            success: function(text) {

                //成功
                var mes = mini.decode(text);
                if (mes.messageid == 1) {
                    alert("删除成功!");
                    //CloseWindow("save");
                }
                else {
                    mini.alert(mes.messageContent);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
        listbox.removeItems(items);
    }
    
    
    
    
    
    
    
</script>

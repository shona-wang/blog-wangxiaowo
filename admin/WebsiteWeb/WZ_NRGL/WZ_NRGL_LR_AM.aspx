<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_NRGL_LR_AM.aspx.cs" Inherits="WZ_NRGL_WZ_NRGL_LR_AM"  validateRequest="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>文章维护</title>
    
     <script type="text/javascript" src="../../scripts/boot.js"></script>
     
     <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>
     <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
     <link rel="stylesheet" href="../../kindeditor/themes/default/default.css" />
	 <script charset="utf-8" src="../../kindeditor/kindeditor-min.js" type ="text/javascript" ></script>
	 <script charset="utf-8" src="../../kindeditor/lang/zh_CN.js" type ="text/javascript" ></script>

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
            display:block;
           
        }
         .style1
         {
             width: 189px;
         }
    </style>
</head>
<body>
     <form id="form1" method="post">
     <!--按钮菜单功能-->
        <div id="editForm1" style="padding:5px;">
            <table style="text-align: right">
                <tr>
                    <td class="style1" style="text-align: right">主标题：</td>
                    <td style="width:260px;"><input id="XWZBT" name="XWZBT" class="mini-textbox" style="width:100%;" required="true" requiredErrorText="新闻主标题不能为空"></td>
                    <td style="width:120px;">所属栏目名称：</td>
                    <td style="width:260px;"><input id="LMMC" name="LMMC" class="mini-textbox" style="width:100%;" readonly="readonly"/></td>
                </tr>
                <tr>
                    <td class="style1">发布者：</td>
                    <td style="text-align:left;"><%=UserName %></td>
                    <td>是否图片新闻：</td>
                    <td style="text-align:left;">
                    <div id="SFTP" name="SFTP" class="mini-checkbox" checked="false" readOnly="false" text="图片新闻"></div>
                    </td>
                </tr>
                <tr>
                    <td class="style1">发布时间：</td>
                    <td> <input id="FBSJ" name="FBSJ" class="mini-datepicker" style="width:100%;" format="yyyy-MM-dd" showOkButton="false" showClearButton="false"/></td>
                    <td>有效天数：</td>
                    <td><input id="SXTS" name="SXTS" class="mini-textbox" style="width:100%;" vtype="int" /></td>
                </tr>
                  <tr>
                    <td class="style1">编辑：</td>
                    <td> <input id="BJ" name="BJ" class="mini-textbox" style="width:100%;" /></td>
                    <td>来源：</td>
                    <td><input id="LY" name="LY" class="mini-textbox" style="width:100%;"  /></td>
                </tr>
                  <tr>
                  <td>摘要：</td>
                  <td colspan="3">
                     <input id="ZY" name="ZY" class="mini-textbox" style="width:100%;"/>
                  </td>
                </tr>
                <tr align="center">
                    <td class="style1">
                   <input id="SSZT" name="SSZT" class="mini-combobox" style="width:0px;" textField="ZTMC" valueField="ID" emptyText="请选择..." url="../WZ_DealData/DataProcess.aspx?method=SelectZTCombo" value=""  allowInput="false" showNullItem="true" nullItemText="请选择..." visible ="false" />
                    </td>
                    <td><div id="SFGG" name="SFGG" class="mini-checkbox" checked="false" readOnly="false" text="公告" visible="false"></div></td>
                    <td><div id="SFTZ" name="SFTZ" class="mini-checkbox" checked="false" readOnly="false" text="通知" visible="false"></div></td>
                    <td><div id="SFRD" name="SFRD" class="mini-checkbox" checked="false" readOnly="false" text="热点" visible="false"></div></td>
                </tr>
                <tr>
                   <td colspan="4">
                     <textarea id="content1" cols="100" rows="8" style="width:100%;height:300px;visibility:hidden;"  ></textarea>
                   </td>
                </tr>
                <tr>
                   <td colspan="4" style="text-align:center;">
                      <a class="mini-button" iconcls="icon-save" onclick="save">保存</a> <a class="mini-button"
                        iconcls="icon-close" onclick="CloseWindow">关闭</a>
                      <input type="hidden" name="_state" id="_state" /> 
                      <input type="hidden" name="_path" id="_path" /> 
                      <input id="XWBH" name="XWBH" class="mini-hidden" >
                      <input id="LMBH" name="LMBH" class="mini-hidden" >
                   </td>
                </tr>
            </table>
        </div>
  </form> 
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    $(window).load(function() {
    });
    //////////////////////////////////////////////////////
    var editor1 ;
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
                document.getElementById("_path").value = data;
            }
        });
        prettyPrint();

    });
    //保存
    function save() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        var _state = document.getElementById("_state").value;

        var lmbh = mini.get("LMBH").getValue();
        var lmmc = mini.get("LMMC").getValue();
        //var content = editor1.text();
        var content = editor1.html();
        var path = document.getElementById("_path").value;

        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveDocInfo",
            data: { data: json, state: _state, content: content, path: path },
            type: "post",
            cache: false,
            success: function(text) {
                if (text == 1) {
                    CloseWindow("save");
                }
                else {
                    mini.alert("保存失败!");
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
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenDocInfo&XWBH=" + data.XWBH + "",
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.get("XWBH").setValue(o.XWBH);
                    mini.get("XWZBT").setValue(o.XWZBT);
                    mini.get("LMBH").setValue(o.LMBH);
                    mini.get("LMMC").setValue(o.LMMC);
                    mini.get("LMBH").setValue(o.LMBH);
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
                    document.getElementById("_path").value = o.SYTP;
                }
            });
        }
        else {
            mini.get("LMBH").setValue(data.LMBH);
            mini.get("LMMC").setValue(data.LMMC);
            var t = mini.get("FBSJ");
            t.setValue(new Date());
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
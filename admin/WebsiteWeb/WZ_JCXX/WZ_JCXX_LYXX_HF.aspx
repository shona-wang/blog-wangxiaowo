<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WZ_JCXX_LYXX_HF.aspx.cs" Inherits="WZ_JCXX_WZ_JCXX_LYXX_HF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>信息回复</title>
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
    <div style="text-align: center; padding: 10px;">
       <a class="mini-button" iconCls="icon-save" onclick="save()">回复</a><span class="separator"></span> 
       <a class="mini-button" iconcls="icon-close" onclick="CloseWindow()">关闭</a>    
     </div>
      <form id="form1" method="post">
     <!--按钮菜单功能-->
   
     <fieldset style="width:800px;border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>基本信息</legend>
        <div id="editForm1" style="padding:5px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:120px;">信访类型：</td>
                    <td style="width:260px;"><input id="ID" name="ID" class="mini-textbox" style="width:100%;" visible="false"><input id="XFLXMC" name="XFLXMC" class="mini-textbox" style="width:100%;" readonly="readonly"></td>
                </tr>
                <tr>
                    <td style="width:120px;">发信人：</td>
                    <td style="width:260px;"><input id="FXRMC" name="FXRMC" class="mini-textbox" style="width:100%;" readonly="readonly"></td>
                </tr>
                <tr>
                    <td>标题：</td>
                    <td><input id="FXBT" name="FXBT" class="mini-textbox" style="width:100%;" readonly="readonly"></td>
                </tr>
                <tr>
                    <td>原内容</td>
                    <td><input id="FXNR" name="FXNR" class="mini-textarea" style="width:100%;height:150px;" readonly="readonly"></td>
                </tr>
                 <tr>
                    <td>回复人：</td>
                    <td><%=UserName %></td>
                </tr>
                <tr>
                    <td>回复标题：</td>
                    <td><input id="HFBT" name="HFBT" class="mini-textbox" style="width:100%;" required="true" emptyText="请输入回复标题"></td>
                </tr>
                <tr>
                    <td>回复内容：</td>
                    <td><input id="HFNR" name="HFNR" class="mini-textarea" style="width:100%;height:150px" required="true" emptyText="请输入回复内容"></td>
                </tr>
            </table>
        </div>
    </fieldset>
  </form> 
</body>
</html>

<script type="text/javascript">
    mini.parse();

    var form = new mini.Form("form1");

    $(window).load(function() {
    });
    //////////////////////////////////////////////////////
    function save() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        
        $.ajax({
            url: "../WZ_DealData/DataProcess.aspx?method=SaveLYXXHF",
            data: { data: json },
            type: "post",
            cache: false,
            success: function(text) {
                debugger;
                //成功
                //var mes = mini.decode(text);
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
        debugger;
        if (data.action == "edit") {
            data = mini.clone(data); //跨页面传递的数据对象，克隆后才可以安全使用
            $.ajax({
                url: "../WZ_DealData/DataProcess.aspx?method=OpenLYXXInfo&IDH=" + data.IDH + "",
                cache: false,
                success: function(text) {
                    debugger;
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.get("ID").setValue(o.ID);
                    mini.get("XFLXMC").setValue(o.XFLXMC);
                    mini.get("FXRMC").setValue(o.FXRMC);
                    mini.get("FXBT").setValue(o.FXBT);
                    mini.get("FXNR").setValue(o.FXNR);
                    mini.get("HFNR").setValue(o.HFNR);
                    mini.get("HFBT").setValue("回复：《" + o.FXBT + "》");
                }
            });
        }
    }

    function GetData() {
        var o = form.getData();
        return o;
    }

    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

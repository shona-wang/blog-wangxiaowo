<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KY_Flow_Handle.aspx.cs" Inherits="FlowDemo_KY_FlowDemo_KY_Flow_Handle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>工作流程处理页面</title>

    <script src="../../scripts/boot.js" type="text/javascript"></script>

    <script src="../../JavaScript/KYOfficeCommon.js" type="text/javascript"></script>

    <style type="text/css">
        #CLYJ
        {
            height: 60px;
            width: 213px;
        }
        .style1
        {
            width: 146px;
        }
        #CLRY
        {
            height: 23px;
            width: 211px;
        }
    </style>
</head>
<body>
    <div class="mini-toolbar" style="width: 98%; height: 30px;">
        <a class="mini-button" iconcls="icon-folder" plain="true">查看文件</a> <span class="separator">
        </span><a class="mini-button" iconcls="icon-folderopen" plain="true" onclick="OpenFlowLook">
            查看流程</a> <span class="separator"></span><a id="tj" class="mini-button" iconcls="icon-save"
                plain="true" onclick="SaveFlows">提交</a> <span class="separator"></span><a id="A1"
                    class="mini-button" iconcls="icon-addfolder" plain="true" onclick="OpenYiJian()">
                    查看处理意见</a> <span class="separator"></span><a class="mini-button" iconcls="icon-close"
                        onclick="CloseWindow()" plain="true">关闭</a>
    </div>
    <fieldset id="form1" style="width:97%; border: solid 1px #aaa; position: relative;
        height: 550px;">
        <table style="width: 100%;">
            <tr>
                <td class="style1" style="text-align: right">
                    处理结果
                </td>
                <td>
                    <input id="CLJG" name="CLJG" class="mini-combobox" style="width: 250px;" textfield="processJG"
                        valuefield="processJG" required="true" />
                </td>
            </tr>
            <tr>
                <td class="style1" style="text-align: right">
                    处理意见
                </td>
                <td>
                    <textarea id="CLYJ" name="CLYJ" style="width: 250px;" class="mini-textarea" emptytext="请输入处理意见"></textarea>
                </td>
            </tr>
            <tr>
                <td class="style1" style="text-align: right">
                    <span id="sp1"></span>
                </td>
                <td>
                    <input id="CLLC" name="CLLC" class="mini-combobox" style="width: 250px;" shownullitem="true"
                        allowinput="false" textfield="STEP_NAME" valuefield="START_OBJECT_DM" visible="false"
                        onvaluechanged="Changed" />
                </td>
            </tr>
            <tr>
                <td class="style1" style="text-align: right">
                    <span id="sp2"></span>
                </td>
                <td>
                    <input id="CLRY" allowinput="false" style="width: 250px; text-align: right;" name="CLRY"
                        class="mini-buttonedit" onbuttonclick="onSButtonEdit" visible="false" enabled="false" />
                </td>
            </tr>
        </table>
        <span id="sp3"></span>
        <input id="billcode" name="billcode" class="mini-hidden" />
        <input id="IDBH" name="IDBH" class="mini-hidden" />
        <input id="ApplyID" name="ApplyID" class="mini-hidden" />
        <input id="object_dm" name="object_dm" class="mini-hidden" />
        <input id="Allow_Jump" name="Allow_Jump" class="mini-hidden" />
        <input id="TZBS" name="TZBS" class="mini-hidden" value="0" />
    </fieldset>
</body>
</html>

<script type="text/javascript" language="javascript">
    mini.parse();
    var form = new mini.Form("form1");
    var clry = mini.get("CLRY");
    $(window).load(function() {
        //debugger;
        var Request = new QueryString();
        mini.get("billcode").setValue(Request["billcode"]);
        mini.get("IDBH").setValue(Request["IDBH"]);
        mini.get("ApplyID").setValue(Request["ApplyID"]);
        mini.get("object_dm").setValue(Request["object_dm"]);
        mini.get("Allow_Jump").setValue(Request["Allow_Jump"]);
        mini.get("CLJG").setUrl("../../Flows/Flows_Data.aspx?method=Get_ProcessJG&IDBH=" + Request["IDBH"]);
        if (Request["Allow_Jump"] == 1) { //流程设置为该节点运行跳转
            IsEnabled(Request["object_dm"]);
        }

    });
    function IsEnabled(object_dm) {
        var cllc = mini.get("CLLC");
        cllc.setUrl("../../Flows/Flows_Data.aspx?method=Get_Object_dm&Object_dm=" + object_dm);
        cllc.setVisible(true);
        var CLRY = mini.get("CLRY");
        CLRY.setVisible(true);
        $("#sp1").html("选择下一步流程");
        $("#sp2").html("下一步处理者");
        $("#sp3").html("说明:1.如果没有选择下一步流程,系统会按照预先设置的步骤进行！<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.如果选择了下一步流程,但是没有选择处理人员，系统会按照预先设置好人员处理！<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.如果你想改变处理人员,必须选择下一步流程！");
    }
    function onSButtonEdit(e) {
        var btnEdit = this;
        mini.open({
            url: "UserMultiple.aspx",
            title: "多选列表",
            width: 650,
            height: 380,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();

                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    btnEdit.setValue(data.yhm);
                    btnEdit.setText(data.xx);
                }
            }
        });
    }
    function SaveFlows() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
        mini.confirm("确定处理此条数据吗？", "确定？",
            function(action) {
                if (action == "ok") {
                    $.ajax({
                        url: "KY_FlowDemoData.aspx?method=FlowSave",
                        data: { data: json },
                        cache: false,
                        success: function(text) {
                            if (text != "-1") {
                                mini.alert("提交成功！");
                                mini.get("tj").setEnabled(false);
                                //debugger;
//                                var a = top["winMenu"];
//                                a.closeTab();
                            }
                            else {
                                mini.alert("提交失败！");
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            alert(jqXHR.responseText);
                            CloseWindow();
                        }
                    });
                }
            });
    }
    function OpenFlowLook() {
        mini.open({
            url: "../Flows/FlowLook.aspx?DJBH=" + mini.get("billcode").getValue(),
            title: "流程查看",
            width: 550,
            height: 600

        });
    }
    function OpenYiJian() {
        mini.open({
            url: "../Flows/Flow_YiJian.aspx?billcode=" + mini.get("billcode").getValue(),
            title: "查看处理意见",
            width: 650,
            height: 380
        });

    }
    function Changed() {
        var cllc = mini.get("CLLC");
        var tzts = mini.get("TZBS");
        if (cllc.getValue() == "") {
            tzts.setValue("0");
            clry.setEnabled(false);
            clry.setValue('');
            clry.setText('');
        } else {
            tzts.setValue("1");
            clry.setEnabled(true);
        }
    }
    //关闭窗口
    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>


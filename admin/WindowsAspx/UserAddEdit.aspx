<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserAddEdit.aspx.cs" Inherits="WindowsAspx_UserAddEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>人员编辑</title>

    <script src="../scripts/boot.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            width: 96px;
        }
        .style3
        {
            width: 147px;
        }
        .style4
        {
            width: 131px;
        }
        .mini-textbox
        {
            width: 128px;
        }
    </style>
</head>
<body>
    <form id="form1" method="post">
    <table>
        <tr>
            <td class="style1" style="text-align: right">
                帐号:
            </td>
            <td class="style3">
                <input id="YHM" name="YHM" class="mini-textbox" required="fales" onvaluechanged="Repeat()" />
            </td>
            <td class="style4" style="text-align: right">
                姓名:
            </td>
            <td>
                <input name="XX" class="mini-textbox" required="fales"/>
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                关联帐号:</td>
            <td class="style3">
                <input id="RELATEDYHM" name="RELATEDYHM" class="mini-textbox" required="fales" onvaluechanged="RelatedyhmCount()"
                    /></td>
            <td class="style4" style="text-align: right">
                是否绑定MAC:
            </td>
            <td>
                <select name="SFBD" class="mini-combobox" onvaluechanged="onsfbdChanged" value="0"
                    valuefield="sfbd">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                是否领导:
            </td>
            <td class="style3">
                <select name="SF" class="mini-combobox" onvaluechanged="onsfChanged" value="0">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </td>
            <td class="style4" style="text-align: right">
                首要职务:
            </td>
            <td>
                <select name="SF_1" class="mini-combobox" value="0" valuefield="sf_1">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                员工的主管:
            </td>
            <td class="style3">
                <select name="SF_3" class="mini-combobox" value="0" valuefield="sf_3">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </td>
            <td class="style4" style="text-align: right">
                所属部门:
            </td>
            <td>
                <input id="bmbm" name="bmbm" class="mini-buttonedit" onbuttonclick="onButtonEdit"
                    allowinput="false" />
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                领导的主管:
            </td>
            <td class="style3">
                <select name="SF_2" class="mini-combobox" value="0" valuefield="sf_2">
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select>
            </td>
            <td class="style4" style="text-align: right">
                职位:
            </td>
            <td>
                <input name="ZWID" class="mini-combobox" valuefield="ZWID" textfield="ZWMC" url="AspxDate.aspx?method=TableSelect" />
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                序号:
            </td>
            <td class="style3">
                <input id="SRM" name="SRM" class="mini-spinner"  minValue="1" maxValue="10000" />
            </td>
            <td class="style4" style="text-align: right">
                MAC号:
            </td>
            <td>
                <input name="MACID" class="mini-textbox" size="20" />
            </td>
        </tr>
        <tr>
            <td class="style1" style="text-align: right">
                所属角色:
            </td>
            <td colspan="3">
                <input id="lookRoleid" name="lookRoleid" style="width: 414px;" class="mini-buttonedit"
                    onbuttonclick="onRolesButtonEdit" allowinput="false" />
            </td>
        </tr>
         <tr>
          <td style="text-align: right">手机号:
            </td>
            <td>
                <input name="ZW" class="mini-textbox" size="11" /></td>
            <td class="style1" style="text-align: right">
               
                &nbsp;</td>
            <td class="style1">
                
    <div id="DELETEBS" name="DELETEBS" class="mini-checkbox"  readOnly="false" text="有效" ></div>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center;">
                <a class="mini-button" iconcls="icon-save" onclick="onOk">保存</a> <a class="mini-button"
                    iconcls="icon-close" onclick="onCancel">关闭</a>
                <input id="YHM_ID" name="YHM_ID" class="mini-hidden" value="Add" />
                <input name="SJFW" class="mini-hidden" />
                 <input id="J_RELATEDYHM" name="J_RELATEDYHM" class="mini-hidden" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("form1");
    var btnEdit = mini.get("bmbm");
    var chbox = mini.get("DELETEBS");
    function SaveData() {
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);
            $.ajax({
                url: "AspxDate.aspx?method=SaveUser",
                data: { data: json },
                cache: false,
                success: function(text) {
                    var Mes = mini.decode(text);
                    if (Mes.messageid == 1) {
                        CloseWindow("save");
                    }
                    else {
                        mini.alert(Mes.messageContent);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
    }
    ////////////////////
    //标准方法接口定义
    function SetData(data) {
        if (data.action == "edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
            $.ajax({
                url: "AspxDate.aspx?method=RydjGetuser&yhm=" + data.yhm,
                cache: false,
                success: function(text) {
                    var o = mini.decode(text);
                    form.setData(o);
                    form.setChanged(false);
                    mini.getbyName("ZWID").setValue(o.ZWID);
                    var t = mini.get("bmbm");
                    t.setValue(o.DWID);
                    t.setText(o.DWMC);
                    var b = mini.get("lookRoleid");
                    b.setValue(o.RoleID);
                    b.setText(o.RoleName);
                    if (o.DELETEBS == "0") {
                        chbox.setChecked(true);
                    }
                    else {
                        chbox.setChecked(false);
                    }
                    //mini.get("YHM").disable();
                    if (o.RELATEDYHM == "" || o.RELATEDYHM == null) {

                        mini.get("RELATEDYHM").setValue(o.YHM);
                    }
                    
                    //mini.get("RELATEDYHM").disable();
                    mini.get("J_YHM").setValue(o.YHM);
                }
            });
        }
        else {
            chbox.setChecked(true);
        }
    }

    function GetData() {
        var o = form.getData();
        return o;
    }
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();

    }

    //保存
    function onOk(e) {
        SaveData();
    }
    //取消
    function onCancel(e) {
        CloseWindow("cancel");
    }
    //是否绑定
    function onsfbdChanged(e) {
        var deptCombo = mini.getbyName("SFBD");
        var dept_id = deptCombo.getValue();
        var MAcid = mini.getbyName("MACID");
        if (dept_id == "0") {
            MAcid.setValue("");
            MAcid.disable();
        }
        else {
            MAcid.enable();
        }
    }
    //是否领导事件
    function onsfChanged(e) {
        var deptCombo = mini.getbyName("SF");
        var dept_id = deptCombo.getValue();
        var sf1 = mini.getbyName("SF_1");
        var sf2 = mini.getbyName("SF_2");
        var sf3 = mini.getbyName("SF_3");
        if (dept_id == "0") {
            sf1.setValue("0");
            sf1.disable();
            sf2.setValue("0");
            sf2.disable();
            sf3.setValue("0");
            sf3.disable();
        }
        else {
            sf1.enable();
            sf2.enable();
            sf3.enable();
        }
    }
    //部门选择
    function onButtonEdit(e) {
        mini.open({
            url: "EmpTree.aspx",
            showMaxButton: false,
            title: "选择树",
            width: 350,
            height: 350,
            ondestroy: function(action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    if (data) {
                        btnEdit.setValue(data.DWID);
                        btnEdit.setText(data.TEXT);
                    }
                }
            }
        });
    }
    function _dwid(id) {
        $.ajax({
            url: "AspxDate.aspx?method=get_table38&JDDM=" + id,
            type: "post",
            cache: false,
            success: function(text) {
                btnEdit.setValue(text);
            }
        });

    }
    //验证用户名是否重复
    function Repeat() {
        var yhm = mini.get("YHM").getValue();
        var RELATEDYHM = mini.get("RELATEDYHM").getValue();
        var sftype='N',yhm_id=mini.get("YHM_ID").getValue();
        if (yhm_id == '') { //新增状态
            sftype = "Y"; //需要验证
        }
        else { //修改状态
            if (yhm != yhm_id && yhm != RELATEDYHM)//说明yhm已经修改
            {
                sftype = "Y";//需要验证
            }
        }
        if (sftype == "Y") {
            $.ajax({
                url: "AspxDate.aspx?method=UserRepeatCount&yhm=" + yhm,
                type: "post",
                success: function(text) {
                    if (text > 0) {
                        mini.alert("账号重复,请重新输入!");
                        var yhm = mini.getbyName("YHM");
                        yhm.setValue("");
                        yhm.focus();
                    }
                    else {
                        if (mini.get("RELATEDYHM").getValue() == '') {
                            mini.get("RELATEDYHM").setValue(mini.get("YHM").getValue());
                        }
                    }
                }
            });
        }
    }
    function RelatedyhmCount() {
        var yhm = mini.get("YHM").getValue();
        var RELATEDYHM = mini.get("RELATEDYHM").getValue();
        var yhm_id = mini.get("YHM_ID").getValue();
        var sftype = 'N', J_RELATEDYHM = mini.get("J_RELATEDYHM").getValue();
        if (yhm_id == '') { //新增状态
            sftype = "Y"; //需要验证
        }
        else { //修改状态
            if (RELATEDYHM != J_RELATEDYHM && RELATEDYHM != yhm)//说明RELATEDYHM已经修改
            {
                sftype = "Y";//需要验证
            }
        }
        if (sftype == "Y") {
            $.ajax({
                url: "AspxDate.aspx?method=UserRelatedyhmCount&Relatedyhm=" + RELATEDYHM,
                type: "post",
                success: function(text) {
                    if (text > 0) {
                        mini.alert("关联账号重复,请重新输入!");
                        mini.getbyName("RELATEDYHM").setValue('');
                    }
                }
            });
        }
    }
    //角色选择
    function onRolesButtonEdit(e) {
        var btnEdit = this;
        mini.open({
            url: "sysRolesDic_grid.aspx",
            title: "多选列表",
            width: 650,
            height: 380,
            ondestroy: function(action) {

                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = mini.clone(data);
                    btnEdit.setValue(data.id);
                    btnEdit.setText(data.text);
                }
            }
        });
    }     
</script>


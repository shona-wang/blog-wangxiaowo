 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="KH_GenZong_Edit.aspx.cs" Inherits="CustomersAspx_KH_GenZong_KH_GenZong_Edit" %>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
 <html xmlns="http://www.w3.org/1999/xhtml">
 
 <head runat="server">
     <title>客户-跟踪信息编辑页面</title>
     <script src="../../scripts/boot.js" type="text/javascript"></script>
         <script src="../../swfupload/swfupload.js" type="text/javascript"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=15&ak=YmqQ8XasNDPWbUvN2LdbTFFv"></script>

<%--     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
--%>     <style type="text/css">
         html, body
         {
             margin: 0;
             padding: 0;
             border: 0;
             width: 100%;
             height: 100%;
         }
             #GZNR
             {
                 width: 360px;
                 height: 169px;
             }
             #fileupload1
             {
                 width: 294px;
             }
             .style1
             {
                 width: 79px;
             }
             #JD
             {
                 width: 358px;
             }
             #WD
             {
                 width: 357px;
             }
             #LXRQ
             {
                 width: 355px;
             }
             .style2
             {
                 width: 107px;
             }
     </style>
 </head>
 <body>
 <form id="form1">
   <table style="text-align: right; width: 500px;">
    <tr>
     <td style="text-align:right;" class="style2">跟踪内容</td>
    <td style="text-align:left;"><input id="GZNR" name="GZNR" class="mini-textarea" required="true"/></td>
    </tr>
    <tr>
     <td style="text-align:right;" class="style2">日期</td>
    <td style="text-align:left;" class="style1"><input id="LXRQ" name="LXRQ" class="mini-datepicker" allowInput="flase" required="true"/></td>
    
    </tr>
    <tr>
        <td class="style2">
                附件:
            </td>
            <td  style="text-align: left">
                <input id="fileupload1" class="mini-fileupload" name="Fdata" flashurl="../../swfupload/swfupload.swf"
                    limittype="*" uploadurl="FuJianData.aspx" onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError" />
                <a class="mini-button" id="A2" iconcls="icon-upload" onclick="onFileSelect()">上传</a>
            </td>
    </tr>
      <tr>
      <td class="style2"></td>
            <td style="text-align: left">
                <div id="listbox2" class="mini-listbox" style="width: 360px; height: 100px;" value=""
                    showcheckbox="true" multiselect="false" showallcheckbox="false">
                    <div property="columns">
                        <div type="indexcolumn" style="width: 6px;" headeralign="center">
                            序号</div>
                        <div header="文件名" field="Docname" renderer="DownLoad" style="text-align: center">
                        </div>
                        <div header="操作" field="FPath" name="action" renderer="onActionRenderer" style="width: 546px">
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    <tr>
     <td colspan="2" style="text-align: center;">
       <a class="mini-button" iconcls="icon-save" onclick="SaveData">保存</a> <a class="mini-button"
            iconcls="icon-close" onclick="CloseWindow">关闭</a>
        <input id="mytype" name="mytype" class="mini-hidden" />
        <input id="GZBH" name="GZBH" class="mini-hidden" />
        <input id="Cust_ID" name="Cust_ID" class="mini-hidden"/>
        <input id="JD" name="JD" class="mini-hidden"/>
        <input id="WD" name="WD" class="mini-hidden"/>
        <input id="DZ" name="DZ" class="mini-hidden"/>
     </td>
     </tr>
   </table>
 </form>
 <div id="allmap"></div>  
 </body>
 </html>
 <script type="text/javascript" language="javascript">
     mini.parse();
     $(window).load(function() {
         var map = new BMap.Map("allmap");
         var point = new BMap.Point(118.185789, 24.489321); //116.331398, 39.897445
         map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别
         var geolocation = new BMap.Geolocation();
         var gc = new BMap.Geocoder();
         geolocation.getCurrentPosition(function(r) {
             //debugger;
             if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                 debugger;
                 var mk = new BMap.Marker(r.point);
                 map.addOverlay(mk);
                 map.panTo(r.point);
                 //alert('您的位置：' + r.point.lng + ',' + r.point.lat);
                 mini.get("JD").setValue(r.point.lng);
                 mini.get("WD").setValue(r.point.lat);
                 var pt = r.point;
                 var message = "";
                 gc.getLocation(pt, function(rs) {
                     var addComp = rs.addressComponents;
                     mini.get("DZ").setValue('录入位置:' + addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
                     //alert(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
                 });
             }
             else {
                 //alert('failed' + this.getStatus());
                 mini.get("JD").setValue('109.898866');
                 mini.get("WD").setValue('40.665348');
                 mini.get("DZ").setValue('开元数码有限公司');
             }
         })
     });
    var form = new mini.Form("form1");
   //保存函数
    function SaveData() {
    //debugger;
        var o = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode([o]);


        var date = mini.get("listbox2").getData();

        var json_data = mini.encode(date);
        if (json_data == "[]") {
            json_data = "";
        }
        $.ajax({
        url: "KH_GenZongData.aspx?method=KH_GenZong_Insert",
        data: { data: json ,Cdata: json_data},
        type: "post",
            success: function(text) {
                if (text == -1) {
                    mini.alert("提示:数据操作失败!");
                }
                else {
                    CloseWindow();
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
        //debugger;
       if (data.action == "Edit") {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
           $.ajax({
           url: "KH_GenZongData.aspx?method=KH_GenZong_Json_SelectWhere&DJBH=" + data.GZBH,
                cache: false,
               success: function(text) {
                   var o = mini.decode(text);
                    form.setData(o);
                    mini.get("mytype").setValue("Edit");
                    mini.get("Cust_ID").setValue(data.Cust_ID);
                    mini.get("GZBH").setValue(data.GZBH);
                    var url = "../../WindowsAspx/AspxDate.aspx?method=FJ_Select&DJBH=" + data.GZBH;
                    var listbox = new mini.get("listbox2");
                    listbox.load(url);
                }
           });
        }
        else {
            mini.get("mytype").setValue("Add");
            mini.get("Cust_ID").setValue(data.Cust_ID);
        }
    }
  //关闭
    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) window.CloseOwnerWindow(action);
        else window.close();
    }
//附件
//文件选择时激发
    function onFileSelect() {
        //debugger;
        var val = mini.get("fileupload1");
        if (val.text == "") {
            alert("上传文件不能为空");
        }
        else {
            val.startUpload();
        }
    }
    function onUploadSuccess(e) {

        if (e.serverData != "") {
            //mini.alert("上传成功");
            //查询附件
            this.setText("");
            var _file = mini.decode(e.serverData);
            var Array = [{ "Docname": _file.FileText, "FPath": _file.FileName}];

            var listbox = new mini.get("listbox2");
            var aa = mini.decode(Array[0]);
            listbox.addItem(aa, listbox.getCount() + 1);

        }
    }
    function onUploadError(e) {
        //debugger;
        alert("上传失败:" + e.serverData);
    }
//绘制操作列
function onActionRenderer(e) {

    var grid = e.sender;
    var record = e.record;
    var s = ' <a class="Delete_Button" href="javascript:delRow(\'' + record.FPath + '\',\'' + record.FJM + '\')">删除</a>';
    return s;
}
//下载
function DownLoad(e) {
    var rows = e.row;
    var s = ' <a  href="../../UploadFiles/' + e.item.FPath + '">' + e.value + '</a>';
    return s;
}
function delRow(record, fjm) {
    var listbox = new mini.get("listbox2");
    var items = listbox.getSelecteds();
    mini.confirm("确定删除记录？", "确定？",
            function(action) {
                if (action == "ok") {
                    $.ajax({
                        url: "../../WindowsAspx/AspxDate.aspx?method=FJ_Delete&&DJBH=" + record,
                        success: function(text) {
                            if (text == "0") {
                                //mini.alert("删除成功！");
                                var Array = [{ "FJM": fjm, "FJPath": record}];
                                listbox.removeItems(items); //删除文件
                            }
                            else {
                                mini.alert("删除失败！");
                            }
                        },
                        error: function() {
                        }
                    });
                } else {

                }
            }
        );
     }
 </script>


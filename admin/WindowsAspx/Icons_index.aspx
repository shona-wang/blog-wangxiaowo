<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Icons_index.aspx.vb" Inherits="WindowsAspx_Icons_index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>图标获取</title>
    <script src="../scripts/boot.js" type="text/javascript"></script>
  <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
    </style>
</head>
<body>
 <div class="mini-fit">
     <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" 
        url="AspxDate.aspx?method=Icon_GetImg" idField="icon"
        allowResize="true" sizeList=[50,100,300,500] pagesize="100" onrowdblclick="onRowDblClick"
         allowCellSelect="true" multiSelect="true">
        <div property="columns">
           <div type="indexcolumn" width="15" ></div>
            <div field="icon" width="15" headerAlign="center" allowSort="true">图标
            </div>
             <div field="iconName" width="30" headerAlign="center" allowSort="true">名称
            </div>
        </div>
    </div>
    </div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>
  <script type="text/javascript" language="javascript">      
  //加载绑定
      mini.parse();
      var grid = mini.get("datagrid1");
      grid.load();
      grid.on("drawcell", function(e) {
          //debugger;
        var record = e.record,
        column = e.column,
        field = e.field,
        value = e.value;
          //将
        if (column.field == "icon") {
              e.cellHtml = "<img src='../scripts/miniui/themes/icons/"+value+"' />";
          }
      });
      function GetData() {
          var row = grid.getSelected();
          return row;
      }
      function search() {
          var key = mini.get("key").getValue();
          grid.load({ key: key });
      }
      function onKeyEnter(e) {
          search();
      }
      function onRowDblClick(e) {
          onOk();
      }
      //////////////////////////////////
      function CloseWindow(action) {
          if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
          else window.close();
      }

      function onOk() {
          CloseWindow("ok");
      }
      function onCancel() {
          CloseWindow("cancel");
      }
</script>

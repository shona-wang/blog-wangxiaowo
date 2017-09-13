using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
public partial class WindowsAspx_User_ExcelDate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String json = Request["columns"];
        DataTable Ds = KY.ERPOffice.BLL.Rydj_BLL.Select_RydjDs("");
        ArrayList columns = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(json);//Test.JSON.Decode(json);
        ArrayList datalist =KY.ERPOffice.Common.MyPublicMin._FormatForJsonData(Ds);
        KY.ERPOffice.Common.pub_BLL.ExcelDownload(this, datalist, columns);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Flows_Taskulous_Mobilephone_Data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string WeiXinCode = Request.QueryString["WeiXinCode"].ToString();
        string Json=KY.ERPOffice.BLL.Flows_BLL.Get_Taskulous_MobilePhone(WeiXinCode);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WindowsAspx_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        KY.ERPOffice.Common.MyPublicMin.RemoveSessionCookies();
    }
    /// <summary>
    /// 系统名称
    /// </summary>
    /// <returns></returns>
    public string WinTitleName()
    {
        return KY.ERPOffice.Common.GetConfig.WinTitleName();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KY.ERPOffice.Common;

public partial class WindowsAspx_Menuindex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        KY.ERPOffice.Common.MyPublicMin.isHaveLogin();
    }
    public string UserName()
    {
        return KY.ERPOffice.Common.SessionGetSet.getUserName();
    }
    public string EmployeesName()
    {
        return KY.ERPOffice.Common.SessionGetSet.getEmployeesName();
    }
    /// <summary>
    /// 系统名称
    /// </summary>
    /// <returns></returns>
    public string WinTitleName()
    {
        return KY.ERPOffice.Common.GetConfig.WinTitleName();
    }
    /// <summary>
    /// 技术支持
    /// </summary>
    /// <returns></returns>
    public string TechnicalSupport()
    {
        return KY.ERPOffice.Common.GetConfig.TechnicalSupport();
    }
    /// <summary>
    /// 联系电话
    /// </summary>
    /// <returns></returns>
    public string ContactTelephone()
    {
        return KY.ERPOffice.Common.GetConfig.ContactTelephone();
    }
    /// <summary>
    /// 网址
    /// </summary>
    /// <returns></returns>
    public string Website()
    {
        return KY.ERPOffice.Common.GetConfig.Website();
    }
    /// <summary>
    /// 首页链接地址
    /// </summary>
    /// <returns>首页链接地址</returns>
    public string HomeUrl()
    {
        return KY.ERPOffice.Common.GetConfig.HomeUrl();
    }
}

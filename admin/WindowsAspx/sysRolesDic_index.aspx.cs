using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WindowsAspx_sysRolesDic_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        KY.ERPOffice.Common.MyPublicMin.isHaveLogin();
    }
    public string HtmlHidden(string TableName)
    {
        return KY.ERPOffice.BLL.HtmlWebForm_BLL.HtmlHidden(TableName);
    }
}

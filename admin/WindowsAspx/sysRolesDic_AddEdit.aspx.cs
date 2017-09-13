using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WindowsAspx_sysRolesDic_AddEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string HiddenText = "";
    public string Html(string FL)
    {
        string HtmlText = KY.ERPOffice.BLL.HtmlWebForm_BLL.HtmlText(FL, ref HiddenText);
        return HtmlText;
    }
}

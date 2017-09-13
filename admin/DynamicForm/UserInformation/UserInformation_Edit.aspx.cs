using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
public partial class DynamicForm_UserInformation_UserInformation_Edit : System.Web.UI.Page
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

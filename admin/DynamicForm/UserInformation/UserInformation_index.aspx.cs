using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DynamicForm_UserInformation_UserInformation_index : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string HtmlHidden(string TableName)
    {
        return KY.ERPOffice.BLL.HtmlWebForm_BLL.HtmlHidden(TableName);
    }
}

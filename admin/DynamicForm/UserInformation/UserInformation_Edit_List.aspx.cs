using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
public partial class DynamicForm_UserInformation_UserInformation_Edit_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string Html(string TableName)
    {
        string HtmlText = KY.ERPOffice.BLL.HtmlWebForm_BLL.HtmlListText(TableName);
        return HtmlText;
    }
   
    
}

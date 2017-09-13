 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using KY.ERPOffice.BLL;

 public partial class WebAspx_UserInformation_UserInformationDynamicForm_EditList : System.Web.UI.Page
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


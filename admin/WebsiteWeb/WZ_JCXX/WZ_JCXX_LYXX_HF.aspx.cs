using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WZ_JCXX_WZ_JCXX_LYXX_HF : System.Web.UI.Page
{
    public string UserName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = KY.ERPOffice.Common.SessionGetSet.getUserName();
    }
}

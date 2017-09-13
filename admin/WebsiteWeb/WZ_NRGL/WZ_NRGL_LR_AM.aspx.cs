using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;
using System.Collections.Specialized;
using System.Collections;
using System.Data;

public partial class WZ_NRGL_WZ_NRGL_LR_AM : System.Web.UI.Page
{
    public string UserName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = KY.ERPOffice.Common.SessionGetSet.getUserName();
    }
}

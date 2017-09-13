using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_Cp_product_FuJian_Data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpPostedFile uploadFile = Request.Files["Fdata"];
        string json = KY.ERPOffice.Common.pub_BLL.fileUpload_MinJson(uploadFile);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(json);
    }
}

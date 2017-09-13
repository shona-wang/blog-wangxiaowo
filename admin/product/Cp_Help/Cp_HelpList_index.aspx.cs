using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class product_Cp_Help_Cp_HelpList_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string Cp_List()
    {
        DataTable Ds = new DataTable();
        string Html = "";
        Ds = KY.ERPOffice.Common.pub_BLL.GetDataTable("select * from  dbo.cp_Help order by CJSJ desc");
        int count = Ds.Rows.Count;
        if (count > 0)
        {
            for (int i = 0; i < count; i++)
            {
                Html += "<tr>";
                Html += "  <td style='width:20%'><img src='../../UploadFiles/" + Ds.Rows[i]["ImageMC"].ToString() + "' alt='点击'/></td>";
                Html += "  <td style='width:80%'><a href='Help_xxxx.htm?DJBH=" + Ds.Rows[i]["DJBH"].ToString() + "' style='font-size:large; font-weight:bold'>" + Ds.Rows[i]["BT"].ToString() + "</a></td>";
                Html += "</tr>";
            }
        }
        return Html;
    }
}

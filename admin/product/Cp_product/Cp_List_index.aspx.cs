using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class product_Cp_product_Cp_List_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string Cp_List()
    {
        DataTable Ds = new DataTable();
        string Html = "";
        Ds = KY.ERPOffice.Common.pub_BLL.GetDataTable("select * from  dbo.cp_product order by CJSJ desc");
        int count = Ds.Rows.Count;
        if (count > 0)
        {
            for (int i = 0; i < count; i++)
            { 
              Html+="<tr>";
              Html += "  <td style='width:20%'><img src='../../UploadFiles/" + Ds.Rows[i]["ImageMC"].ToString() + "' width='100%' alt='点击'/></td>";
              Html += "  <td style='width:80%'><a href='Cp_xxxx.htm?DJBH=" + Ds.Rows[i]["DJBH"].ToString() + "' style='font-size:18; font-weight:bold'>" + Ds.Rows[i]["CPBT"].ToString()+ "</a></td>";
              Html+="</tr>";
            }
        }
        return Html;
    }
}

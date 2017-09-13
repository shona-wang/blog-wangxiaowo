using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
public partial class Flows_FLowLook : System.Web.UI.Page
{
    public string LookText = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string djbh =Request.QueryString["DJBH"];
        FlowText(djbh);
    }
    private void FlowText(string DJBH)
    {
        DataTable Ds = KY.ERPOffice.BLL.Flows_BLL.Get_FlowsLookDS(DJBH);
        int count = Ds.Rows.Count;
        StringBuilder Str = new StringBuilder();
        if (count > 0)
        {
            string ZT = "";
            for (int i = 0; i < count; i++)
            {
                if (i > 0)
                {
                    Str.AppendLine(" <div id=\"n_arrow1\"><img src=\"../Images/FlowLook/jt.png\" /></div>");

                    Str.AppendLine(" <div id=\"n_bmcl\">");
                    Str.AppendLine("  <div class=\"n_bmcl_title\">");
                    Str.AppendLine("    <div class=\"n_bmcl_text\">" + Ds.Rows[i]["textname"].ToString() + "</div>  ");
                    Str.AppendLine("  </div>");
                    ZT = Ds.Rows[i]["ZT"].ToString();
                    string Object_dm = Ds.Rows[i]["Object_dm"].ToString();
                    DataTable DsYj = KY.ERPOffice.BLL.Flows_BLL.Get_FlowsLook_Table46(Object_dm,DJBH);
                    int dsyjcount = DsYj.Rows.Count;
                    if (dsyjcount > 0)
                    {
                        Str.AppendLine(" <table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"x_bmch_t\">");
                        Str.AppendLine("  <tr>");
                        Str.AppendLine("    <td width=\"26%\" align=\"center\" valign=\"middle\" class=\"x_bt\">处理人员</td>");
                        Str.AppendLine("    <td width=\"37%\" align=\"center\" class=\"x_bt\">处理意见</td>");
                        Str.AppendLine("    <td width=\"18%\" align=\"center\" class=\"x_bt\">处理结果</td>");
                        Str.AppendLine("    <td width=\"19%\" align=\"center\" class=\"x_bt\">处理时间</td>");
                        Str.AppendLine("  </tr>");
                        for (int j = 0; j < dsyjcount; j++)
                        {
                            string cssmc = "";
                            if (DsYj.Rows[j]["yesornofinish"].ToString() == "9")
                            {
                                cssmc = "x_btnr";
                            }
                            else
                            {
                                cssmc = "x_btnrg";
                            }
                            Str.AppendLine("  <tr >");
                            Str.AppendLine("    <td align=\"center\" class=\"" + cssmc + "\">" + DsYj.Rows[j]["xx"].ToString() + "</td>");
                            Str.AppendLine("    <td class=\"" + cssmc + "\">" + DsYj.Rows[j]["processyj"].ToString() + "</td>");
                            Str.AppendLine("    <td align=\"center\" class=\"" + cssmc + "\">" + DsYj.Rows[j]["processjg"].ToString() + "</td>");
                            Str.AppendLine("    <td align=\"center\" class=\"" + cssmc + "\">" + DsYj.Rows[j]["finishtime"].ToString() + "</td>");
                            Str.AppendLine("  </tr>");
                        }
                        Str.AppendLine(" </table> ");
                    }
                    Str.AppendLine("</div>");
                }
            }

            string ImgUrl = "";
            if (ZT == "table80")
            {
                ImgUrl = "../Images/FlowLook/jxz.png";
            }
            else
            {
                ImgUrl = "../Images/FlowLook/js.png";
            }
            Str.AppendLine("<div id=\"n_arrow\"> <img src=\"../Images/FlowLook/jt.png\" /></div>");
            Str.AppendLine("   <div id=\"n_end\">");
            Str.AppendLine("      <div class=\"n_endbutton\"><img src=\"" + ImgUrl + "\"/></div>");
            Str.AppendLine("     <div class=\"n_endtext\"></div>");
            Str.AppendLine("  </div>");
            Str.AppendLine("</div>");
        }
        LookText = Str.ToString();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
public partial class Flows_TaskulousWeiXin_index : System.Web.UI.Page
{
    public string _HtmlText = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _HtmlText = HtmlText("wangnannan2013");//Request.QueryString["WeiXinCode"].ToString()
        }
    }
    private string HtmlText(string WeiXinCode)
    {
        string Html = "";
        StringBuilder Str = new StringBuilder();
        Str.AppendLine(" select convert(varchar(10),table80.applytime,120) as APPLYTIME,table80.APPLYMAN,rydj.XX,table81.IDBH,table81.APPLYID,");
        Str.AppendLine(" table81.TITLE,table81.BILLCODE,table81.PROCESSOR,");
        Str.AppendLine(" table81.ACCOUNTNUM,table81.OBJECT_DM,table81.TEXTNAME,");
        Str.AppendLine(" table81.STEP,table81.YESORNOFINISH, case when  table20.table1<>'' then table20.table1 else table06.FlowMemu end  as URL,table20.ALLOW_JUMP ");//Table20.table1 As Url
        Str.AppendLine(" from table81 ");
        Str.AppendLine(" Left outer join table80 on(table81.applyid=table80.applyid And table81.AccountNum=table80.AccountNum) ");
        Str.AppendLine(" Left outer join rydj on(table80.applyman=rydj.yhm And table80.AccountNum=rydj.AccountNum) ");
        Str.AppendLine(" Left outer join table06 on(table80.node_id=table06.node_id And table80.AccountNum=table06.AccountNum)");
        Str.AppendLine(" Left outer join Table20 on (table81.object_dm=Table20.object_dm And table81.AccountNum=Table20.AccountNum) ");
        Str.AppendLine(" where table81.yesornofinish='0'  ");
        Str.AppendLine(" and  table81.processor in (Select yhm From Rydj Where WEIXINCODE='"+WeiXinCode+"') And  table81.AccountNum='009' order by applytime desc");
        DataTable ds = KY.ERPOffice.Common.pub_BLL.GetDataTable(Str.ToString());
        int count = ds.Rows.Count;
        if (count > 0)
        {
            for (int i = 0; i < count; i++)
            {
                Html+="<tr>";
                Html += "  <td style=\" width:60%\">" + ds.Rows[i]["TITLE"].ToString() + "</td>";
                Html += "  <td style=\" width:20%\">" + ds.Rows[i]["XX"].ToString() + "</td>";
                Html += "  <td style=\" width:20%\">" + ds.Rows[i]["APPLYTIME"].ToString() + "</td>";
                Html += "</tr>";
            }
        }
        else
        { 
           Html+="<tr>";
           Html+="<td style=\"width:100%\">您没有待办事务</td>";
           Html+="</tr>";
        }
        return Html;
    }
}

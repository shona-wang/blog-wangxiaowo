using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Reflection;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;
public partial class Flows_Flows_Data : System.Web.UI.Page
{
    String NameText = "", MinDeacription = "";//操作步骤名称 备注
    #region 公共函数
    protected void Page_Load(object sender, EventArgs e)
    {
        String MInNameText = Request["method"];
        Type type = this.GetType();
        MethodInfo method = type.GetMethod(MInNameText);
        if (method == null) throw new Exception("出错了");

        try
        {
            if (MyPublicMin.isHaveLoginSession())
            {
                method.Invoke(this, null);
            }
            else
            {
                MyPublicMin.Redirect();
            }
        }
        catch (Exception Ex)
        {
            KY_Exception.Insert_KYException(Ex);
        }
        finally
        {
            if (NameText != "")
            {
                Loginfo(NameText, MInNameText, MinDeacription);
            }
        }
    }
    /// <summary>
    /// 常用操作
    /// </summary>
    /// <param name="methodName"></param>
    protected void BeforeInvoke(string _NameText, string _MInName)
    {

    }
    /// <summary>
    /// 日志管理
    /// </summary>
    /// <param name="NameText">操作功能</param>
    /// <param name="MInName">功能调用函数名称</param>
    /// <param name="MinDeacription">备注</param>
    protected void Loginfo(string _NameText, string _MInName, string _MinDeacription)
    {
        if (MyPublicMin.isHaveLoginSession())
        {
            Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }
    #endregion
    public void Get_Taskulous()
    {
        MyPublicMin.WriteStr(Flows_BLL.Get_Taskulous());
    }
    public void Get_FlowsLook()
    {
        String DJBH = Request["DJBH"];
        MyPublicMin.WriteStr(Flows_BLL.Get_FlowsLook(DJBH));
    }
    public void Get_ProcessJG()
    {
        String IDBH = Request["IDBH"];
        MyPublicMin.WriteStr(Flows_BLL.ProcessJG(IDBH));
    }
    public void Get_Object_dm()
    {
        String Object_dm = Request["Object_dm"];
        MyPublicMin.WriteStr(Flows_BLL.Get_Object_dm(Object_dm));
    }
    public void Get_SelTable26()
    {
        String Object_dm = Request["Object_dm"];
        MyPublicMin.WriteStr(Flows_BLL.Get_SelTable26(Object_dm));
    }
    public void Get_SelTable06()
    {
        MyPublicMin.WriteStr(Flows_BLL.Get_SelTable06());
    }
    public void FlowSave()
    { 
        string data = Request["data_form"];//获取RWBH数组
        int i = KY_FlowDemo_BLL.FlowSave(data);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void Select_Psyj()
    {
        string DJBH = Request["DJBH"];
        string json = KY.ERPOffice.BLL.Flows_BLL.Select_PSYJ(DJBH);
        MyPublicMin.WriteStr(json);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Reflection;
using System.Collections;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;

public partial class WindowsAspx_ParameterSetting_ParameterSetting_Data : System.Web.UI.Page
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

            method.Invoke(this, null);
            //if (MyPublicMin.isHaveLoginSession())
            //{
            //    method.Invoke(this, null);
            //}
            //else
            //{
            //    MyPublicMin.Redirect();
            //}
        }
        catch (Exception Ex)
        {
            KY_Exception.Insert_KYException(Ex.ToString());
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
    public void get_Parameter()
    { 
        String LXMC=Request.QueryString["LXMC"].ToString();
        MyPublicMin.WriteStr(ParameterSetting_BLL.Select_JsonParameterSetting(" And LXMC='"+LXMC+"' "));
    }
    public void SaveParameter()
    {
        NameValueCollection KY_ParameterSetting_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.ParameterSetting_BLL.KY_ParameterSetting_Insert(KY_ParameterSetting_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    #endregion
}

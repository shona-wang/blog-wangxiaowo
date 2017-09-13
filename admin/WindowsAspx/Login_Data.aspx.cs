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

public partial class WindowsAspx_Login_Data : System.Web.UI.Page
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
        }
        catch (Exception Ex)
        {
            KY_Exception.Insert_KYException(Ex);
        }
        finally
        {
            Loginfo(NameText, MInNameText, MinDeacription);
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
            //Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }
    #endregion
    #region  登陆函数
    /// <summary>
    /// 登录
    /// </summary>
    public void RepeatLogin()
    {
        String data=Request.Form["data"];
        string Message = Rydj_BLL.UserLogin(data);
        MyPublicMin.WriteStr(Message);
        //if (!Code.Equals(SessionGetSet.GetSession(MyStringText.VAL_CODE)))
        //{
        //    Session.Clear();
        //    Json = MyMessage.Message_OK(MyStringText._Code, MyStringText._Message_ZT1);
        //    MyPublicMin.WriteStr(Json);
        //}
        //else
        //{
        //    Json = Rydj_BLL._Select_RYDJ_Login(yhm, pwd);
        //    MyPublicMin.WriteStr(Json);
        //}
    }
    public void UserLogin_PayByCard()
    {
        String data = Request.Form["data"];
        string Message = Rydj_BLL.UserLogin_PayByCard(data);
        MyPublicMin.WriteStr(Message);
    }
    #endregion
}

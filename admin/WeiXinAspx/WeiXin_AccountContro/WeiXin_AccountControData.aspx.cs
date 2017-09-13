 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY.ERPOffice.BLL;

 public partial class WeiXinAspx_WeiXin_AccountContro_WeiXin_AccountControData : System.Web.UI.Page
 {
    String NameText = "", MinDeacription = "";//操作步骤名称 备注
    protected void Page_Load(object sender, EventArgs e)
    {
        String MInNameText = Request["method"];
        Type type = this.GetType();
        MethodInfo method = type.GetMethod(MInNameText);
        if (method == null) throw new Exception("");
        try
        {
            method.Invoke(this, null);
            //if (KY.ERPOffice.Common.MyPublicMin.isHaveLoginSession())
            //{
            //    method.Invoke(this, null);
            //}
            //else
            //{
            //    KY.ERPOffice.Common.MyPublicMin.Redirect();
            //}
         }
         catch (Exception Ex)
         {
             KY.ERPOffice.Common.KY_Exception.Insert_KYException(Ex.ToString());
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
        if (KY.ERPOffice.Common.MyPublicMin.isHaveLoginSession())
        {
            KY.ERPOffice.BLL.Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }
    ///<summary>
    ///WeiXin_AccountContro保存函数
    ///<summary>
    public void WeiXin_AccountContro_Insert()
    {
        NameValueCollection WeiXin_AccountContro_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_Insert(WeiXin_AccountContro_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///WeiXin_AccountContro动态保存函数
    ///<summary>
    public void WeiXin_AccountControDynamicForm_Insert()
    {
        NameValueCollection WeiXin_AccountContro_nameValueCollection = Request.Form;
       int i = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountControDynamicForm_Insert(WeiXin_AccountContro_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
///<summary>
///UserInformation批量保存保存函数
///<summary>
public void WeiXin_AccountContro_ListInsert()
{
    NameValueCollection WeiXin_AccountContro_nameValueCollection = Request.Form;
    int i = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_ListInsert(WeiXin_AccountContro_nameValueCollection);
    KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
}
    ///<summary>
    ///WeiXin_AccountContro批量删除函数
    ///<summary>
    public void WeiXin_AccountContro_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///WeiXin_AccountContro批量删除函数
    ///<summary>
   public void WeiXin_AccountContro_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       int i = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///WeiXin_AccountContro条件查询返回json
    ///<summary>
   public void WeiXin_AccountContro_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String WeiXin_AccountContro_Json = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_Json_SelectWhere(" And DJKEY='"+DJBH+"' ");//此处填写条件
       KY.ERPOffice.Common.MyPublicMin.WriteStr(WeiXin_AccountContro_Json);
   }
    ///<summary>
    ///WeiXin_AccountContro条件查询返回json
    ///<summary>
   public void WeiXin_AccountContro_Json_getSelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String WeiXin_AccountContro_Json = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_Json_getSelectWhere("此处填写条件");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(WeiXin_AccountContro_Json);
   }
    ///<summary>
    ///WeiXin_AccountContro条件查询返回条数
    ///<summary>
   public void WeiXin_AccountContro_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object WeiXin_AccountContro_Json = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(WeiXin_AccountContro_Json.ToString());
   }
    ///<summary>
    ///WeiXin_AccountContro条件查询返回某个字段的最大值
    ///<summary>
   public void WeiXin_AccountContro_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object WeiXin_AccountContro_Json = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(WeiXin_AccountContro_Json.ToString());
   }
    ///<summary>
    ///WeiXin_AccountContro分页查询
    ///<summary>
    public void WeiXin_AccountContro_PageJson_SelectWhere()
    {
        NameValueCollection WeiXin_AccountContro_nameValueCollection = Request.Form;
        object WeiXin_AccountContro_Json = KY.ERPOffice.BLL.WeiXin_AccountContro_BLL.WeiXin_AccountContro_PageJson_SelectWhere(WeiXin_AccountContro_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(WeiXin_AccountContro_Json.ToString());
    }
 }


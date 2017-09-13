 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY.ERPOffice.BLL;

 public partial class DynamicForm_UserInformation_UserInformationData : System.Web.UI.Page
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
    ///UserInformation保存函数
    ///<summary>
    public void UserInformation_Insert()
    {
        NameValueCollection UserInformation_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_Insert(UserInformation_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    /////<summary>
    /////UserInformation批量保存保存函数
    /////<summary>
    //public void UserInformation_ListInsert()
    //{
    //    NameValueCollection UserInformation_nameValueCollection = Request.Form;
    //    int i = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_ListInsert(UserInformation_nameValueCollection);
    //    KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    //}
    ///<summary>
    ///UserInformation批量保存保存函数
    ///<summary>
    public void UserInformation_ListInsert()
    {
        NameValueCollection UserInformation_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_ListInsert(UserInformation_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///UserInformation批量删除函数
    ///<summary>
    public void UserInformation_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    
    ///<summary>
    ///UserInformation批量删除函数
    ///<summary>
   public void UserInformation_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       int i = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///UserInformation条件查询返回json
    ///<summary>
   public void UserInformation_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String UserInformation_Json = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_Json_SelectWhere(" And DJKEY='" + DJBH + "'");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(UserInformation_Json);
   }
    ///<summary>
    ///UserInformation条件查询返回json
    ///<summary>
   public void UserInformation_Json_getSelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String UserInformation_Json = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_Json_getSelectWhere("此处填写条件");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(UserInformation_Json);
   }
    ///<summary>
    ///UserInformation条件查询返回条数
    ///<summary>
   public void UserInformation_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object UserInformation_Json = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(UserInformation_Json.ToString());
   }
    ///<summary>
    ///UserInformation条件查询返回某个字段的最大值
    ///<summary>
   public void UserInformation_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object UserInformation_Json = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(UserInformation_Json.ToString());
   }
    ///<summary>
    ///UserInformation分页查询
    ///<summary>
    public void UserInformation_PageJson_SelectWhere()
    {
        NameValueCollection UserInformation_nameValueCollection = Request.Form;
        object UserInformation_Json = KY.ERPOffice.BLL.UserInformation_BLL.UserInformation_PageJson_SelectWhere(UserInformation_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(UserInformation_Json.ToString());
    }
 }


 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY_CustomersDataBase.BLL;

 public partial class CustomersAspx_KH_Customers_KH_CustomersData : System.Web.UI.Page
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
    ///KH_Customers保存函数
    ///<summary>
    public void KH_Customers_Insert()
    {
        NameValueCollection KH_Customers_nameValueCollection = Request.Form;
        int i = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_Insert(KH_Customers_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KH_Customers批量删除函数
    ///<summary>
    public void KH_Customers_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KH_Customers批量删除函数
    ///<summary>
   public void KH_Customers_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       int i = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///KH_Customers条件查询返回json
    ///<summary>
   public void KH_Customers_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String KH_Customers_Json = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_Json_SelectWhere(" And Cust_ID='"+DJBH+"'");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KH_Customers_Json);
   }
    ///<summary>
    ///KH_Customers条件查询返回条数
    ///<summary>
   public void KH_Customers_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object KH_Customers_Json = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KH_Customers_Json.ToString());
   }
    ///<summary>
    ///KH_Customers条件查询返回某个字段的最大值
    ///<summary>
   public void KH_Customers_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object KH_Customers_Json = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KH_Customers_Json.ToString());
   }
    ///<summary>
    ///KH_Customers分页查询
    ///<summary>
    public void KH_Customers_PageJson_SelectWhere()
    {
        NameValueCollection KH_Customers_nameValueCollection = Request.Form;
        object KH_Customers_Json = KY_CustomersDataBase.BLL.KH_Customers_BLL.KH_Customers_PageJson_SelectWhere(KH_Customers_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(KH_Customers_Json.ToString());
    }
 }


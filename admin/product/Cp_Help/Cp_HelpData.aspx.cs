 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY_Product_DataBase.BLL;

 public partial class product_Cp_Help_Cp_HelpData : System.Web.UI.Page
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
    ///Cp_Help保存函数
    ///<summary>
    public void Cp_Help_Insert()
    {
        NameValueCollection Cp_Help_nameValueCollection = Request.Form;
        int i = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_Insert(Cp_Help_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///Cp_Help批量删除函数
    ///<summary>
    public void Cp_Help_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///Cp_Help批量删除函数
    ///<summary>
   public void Cp_Help_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       String DJBHS = KY.ERPOffice.Common.MyPublicMin.FunctionStr(DJBH);
       int i = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///Cp_Help条件查询返回json
    ///<summary>
   public void Cp_Help_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String Cp_Help_Json = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_Json_SelectWhere(" And DJBH='"+DJBH+"'");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_Help_Json);
   }
    ///<summary>
    ///Cp_Help条件查询返回条数
    ///<summary>
   public void Cp_Help_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object Cp_Help_Json = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_Help_Json.ToString());
   }
    ///<summary>
    ///Cp_Help条件查询返回某个字段的最大值
    ///<summary>
   public void Cp_Help_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object Cp_Help_Json = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_Help_Json.ToString());
   }
    ///<summary>
    ///Cp_Help分页查询
    ///<summary>
    public void Cp_Help_PageJson_SelectWhere()
    {
        NameValueCollection Cp_Help_nameValueCollection = Request.Form;
        object Cp_Help_Json = KY_Product_DataBase.BLL.Cp_Help_BLL.Cp_Help_PageJson_SelectWhere(Cp_Help_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_Help_Json.ToString());
    }
 }


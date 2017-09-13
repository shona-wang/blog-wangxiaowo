 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY_Product_DataBase.BLL;

 public partial class product_Cp_product_Cp_productData : System.Web.UI.Page
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
    ///Cp_product保存函数
    ///<summary>
    public void Cp_product_Insert()
    {
        NameValueCollection Cp_product_nameValueCollection = Request.Form;
        int i = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_Insert(Cp_product_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///Cp_product批量删除函数
    ///<summary>
    public void Cp_product_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///Cp_product批量删除函数
    ///<summary>
   public void Cp_product_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       
       int i = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///Cp_product条件查询返回json
    ///<summary>
   public void Cp_product_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String Cp_product_Json = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_Json_SelectWhere(" And DJBH='"+DJBH+"'");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_product_Json);
   }
    ///<summary>
    ///Cp_product条件查询返回条数
    ///<summary>
   public void Cp_product_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object Cp_product_Json = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_product_Json.ToString());
   }
    ///<summary>
    ///Cp_product条件查询返回某个字段的最大值
    ///<summary>
   public void Cp_product_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object Cp_product_Json = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_product_Json.ToString());
   }
    ///<summary>
    ///Cp_product分页查询
    ///<summary>
    public void Cp_product_PageJson_SelectWhere()
    {
        NameValueCollection Cp_product_nameValueCollection = Request.Form;
        object Cp_product_Json = KY_Product_DataBase.BLL.Cp_product_BLL.Cp_product_PageJson_SelectWhere(Cp_product_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Cp_product_Json.ToString());
    }
 }


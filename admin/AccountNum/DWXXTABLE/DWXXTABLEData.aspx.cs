 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY.ERPOffice.BLL;

 public partial class AccountNum_DWXXTABLE_DWXXTABLEData : System.Web.UI.Page
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
    ///DWXXTABLE保存函数
    ///<summary>
    public void DWXXTABLE_Insert()
    {
        NameValueCollection DWXXTABLE_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_Insert(DWXXTABLE_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///DWXXTABLE批量删除函数
    ///<summary>
    public void DWXXTABLE_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///DWXXTABLE批量删除函数
    ///<summary>
   public void DWXXTABLE_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       int i = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///DWXXTABLE条件查询返回json
    ///<summary>
   public void DWXXTABLE_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String DWXXTABLE_Json = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_Json_SelectWhere(" And DJKEY='"+DJBH+"' ");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(DWXXTABLE_Json);
   }
   /// <summary>
   ///DWXXTABLE条件查询返回下拉列表json
   /// </summary>
   public void DWXXTABLE_Json_getSelectWhere()
   {
       //String DJBH = Request.QueryString["DJBH"];
       String DWXXTABLE_Json = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_Json_getSelectWhere(" And BS='0' ");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(DWXXTABLE_Json);
   }
    ///<summary>
    ///DWXXTABLE条件查询返回条数
    ///<summary>
   public void DWXXTABLE_SelectCount()
   {
       String AccountNum = Request.QueryString["AccountNum"];
       object DWXXTABLE_Json = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_SelectCount(" And AccountNum='" + AccountNum + "' ");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(DWXXTABLE_Json.ToString());
   }
    ///<summary>
    ///DWXXTABLE条件查询返回某个字段的最大值
    ///<summary>
   public void DWXXTABLE_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object DWXXTABLE_Json = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(DWXXTABLE_Json.ToString());
   }
    ///<summary>
    ///DWXXTABLE分页查询
    ///<summary>
    public void DWXXTABLE_PageJson_SelectWhere()
    {
        NameValueCollection DWXXTABLE_nameValueCollection = Request.Form;
        object DWXXTABLE_Json = KY.ERPOffice.BLL.DWXXTABLE_BLL.DWXXTABLE_PageJson_SelectWhere(DWXXTABLE_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(DWXXTABLE_Json.ToString());
    }
 }


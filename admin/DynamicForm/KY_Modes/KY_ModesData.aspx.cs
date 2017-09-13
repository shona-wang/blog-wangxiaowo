 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY.ERPOffice.BLL;

 public partial class DynamicForm_KY_Modes_KY_ModesData : System.Web.UI.Page
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
    ///KY_ModesType保存函数
    ///<summary>
    public void KY_ModesType_Insert()
    {
        NameValueCollection KY_ModesType_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.KY_ModesType_BLL.KY_ModesType_Insert(KY_ModesType_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KY_Modes保存函数
    ///<summary>
    public void KY_Modes_Insert()
    {
        NameValueCollection KY_Modes_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Insert(KY_Modes_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KY_Modes批量删除函数
    ///<summary>
    public void KY_Modes_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KY_Modes批量删除函数
    ///<summary>
   public void KY_Modes_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       String FL = Request.QueryString["DJBH"];
       int i = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Deletes(DJBH,FL);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///KY_Modes条件查询返回json
    ///<summary>
   public void KY_Modes_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Json_SelectWhere(" And DJKEY='"+DJBH+"' And AccountNum='"+KY.ERPOffice.Common.SessionGetSet.getAccountNum()+"'");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json);
   }
    ///<summary>
    ///KY_Modes条件查询返回json  查询列
    ///<summary>
   public void KY_Modes_Json_getSelectWhere()
   {
       String TableName = Request.QueryString["TableName"];
       String AccountNum = KY.ERPOffice.Common.SessionGetSet.getAccountNum();
       String KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Json_getSelectWhere(" And FL='"+TableName+"' And LBSFXS='false' And AccountNum='" + AccountNum + "' order by XSSX ");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json);
   }

    ///<summary>
    ///KY_Modes条件查询返回条数
    ///<summary>
   public void KY_Modes_SelectCount()
   {
       String KJID = Request.Form["KJID"];
       String DJKEY = Request.Form["DJKEY"];
       String FL=Request.Form["FL"];
       string SQLWhere = " And KJID='"+KJID+"' And FL='"+FL+"' And AccountNum='"+KY.ERPOffice.Common.SessionGetSet.getAccountNum()+"'";
       if (DJKEY != "")
       {
           SQLWhere = " And KJID='" + KJID + "' And FL='" + FL + "' And DJKEY<>'" + DJKEY + "' And AccountNum='" + KY.ERPOffice.Common.SessionGetSet.getAccountNum() + "'";
       }
       object KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_SelectCount(SQLWhere);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json.ToString());
   }

    ///<summary>
    ///KY_Modes条件查询返回某个字段的最大值
    ///<summary>
   public void KY_Modes_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json.ToString());
   }
    ///<summary>
    ///KY_Modes分页查询
    ///<summary>
    public void KY_Modes_PageJson_SelectWhere()
    {
        NameValueCollection KY_Modes_nameValueCollection = Request.Form;
        object KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_PageJson_SelectWhere(KY_Modes_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json.ToString());
    }
    public void UpModel_Zb_XuHao()
    {
        String Json = Request["data"];
        int i = KY.ERPOffice.BLL.KY_Modes_BLL.UpModel_Zb_XuHao(Json);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    public void KY_ModesSJY()
    {
        String TableName = Request.Form["TableName"];
        String DJKEY = Request.Form["DJKEY"];
        String KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_Modes_Table_SJYSelectWhere(" And DJKEY='"+DJKEY+"' And FL='"+TableName+"' ");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json);
    }
    public void KY_ModelTypeAll()
    {
        String AccountNum = KY.ERPOffice.Common.SessionGetSet.getAccountNum();
        String KY_Modes_Json = KY.ERPOffice.BLL.KY_Modes_BLL.KY_ModesType_Json_getSelectWhere(" And AccountNum='"+AccountNum+"' order by xh ");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_Modes_Json);
    }
 }


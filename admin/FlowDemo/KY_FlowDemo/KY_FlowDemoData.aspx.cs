 using System;
 using System.Collections.Generic;
 using System.Linq;
 using System.Web;
 using System.Web.UI;
 using System.Web.UI.WebControls;
 using System.Collections.Specialized;
 using System.Reflection;
 using KY.ERPOffice.BLL;

 public partial class FlowDemo_KY_FlowDemo_KY_FlowDemoData : System.Web.UI.Page
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
    ///KY_FlowDemo保存函数
    ///<summary>
    public void KY_FlowDemo_Insert()
    {
        NameValueCollection KY_FlowDemo_nameValueCollection = Request.Form;
        int i = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_Insert(KY_FlowDemo_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KY_FlowDemo批量删除函数
    ///<summary>
    public void KY_FlowDemo_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        int i = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_Delete(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    ///<summary>
    ///KY_FlowDemo批量删除函数
    ///<summary>
   public void KY_FlowDemo_Deletes()
   {
       String DJBH = Request.QueryString["DJBH"];
       int i = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_Deletes(DJBH);
       KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
   }
    ///<summary>
    ///KY_FlowDemo条件查询返回json
    ///<summary>
   public void KY_FlowDemo_Json_SelectWhere()
   {
       String DJBH = Request.QueryString["DJBH"];
       String KY_FlowDemo_Json = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_Json_SelectWhere(" And DJBH='"+DJBH+"' ");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_FlowDemo_Json);
   }
    ///<summary>
    ///KY_FlowDemo条件查询返回条数
    ///<summary>
   public void KY_FlowDemo_SelectCount()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object KY_FlowDemo_Json = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_SelectCount("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_FlowDemo_Json.ToString());
   }
    ///<summary>
    ///KY_FlowDemo条件查询返回某个字段的最大值
    ///<summary>
   public void KY_FlowDemo_SelectMax()
   {
      // String DJBH = Request.QueryString["DJBH"];
       object KY_FlowDemo_Json = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_SelectMax("");
       KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_FlowDemo_Json.ToString());
   }
    ///<summary>
    ///KY_FlowDemo分页查询
    ///<summary>
    public void KY_FlowDemo_PageJson_SelectWhere()
    {
        NameValueCollection KY_FlowDemo_nameValueCollection = Request.Form;
        object KY_FlowDemo_Json = KY.ERPOffice.BLL.KY_FlowDemo_BLL.KY_FlowDemo_PageJson_SelectWhere(KY_FlowDemo_nameValueCollection);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(KY_FlowDemo_Json.ToString());
    }
    public void FlowSave()
    {
        string data = Request["data"];//获取RWBH数组
        int i = KY_FlowDemo_BLL.FlowSave(data);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
 }


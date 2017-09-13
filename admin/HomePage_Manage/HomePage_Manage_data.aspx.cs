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
using System.Data;


public partial class HomePage_Manage_HomePage_Manage_data : System.Web.UI.Page
{
    #region---Page_Load---
    String NameText = "", MinDeacription = "", YL_SHBS = "", Cy_SHBS = "";//操作步骤名称 备注.
    protected void Page_Load(object sender, EventArgs e)
    {
        String MInNameText = Request["method"];
        Type type = this.GetType();
        MethodInfo method = type.GetMethod(MInNameText);
        if (method == null) throw new Exception("出错了");

        try
        {

            if (MyPublicMin.isHaveLoginSession())
            {
                method.Invoke(this, null);
            }
            else
            {
                MyPublicMin.Redirect();
            }
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
    protected void Loginfo(string _NameText, string _MInName, string _MinDeacription)
    {
        if (MyPublicMin.isHaveLoginSession())
        {
            Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }
    #endregion

    //栏目树检索方法
    public void LMTreeSelect()
    {
        string json = WebsiteCommonData.BLL.Website_Common_BLL.LMTreeSelect();
        MyPublicMin.WriteStr(json);
    }

    //栏目信息查询（分页）
    public void SelectLMWH()
    {
        NameValueCollection _namevaluecollection = Request.Form;
        string json = WebsiteCommonData.BLL.WebSite_LMWH_BLL.Web_LMWH_PageJson_SelectWhere(_namevaluecollection);
        MyPublicMin.WriteStr(json);
    }

    //栏目信息查询（不分页，单条查询）
    public void SearchLMWH()
    {
        string JDDM = Request["JDDM"];
        string json = WebsiteCommonData.BLL.WebSite_LMWH_BLL.Web_LMWH_Json_SelectWhere(" AND JDDM = '" + JDDM + "'");
        MyPublicMin.WriteStr(json);
    }

    //栏目信息保存
    public void InsertLMWH()
    {
        NameValueCollection _namevaluecollection = Request.Form;
        int i = WebsiteCommonData.BLL.WebSite_LMWH_BLL.Web_LMWH_Insert(_namevaluecollection);
        MyPublicMin.WriteStr(i.ToString());
    }


    //栏目信息删除
    public void DeleteLMWH()
    {
        string JDDM = Request["JDDM"];
        //string _JDDM = MyPublicMin.FunctionStr(JDDM);
        int i = WebsiteCommonData.BLL.WebSite_LMWH_BLL.Web_LMWH_Deletes(JDDM);
        MyPublicMin.WriteStr(i.ToString());
    }


    //栏目内容检索（分页）
    public void SelectLMNR()
    {
        NameValueCollection _namevaluecollection = Request.Form;
        string json = WebsiteCommonData.BLL.WebSite_LMNR_BLL.Web_LMNR_PageJson_SelectWhere(_namevaluecollection);
        MyPublicMin.WriteStr(json);
    }

    //栏目内容检索（不分页）
    public void SearchLMNR()
    {
        string NRBH = Request["NRBH"];
        string json = WebsiteCommonData.BLL.WebSite_LMNR_BLL.Web_LMNR_Json_SelectWhere(" AND NRBH = '" + NRBH + "'");
        MyPublicMin.WriteStr(json);
    }


    //栏目内容保存
    public void InsertLMNR()
    {
        NameValueCollection _namevaluecollection = Request.Form;
        int i = WebsiteCommonData.BLL.WebSite_LMNR_BLL.Web_LMNR_Insert(_namevaluecollection);
        MyPublicMin.WriteStr(i.ToString());
    }

    //栏目内容删除
    public void DeleteLMNR()
    {
        string NRBH = Request["NRBH"];
        string NRBHs = KY.ERPOffice.Common.MyPublicMin.FunctionStr(NRBH.ToString());
        try
        {
            DataTable DT = WebsiteCommonData.BLL.WebSite_LMNR_BLL.Web_LMNR_Table_SelectWhere(" AND NRBH IN (" + NRBHs + ")");
            if (DT.Rows.Count > 0)
            {
                foreach (DataRow row in DT.Rows)
                {
                    if (MyPublicMin.IsNull(row["WJM"].ToString(), "") != "")
                    {
                        System.IO.FileInfo myfile = new System.IO.FileInfo(Server.MapPath("../UploadFiles/SYLH/" + row["WJM"].ToString()));
                        if (myfile.Exists)
                        {
                            myfile.Delete();
                        }
                    }
                }
            }
            int i = WebsiteCommonData.BLL.WebSite_LMNR_BLL.Web_LMNR_Deletes(NRBHs);
            MyPublicMin.WriteStr(i.ToString());
        }
        catch (Exception Ex)
        {
            MyPublicMin.WriteStr(Ex.ToString());
        }
    }
}

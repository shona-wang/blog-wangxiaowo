using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;
using System.Collections.Specialized;
using System.Collections;
using System.Data;
using System.IO;

public partial class WZ_DealData_DataProcess : System.Web.UI.Page
{
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

    /// <summary>
    /// 日志管理
    /// </summary>
    /// <param name="_NameText">操作功能</param>
    /// <param name="_MInName">功能调用函数名称</param>
    /// <param name="_MinDeacription">备注</param>
    protected void Loginfo(string _NameText, string _MInName, string _MinDeacription)
    {
        if (MyPublicMin.isHaveLoginSession())
        {
            Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }

    #region 栏目管理
    public void LoadLMTree() //加载网站栏目树
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["myField"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMTree(LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void GetLMInfo() //加载栏目列表
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["LMBH"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.GetLMInfo(_nameValueCollection, LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void OpenLMInfo() //检索单条栏目信息
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["LMBH"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenLMInfo(LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveLMInfo() //保存单条栏目信息
    {
        string data = CL_WZHT.BLL.AppTool.IsNull(Request["data"], "");
        //NameText = "栏目保存：" + data;
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(data);
        //NameText = "栏目Decode：" + rows.Count.ToString();
        string state = CL_WZHT.BLL.AppTool.IsNull(Request["state"], "");
        string lmbh = CL_WZHT.BLL.AppTool.IsNull(Request["lmbh"], "");
        string sfjt = CL_WZHT.BLL.AppTool.IsNull(Request["sfjt"], "");
        string sfdh = CL_WZHT.BLL.AppTool.IsNull(Request["sfdh"], "");
        string sfzt = CL_WZHT.BLL.AppTool.IsNull(Request["sfzt"], "");
        //string sfjszl = CL_WZHT.BLL.AppTool.IsNull(Request["sfjszl"], "");
        foreach (Hashtable row in rows)
        {
            int Json = CL_WZHT.BLL.WZHT_BLL.SaveLMInfo(row, state, lmbh, sfdh, sfjt, sfzt);
            MyPublicMin.WriteStr(Json.ToString());
        }
    }
    public void DelLMInfo() //删除栏目信息
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["LMBH"], "");
        int Json = CL_WZHT.BLL.WZHT_BLL.DelLMInfo(LMBH);
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
    }
    public void FindZLMCount() //检索子栏目数量
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["LMBH"], "");
        int Json = CL_WZHT.BLL.WZHT_BLL.FindZLMCount(LMBH);
        MyPublicMin.WriteStr(Json.ToString());
    }
    #endregion

    #region 网站内容管理
    public void GetDocInfo() //获取新增文章列表
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["LMBH"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.GetDocInfo(_nameValueCollection, LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveDocInfo() //保存文章信息
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string data = Server.UrlDecode(_nameValueCollection["data"].ToString());
        string state = Server.UrlDecode(_nameValueCollection["state"].ToString());
        string content = Server.UrlDecode(Request["content"]);
        string path = Server.UrlDecode(Request["path"]);
        //System.Web.UI.HtmlControls.HtmlTextArea dd = Request.["content"];
        //string content = Request.Form["content"];
        //NameText = "文章保存：" + data;

        //KY.ERPOffice.Common.KY_Exception.Insert_KYException(data+";"+state+";"+content+";"+path);
        int Json = CL_WZHT.BLL.WZHT_BLL.SaveDocInfo(data, state, content, path);
        

        MyPublicMin.WriteStr(Json.ToString());
    }
    public void OpenDocInfo() //打开文章信息
    {
        string xwbh = Server.UrlDecode(Request["XWBH"].ToString());
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenDocInfo(xwbh);
        MyPublicMin.WriteStr(Json);
    }
    public void FindDSDoc() //检索待审文章
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.FindDSDoc(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void DeleteDoc() //删除新闻编号
    {
        string xwbh = Request["XWBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteDoc(xwbh);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void SHDoc() //审核新闻
    {
        string xwbh = Request["XWBH"];
        string bs = Request["BS"]; //1通过-1不通过
        int Json = CL_WZHT.BLL.WZHT_BLL.SHDoc(xwbh, bs);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void FindWTGDoc() //检索未通过文章
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.FindWTGDoc(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void FindYTGDoc() //检索已通过文章
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.FindYTGDoc(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void canelDoc() //撤销文章
    {
        string xwbh = Request["XWBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.canelDoc(xwbh);
        MyPublicMin.WriteStr(Json.ToString());
    }

    public void zdDoc() //置顶文章
    {
        string xwbh = Request["XWBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.zdDoc(xwbh);
        MyPublicMin.WriteStr(Json.ToString());
    }

    public void qxzdDoc() //置顶文章
    {
        string xwbh = Request["XWBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.qxzdDoc(xwbh);
        MyPublicMin.WriteStr(Json.ToString());
    }


    public void LoadLMListTree() //加载栏目树
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMListTree();
        MyPublicMin.WriteStr(Json);
    }

    public void LoadSHLMListTree() //审核加载栏目树
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadSHLMListTree();
        MyPublicMin.WriteStr(Json);
    }







    public void FindDocHZCX() //新闻内容汇总查询
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.FindDocHZCX(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SelectZTCombo() //检索专题填充combo
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.SelectZTCombo();
        MyPublicMin.WriteStr(Json);
    }
    public void SH()//通过
    {
        string BS = Request["BS"];
        //string sql =" update lyb set shbz='1' Where id='" + id.ToString().Trim() + "' ";
        //int Json = KY.ERPOffice.Common.pub_BLL.ExecuteSqlTextWhere(sql);
        //MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));

        NameValueCollection namevaluecollection = Request.Form;
        int i = CL_WZHT.BLL.WZHT_BLL.SH(namevaluecollection,BS);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));

    }






    #endregion

    #region 网站基础管理
    public void ZTLoad() //专题信息加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.ZTLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveZT() //保存专题
    {
        string Json = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateZT(row);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveZT(row);
            }
        }
    }
    public void DeleteZT() //删除专题
    {
        string ID = Request["ID"];
        int Json= CL_WZHT.BLL.WZHT_BLL.DeleteZT(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void XFLXLoad() //信访类型加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.XFLXLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void JSXFLX() //检索信访类别
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.JSXFLX();
        MyPublicMin.WriteStr(Json);
    }
    public void SaveXFLX() //保存信访类型
    {
        string Json = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateXFLX(row);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveXFLX(row);
            }
        }
    }
    public void DeleteXFLX() //删除信访类型
    {
        string ID = Request["ID"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteXFLX(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void LYXXLoad() //留言板、信箱信息加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.LYXXLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void DeleteLYXX() //删除留言信息
    {
        string ID = Request["ID"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteLYXX(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void OpenLYXXInfo() //查看留言板、信箱信息
    {
        string idh = Request["IDH"];
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenLYXXInfo(idh);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveLYXXHF() //保存留言回复
    {
        string data = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(data);
        foreach (Hashtable row in rows)
        {
            string IDH = CL_WZHT.BLL.AppTool.IsNull(row["ID"], "");
            String hfbt = CL_WZHT.BLL.AppTool.IsNull(row["HFBT"], "");
            String hfnr = CL_WZHT.BLL.AppTool.IsNull(row["HFNR"], "");
            int Json = CL_WZHT.DAL.WZHT_DAL.SaveLYXXHF(IDH, hfbt, hfnr);
            MyPublicMin.WriteStr(Json.ToString());
        }
    }
    public void LJLBLoad() //友情链接类别加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.LJLBLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveLJLB() //保存链接类别
    {
        string Json = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateLJLB(row);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveLJLB(row);
            }
        }
    }
    public void DeleteLJLB() //删除链接类别
    {
        string ID = Request["FLBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteLJLB(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void YQLJLoad() //友情链接加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.YQLJLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void DelYQLJ() //删除友情链接
    {
        string IDH = Request["IDH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DelYQLJ(IDH);
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
    }
    public void SelectYQLJCombo() //检索友情链接列表填充combo
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.SelectYQLJCombo();
        MyPublicMin.WriteStr(Json);
    }
    public void OpenYQLJ() //编辑友情链接
    {
        string IDH = Request["IDH"];
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenYQLJ(IDH);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveYQLJ() //保存友情链接
    {
        int i = 0;
        string Json = Request["Json"];
        string state = Request["state"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            if (state == "edit")
            {
                //新增
                i = CL_WZHT.BLL.WZHT_BLL.UpdateYQLJ(row);
            }
            if (state == "new")
            {
                //更新
                i = CL_WZHT.BLL.WZHT_BLL.SaveYQLJ(row);
            }
        }
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    public void TPLoad() //投票加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.TPLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void DelTP() //删除投票记录
    {
        string IDH = Request["IDH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DelTP(IDH);
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
    }
    public void OpenTP() //编辑投票记录
    {
        string IDH = Request["IDH"];
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenTP(IDH);
        MyPublicMin.WriteStr(Json);
    }
    public void TPMXLoad() //投票项目加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string IDH = Request["IDH"];
        string Json = CL_WZHT.BLL.WZHT_BLL.TPMXLoad(_nameValueCollection,IDH);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveTPZB() //保存投票主表
    {
        int i = 0;
        string Json = Request["Json"];
        string state = Request["state"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            if (state == "edit")
            {
                //新增
                i = CL_WZHT.BLL.WZHT_BLL.UpdateTPZB(row);
            }
            if (state == "new")
            {
                //更新
                i = CL_WZHT.BLL.WZHT_BLL.SaveTPZB(row);
            }
        }
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    public void DeleteTMMX() //删除投票明细
    {
        string IDH = Request["ID"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteTMMX(IDH);
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
    }
    public void SaveTPMX() //保存投票明细
    {
        string Json = Request["data"];
        string IDH = Request["IDH"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateTPMX(row, IDH);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveTPMX(row, IDH);
            }
        }
    }
    public void SPLXLoad() //视频类型加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.SPLXLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveSPLX() //保存视频类型
    {
        string Json = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateSPLX(row);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveSPLX(row);
            }
        }
    }
    public void DeleteSPLX() //删除视频类型
    {
        string ID = Request["TypeID"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteSPLX(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void SPWHLoad() //视频维护加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.SPWHLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void DelSP() //删除视频
    {
        string FilmID = this.Request["FilmID"];
        string FilmURL = this.Request["FilmURL"];
        string SPTP = this.Request["SPTP"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DelSP(FilmID);
        if (Json > 0)
        {
            //删除附件
            System.IO.FileInfo myfile = new System.IO.FileInfo(Server.MapPath("../ExcelTemplate/Filmfile/") + FilmURL);
            if (myfile.Exists)
            {
                myfile.Delete();
            }
            System.IO.FileInfo myfile1 = new System.IO.FileInfo(Server.MapPath("../ExcelTemplate/Filmfile/") + SPTP);
            if (myfile1.Exists)
            {
                myfile1.Delete();
            }
        }
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
    }
    public void OpenSPXX() //打开视频信息
    {
        string FilmID = this.Request["FilmID"];
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenSPXX(FilmID);
        MyPublicMin.WriteStr(Json);
    }
    public void SPSSLM() //视频所属栏目
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.SPSSLM();
        MyPublicMin.WriteStr(Json);
    }
    public void SPSSLX() //视频类型
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.SPSSLX();
        MyPublicMin.WriteStr(Json);
    }
    public void SaveSP() //保存视频
    {
        string i = "";
        string Json = Request["data"];
        string state = Request["state"];
        string FilmID = Request["FilmID"];
        string TypeID = Request["TypeID"];
        string LMBH = Request["LMBH"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            if (state == "edit")
            {
                //新增
                i = CL_WZHT.BLL.WZHT_BLL.UpdateSP(row, LMBH, TypeID, FilmID);
            }
            if (state == "new")
            {
                //更新
                i = CL_WZHT.BLL.WZHT_BLL.SaveSP(row, LMBH, TypeID);
            }
        }
        MyPublicMin.WriteStr(i);
    }
    #endregion

    #region 网站文件管理
    public void WJLBLoad() //文件类别加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.WJLBLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveWJLB() //保存文件类别
    {
        string Json = Request["data"];
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(Json);
        foreach (Hashtable row in rows)
        {
            String state = CL_WZHT.BLL.AppTool.IsNull(row["_state"], "");
            if (state == "modified")
            {
                //新增
                CL_WZHT.BLL.WZHT_BLL.UpdateWJLB(row);
            }
            if (state == "added")
            {
                //更新
                CL_WZHT.BLL.WZHT_BLL.SaveWJLB(row);
            }
        }
    }
    public void DeleteWJLB() //删除文件类别
    {
        string ID = Request["LBBH"];
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteWJLB(ID);
        MyPublicMin.WriteStr(Json.ToString());
    }
    public void WJGLLoad() //文件列表加载
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.WJGLLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void SelectWJFLCombo() //文件所属类别
    {
        string Json = CL_WZHT.BLL.WZHT_BLL.SelectWJFLCombo();
        MyPublicMin.WriteStr(Json);
    }
    public void SaveWJ() //保存文件
    {
        string json = Request["json"];
        ArrayList js = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(json);
        string state = Request["state"];
        string fj = Request["fj"];
        ArrayList al = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(fj);
        int json1 = CL_WZHT.BLL.WZHT_BLL.SaveWJ(js, state, al);
        MyPublicMin.WriteStr(MyMessage.Message_Show(json1.ToString()));
    }
    public void OpenWJGL() //打开文件
    {
        string fileid = Request["FileID"];
        string Json = CL_WZHT.BLL.WZHT_BLL.OpenWJGL(fileid);
        MyPublicMin.WriteStr(Json);
    }
    public void WJFJLoad() //检索文件附件
    {
        string fileid = Request["FileID"];
        string Json = CL_WZHT.BLL.WZHT_BLL.WJFJLoad(fileid);
        MyPublicMin.WriteStr(Json);
    }
    public void DelWJFJ() //删除附件
    {
        string fj = Request["fj"];
        ArrayList al = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(fj);
        foreach (Hashtable row in al)
        {
            string filename = row["Path"].ToString();
            System.IO.FileInfo myfile = new System.IO.FileInfo(Server.MapPath("../" + filename)); //"../UploadFiles/WZ_WJGL/"
            if (myfile.Exists)
            {
                myfile.Delete();
            }
        }
        MyPublicMin.WriteStr(MyMessage.Message_Show("1"));
    }
    public void DeleteWJ() //删除文件
    {
        string fileid = Request["FileID"];
        //判断库里附件
        DataTable DT_FJ = new DataTable();
        DT_FJ = CL_WZHT.BLL.WZHT_BLL.WJFJList(fileid);
        //先删除记录
        int Json = CL_WZHT.BLL.WZHT_BLL.DeleteWJ(fileid);
        MyPublicMin.WriteStr(MyMessage.Message_Show(Json.ToString()));
        if (Json == 1)
        {
            //删除附件
            foreach (DataRow row in DT_FJ.Rows)
            {
                string filename = row["FilePath"].ToString();
                System.IO.FileInfo myfile = new System.IO.FileInfo(Server.MapPath("../" + filename));
                if (myfile.Exists)
                {
                    myfile.Delete();
                }
            }
        }
    }
    public void WJFJCKLoad() //文件附件查看列表
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.WJFJCKLoad(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    #endregion

    #region 网站栏目权限管理
    /// <summary>
    /// 从RYDJ表获取人员列表
    /// </summary>
    public void GetRYInfo()
    {
        System.Collections.Specialized.NameValueCollection _nameValueCollection = Request.Form; //获取表单参数集合
        string Json = CL_WZHT.BLL.WZHT_BLL.GetRYInfo(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    public void LoadLMQXTree() //加载网站栏目树
    {
        string yhm = CL_WZHT.BLL.AppTool.IsNull(Request["yhm"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMQXTree(yhm);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 保存权限
    /// </summary>
    public void SaveLMQX()
    {
        string data = Request["data"];
        string node = Request["node"];
        string yhm = "";
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(data);
        foreach (Hashtable row in rows)
        {
            yhm = row["YHM"].ToString();
        }
        int Json = CL_WZHT.BLL.WZHT_BLL.SaveLMQX(yhm, node);
        if (Json > 0)
        {
            MyPublicMin.WriteStr("OK");
        }
        else
        {
            MyPublicMin.WriteStr("设置权限失败!");
        }
    }
    public void LoadLMTree_NRGL() //加载网站栏目树
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["myField"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMTree_NRGL(LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void LoadLMTree_NRSHGL() //加载网站栏目树
    {
        string LMBH = CL_WZHT.BLL.AppTool.IsNull(Request["myField"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMTree_NRSHGL(LMBH);
        MyPublicMin.WriteStr(Json);
    }
    public void LoadLMSHQXTree() //加载网站栏目树
    {
        string yhm = CL_WZHT.BLL.AppTool.IsNull(Request["yhm"], "");
        string Json = CL_WZHT.BLL.WZHT_BLL.LoadLMSHQXTree(yhm);
        MyPublicMin.WriteStr(Json);
    }
    public void SaveLMSHQX()
    {
        string data = Request["data"];
        string node = Request["node"];
        //if (data == "" || data == null)
        //{
        //    MyPublicMin.WriteStr("请选择登录账号!");
        //    return;
        //}
        //if (node == "")
        //{
        //    MyPublicMin.WriteStr("请选择审核栏目权限!");
        //    return;
        //}
        string yhm = "";
        ArrayList rows = (ArrayList)KY.ERPOffice.Common.MyPublicMin.Decode(data);
        foreach (Hashtable row in rows)
        {
            yhm = row["YHM"].ToString();
        }
        //if (yhm == "")
        //{
        //    MyPublicMin.WriteStr("请选择登录账号!");
        //    return;
        //}
        int Json = CL_WZHT.BLL.WZHT_BLL.SaveLMSHQX(yhm, node);
        if (Json > 0)
        {
            MyPublicMin.WriteStr("OK");
        }
        else
        {
            MyPublicMin.WriteStr("设置权限失败!");
        }
    }
    public void OrderSave()
    {
        String json = Request["data"];
        String i = CL_WZHT.BLL.WZHT_BLL.OrderSave(json).ToString();
        MyPublicMin.WriteStr(i);
    }
    #endregion

}

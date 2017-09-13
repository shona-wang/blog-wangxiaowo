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

public partial class cms_service_wrap_type : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String MInNameText = Request["method"];
        Type type = this.GetType();
        MethodInfo method = type.GetMethod(MInNameText);
        method.Invoke(this, null);
    }

    public void query()
    {
        string queryType = Request.HttpMethod;
        NameValueCollection _namevalue = new NameValueCollection();
        string json = "-1";
        if (queryType == "POST")
        {
            _namevalue = Request.Form;
        }
        else if (queryType == "GET")
        {
            _namevalue = Request.QueryString;
        }
        //分页查询
        if (_namevalue["pageIndex"] != null)
        {
            json = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_PageJson_SelectWhere(_namevalue);
        }
        else
        {
            string where = cmsCommonData.Utils.Getparameter.getWhere(_namevalue);
            if (where != "")
            {
                json = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_Json_getSelectWhere(where);
            }
        }
        if (json == null)
        {
            json = "-1";
        }
        MyPublicMin.WriteStr(json);
    }

    public void update()
    {
        NameValueCollection _namevalue = Request.Form;
        int i = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_Insert(_namevalue);
        MyPublicMin.WriteStr(i.ToString());
    }

    public void delete()
    {
        NameValueCollection _namevalue = Request.Form;
        int i = -1;
        string where = cmsCommonData.Utils.Getparameter.getWhere(_namevalue);
        if (where != "")
        {
            i = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_Delete(where);
        }
        MyPublicMin.WriteStr(i.ToString());
    }

    public void deletes()
    {
        string queryType = Request.HttpMethod;
        NameValueCollection _namevalue = new NameValueCollection();
        if (queryType == "POST")
        {
            _namevalue = Request.Form;
        }
        else if (queryType == "GET")
        {
            _namevalue = Request.QueryString;
        }
        string ids = _namevalue["ids"];
        int i = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_Deletes(_namevalue["ids"].ToString());
        MyPublicMin.WriteStr(i.ToString());
    }

    public void insert()
    {
        NameValueCollection _namevalue = Request.Form;
        int i = cmsCommonData.BLL.Db_blog_wrap_type_BLL.Db_blog_wrap_type_Insert(_namevalue);
        MyPublicMin.WriteStr(i.ToString());
    }

    public void tree_query()
    {
        string json = cmsCommonData.BLL.Db_blog_wrap_type_BLL.tree_query();
        MyPublicMin.WriteStr(json);
    }
}
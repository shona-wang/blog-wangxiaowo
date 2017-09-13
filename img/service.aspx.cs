using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Reflection;
using System.Collections.Specialized;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;
using System.IO;



public partial class service : System.Web.UI.Page
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
            json = cmsCommonData.BLL.Db_blog_img_BLL.Db_blog_img_PageJson_SelectWhere(_namevalue);
        }
        else
        {
            string where = cmsCommonData.Utils.Getparameter.getWhere(_namevalue);
            if (where != "")
            {
                json = cmsCommonData.BLL.Db_blog_img_BLL.Db_blog_img_Json_getSelectWhere(where);
            }
        }
        if (json == null)
        {
            json = "-1";
        }
        MyPublicMin.WriteStr(json);
    }

    public void insert()
    {
        try
        {
            // 获得程序路径
            string tempFile = Server.MapPath(Request.ApplicationPath.ToString());
            tempFile = tempFile.Replace("\\", "/");
            string fileName = Request.Headers["Filename"];
            Stream stream = Request.GetBufferlessInputStream();
            Hashtable timeMap = cmsCommonData.Utils.Times.getHashTime();
            string ext = fileName.Substring(fileName.IndexOf("."));
            string id = System.DateTime.Now.ToString("yyyyMMddhhmmss");
            string name = id + ext;
            string path = "";
            // 如果有文件, 则保存到一个地址
            if (stream.Length > 0)
            {
                path = timeMap["year"] + "/" + timeMap["month"] + "/" + timeMap["day"];
                if (!Directory.Exists(tempFile + path))
                {
                    Directory.CreateDirectory(tempFile + path);
                }
                int isWrite = cmsCommonData.Utils.StreamTo.ToFile(stream, tempFile + path + "/" + name);//File.Create(tempFile + path + "/" + name);
                if (isWrite == 1)
                {
                    NameValueCollection _namevalue = new NameValueCollection();
                    _namevalue.Add("description", Request["description"]);
                    _namevalue.Add("url",path + "/" + name);
                    int i = cmsCommonData.BLL.Db_blog_img_BLL.Db_blog_img_Insert(_namevalue);
                }
            }
            else
            {
                MyPublicMin.WriteStr("-1");
            }
        }
        catch (Exception ex) {
            MyPublicMin.WriteStr("-1");
        }
    }

    public void delete()
    {
        NameValueCollection _namevalue = Request.Form;
        int i = -1;
        string where = cmsCommonData.Utils.Getparameter.getWhere(_namevalue);
        if (where != "")
        {
            i = cmsCommonData.BLL.Db_blog_img_BLL.Db_blog_img_Delete(where);
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
        int i = cmsCommonData.BLL.Db_blog_img_BLL.Db_blog_img_Deletes(_namevalue["ids"].ToString());
        MyPublicMin.WriteStr(i.ToString());
    }

    public void upload()
    {
        try
        {
            // 获得程序路径
            string tempFile = Server.MapPath(Request.ApplicationPath.ToString()); //Request.ServerVariables["Http_Host"].ToString();
                                                                                  //找到目标文件对象
            HttpPostedFile uploadFile = Request.Files["Filename"];
            System.IO.FileInfo myfile = new FileInfo(uploadFile.FileName);
            Hashtable timeMap = cmsCommonData.Utils.Times.getHashTime();
            string ext = myfile.Extension;
            string id = System.DateTime.Now.ToString("yyyyMMddhhmmss");
            string name = id + ext;
            string path = "";
            // 如果有文件, 则保存到一个地址
            if (uploadFile.ContentLength > 0)
            {
                path = timeMap["year"] + "/" + timeMap["month"] + "/" + timeMap["day"];
                if (Directory.Exists(tempFile + path))
                {
                    uploadFile.SaveAs(tempFile + path + "/" + name);
                }
                else
                {
                    Directory.CreateDirectory(tempFile + path);
                    uploadFile.SaveAs(tempFile + path + "/" + name);
                }
                Response.Write(path + "/" + name);
            }
        }
        catch (Exception ex)
        {
            Response.Write("-1");
        }
    }
}
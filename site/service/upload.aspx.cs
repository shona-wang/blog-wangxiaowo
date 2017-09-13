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
using WebsiteCommonData;
using System.IO;

public partial class cms_service_upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 获得程序路径
        string tempFile = Server.MapPath(Request.ApplicationPath.ToString()); //Request.ServerVariables["Http_Host"].ToString();
        //找到目标文件对象
        HttpPostedFile uploadFile = Request.Files["Fdata"];
        System.IO.FileInfo myfile = new FileInfo(uploadFile.FileName);
        Hashtable timeMap = cmsCommonData.Utils.Times.getHashTime();
        string ext = myfile.Extension;
        string id = System.DateTime.Now.ToString("yyyyMMddhhmmss");
        string name = id + ext;
        string path = "";
        // 如果有文件, 则保存到一个地址
        if (uploadFile.ContentLength > 0)
        {
            path = "UploadFiles\\" + timeMap["year"] + "\\" + timeMap["month"] + "\\" + timeMap["day"];
            if (Directory.Exists(tempFile+path))
            {
                uploadFile.SaveAs(tempFile+path + "\\" + name);
            }
            else
            {
                Directory.CreateDirectory(tempFile+path);
                uploadFile.SaveAs(tempFile+path + "\\" + name);
            }
        }
        else
        {
            Response.Write("-1");
        }
        Response.Write(path + "\\" + name);    //可以返回一个JSON, 在客户端做更多处理
        //MyPublicMin.WriteStr(name);//这个是输出json的函数
    }
}
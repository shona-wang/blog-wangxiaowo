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

public partial class HomePage_Manage_Pic_Upload_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //myfile.Name.Substring(0, myfile.Name.Length - ext.Length) + 
        // 获得程序路径
        string tempFile = Request.PhysicalApplicationPath;

        //找到目标文件对象
        HttpPostedFile uploadFile = Request.Files["Fdata"];
        System.IO.FileInfo myfile = new FileInfo(uploadFile.FileName);
        string ext = myfile.Extension;
        string FJBH = WebsiteCommonData.BLL.Website_Common_BLL.SCSJ().ToString("yyyyMMddhhmmss");
        string name = FJBH + ext;
        string LJ = "";
        // 如果有文件, 则保存到一个地址
        if (uploadFile.ContentLength > 0)
        {
            LJ = string.Format("{0}{1}{2}", tempFile, "UploadFiles\\LHTP\\", name);
            uploadFile.SaveAs(LJ);
        }
        Response.Write(name);    //可以返回一个JSON, 在客户端做更多处理
        //MyPublicMin.WriteStr(name);//这个是输出json的函数
    }
}

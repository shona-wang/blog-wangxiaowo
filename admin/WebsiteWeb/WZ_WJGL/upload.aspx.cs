﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Collections.Specialized;
using System.Reflection;
using KY.ERPOffice.Common;
using KY.ERPOffice.BLL;


public partial class WZ_WJGL_upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 获得程序路径
        string tempFile = Request.PhysicalApplicationPath;

        //找到目标文件对象
        HttpPostedFile uploadFile = Request.Files["Fdata"];
        System.IO.FileInfo myfile = new FileInfo(uploadFile.FileName);
        string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + KY.ERPOffice.Common.SessionGetSet.getUserID() + myfile.Extension;//+"("+DateTime.Now+")
        //filename = filename.Substring(0, filename.Length - 4) + DateTime.Now.ToString("yyyyMMddhhmmss") + ".jpg";
        // 如果有文件, 则保存到一个地址
        if (uploadFile.ContentLength > 0)
        {
            uploadFile.SaveAs(string.Format("{0}{1}{2}", tempFile, "UploadFiles\\WZ_WJGL\\", filename));
        }
        MyPublicMin.WriteStr(filename);
    }
}

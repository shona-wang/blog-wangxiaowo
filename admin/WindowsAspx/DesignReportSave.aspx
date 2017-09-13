<%@ Page Language="C#" %>
<%@ import Namespace="System" %>
<%@ import Namespace="System.IO" %>
<script runat="server"> 

    // 注意:要成功保存设计的报表模板，ASP.NET系统用户(在IIS 5.x中 <机器名>\ASPNET, 
    // 在 IIS 6.x 中为 NETWORK SERVICE)必须具有模板保存目录的写权限.  ***在配置IIS时必须设置,否则无法保存 郭如意
    protected void Page_Load(object sender, EventArgs e)
    {
        byte[] FormData = Request.BinaryRead(Request.TotalBytes);

        //写入上传数据，最后保存到文件
        //string strPathFile = Server.MapPath("") + @"\KFGL\GRF\" + Request.QueryString["Report"];
        //string url = Request.QueryString["Report"];
        //string JD = Server.MapPath("");
        string strPathFile = Server.MapPath("~/") + @"/GridReport/" + Request.QueryString["Report"];
        BinaryWriter bw = new BinaryWriter(File.Create(strPathFile));
        bw.Write(FormData);
        bw.Close();
    }
</script>
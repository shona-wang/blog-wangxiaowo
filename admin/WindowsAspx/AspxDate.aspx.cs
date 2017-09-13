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
public partial class WindowsAspx_AspxDate : System.Web.UI.Page
{
    String NameText = "",MinDeacription="";//操作步骤名称 备注
    #region 公共函数
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
            MyPublicMin.isHaveLogin();
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
    protected void BeforeInvoke(string _NameText,string _MInName )
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
        if (MyPublicMin.isHaveLoginSession())
        {
            Loginfo_BLL.Loginfo_Insert(_NameText, _MInName, _MinDeacription);
        }
    }
    #endregion
    #region 获取当前登录人权限菜单操作
    public void Js_Interval()
    {
        MyPublicMin.WriteStr(KY.ERPOffice.Common.SessionGetSet.getUserName());
    }
    public void SelectDisplayZbsysEmpRoles()
    {
        String Json = DisplayZb_BLL.Select_Display_Zb_sysEmpRoles();
        MyPublicMin.WriteStr(Json);
    }
    #endregion
    #region 人员管理模块操作
    /// <summary>
    /// 人员账号数据加载 按数据范围
    /// </summary>
    public void SearchEmployees()
     {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = Rydj_BLL.Select_rydj_Json(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 人员账号数据加载 所有用户
    /// </summary>
    public void SearchEmployeesPossessive()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = Rydj_BLL.Select_rydj_PossessiveJson(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 人员删除 注:这里需要把对应的 所属部门 角色 一起事物删除
    /// </summary>
    public void RemoveEmployees()
    {
        //NameText = "人员删除";
        String idStr = Request["id"];
        if (String.IsNullOrEmpty(idStr)) return;
        int i =Rydj_BLL.Delete_Rydj(idStr);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    /// <summary>
    /// 人员初始化密码
    /// </summary>
    public void RemoveEmployeesCshMM()
    {
        //NameText = "初始化密码";
        String UserStr = Request["id"];
        if (String.IsNullOrEmpty(UserStr)) return;
        int i = Rydj_BLL.Update_Pwd(UserStr);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    /// <summary>
    /// 验证用户名是否重复
    /// </summary>
    public void UserRepeatCount()
    {
        String Userid = Request["yhm"];
        String Count = pub_BLL.SelectCount("RYDJ", " And yhm='" + Userid + "' or Relatedyhm='"+Userid+"' And AccountNum='" + KY.ERPOffice.Common.SessionGetSet.getAccountNum() + "'");//Rydj_BLL.Select_Rydj_Count(Userid);
        MyPublicMin.WriteStr(Count);
    }
    /// <summary>
    /// 验证关联登录名是否重复
    /// </summary>
    public void UserRelatedyhmCount()
    {
        String Userid = Request["Relatedyhm"];
        String Count = pub_BLL.SelectCount("RYDJ", " And Relatedyhm='" + Userid + "' or yhm='" + Userid + "'  And AccountNum='" + KY.ERPOffice.Common.SessionGetSet.getAccountNum() + "'");//Rydj_BLL.Select_Rydj_Count(Userid);
        MyPublicMin.WriteStr(Count);
    }
    /// <summary>
    /// 人员修改查询一条数据
    /// </summary>
    public void RydjGetuser()
    {
        String Userid = Request["yhm"];
        String json =Rydj_BLL.RYBM_XX(Userid);
        MyPublicMin.WriteStr(json);
    }
    /// <summary>
    /// 人员表保存
    /// </summary>
    public void SaveUser()
    {
        //NameText = "人员保存";
        String json = Request["data"];
        string i =Rydj_BLL.Insert_Rydj(json).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    /// <summary>
    /// 获取当前登录人员数据范围
    /// </summary>
    public void getUserSjfw()
    {
        String Sjfw = SessionGetSet.getDataScope();
        MyPublicMin.WriteStr(Sjfw.ToString());
    }
    /// <summary>
    /// 修改密码
    /// </summary>
    public void PwdEdit()
    {
        //NameText = "密码修改";
       int i = Rydj_BLL.Pwd_Update(Request["Jpwd"],Request["Xpwd"]);
       if (i > 0)
       {
           MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
       }
       else if (i == -2)
       {
           MyPublicMin.WriteStr(MyMessage.Message_OK("输入的旧密码不对!", "0"));
       }
       else
       {
           MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
       }
    }
    /// <summary>
    /// 密码设置
    /// </summary>
    public void PwdSetup()
    {
        String json = Request["data"];
        int a = KY.ERPOffice.BLL.Rydj_BLL.PwdSetup(json);
        MyPublicMin.WriteStr(a.ToString());
    }
    /// <summary>
    /// 按组织机构多选查询 可通用
    /// </summary>
    public void UserTree()
    {
        MyPublicMin.WriteStr(Rydj_BLL.User_Tree());
    }
    public void UserEmpSetUp()
    {
        String json = Request["data"];
        int a = KY.ERPOffice.BLL.Table39_BLL.UserEmpSetUp(json);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void Select_Rydj()
    {
        string Where = "";
        if (Request.QueryString["YHM"] != null && Request.QueryString["YHM"].ToString() != "")
        {
            Where = " And xx like '%" + Request["YHM"].ToString() + "%' ";
        }
        String json = Rydj_BLL.Select_Rydj(Where);
        MyPublicMin.WriteStr(json);
    }
    public void UpdateRydjDataRoles()
    {
       String Userid=Request.Form["Userid"];
       //NameText = "设置[" + Userid+"]用户的数据范围";
       String SJFW = Request.Form["SJFW"];
       int i = Rydj_BLL.UpdateRydjDataRoles(Userid, SJFW);
       MyPublicMin.WriteStr(i.ToString());
    }
    public void UpdateSXSJ()
    {
        Rydj_BLL.UpdateSXSJ();
        MyPublicMin.WriteStr("1");
    }
    public void SelectUserType()
    {
        String Json = Rydj_BLL.SelectUserType();
        MyPublicMin.WriteStr(Json);
    }
    public void update_zt()
    { 
       String yhm=Request["yhm"];
       String zt = Request["zt"];
       MyPublicMin.WriteStr(Rydj_BLL.update_zt(yhm,zt).ToString());
    }
    #endregion
    #region   部门管理模块操作
    /// <summary>
    ///部门查询  按数据范围查询
    /// </summary>
    public void EmpSelect()
    {
        String Json = Table38_BLL.EmpSelect(Request["key"]);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    ///部门查询  全部组织机构
    /// </summary>
    public void EmpSelectPossessive()
    {
        String Json = Table38_BLL.EmpSelectPossessive(Request["key"]);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 一级单位查询
    /// </summary>
    public void EmployeesGet()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = Table38_BLL.EmployeesSelect(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 一级单位保存
    /// </summary>
    public void EmployeesSave()
    {
        //NameText = "单位保存";
        String json = Request["data"];
        String i = Table38_BLL.EmployeesSave(json).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    /// <summary>
    /// 部门表按节点代码查询
    /// </summary>
    public void EmployeesTreeGet()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json =Table38_BLL.EmployeesTreeGet(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 部门排序保存
    /// </summary>
    public void EmployeesTreeSave()
    {
        //NameText = "部门保存";
        String json = Request["data"];
        String i = Table38_BLL.EmployeesTreeSave(json).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    /// <summary>
    /// 部门删除
    /// </summary>
    public void EmpDeletes()
    {
        String DWID = Request["DWID"];
        int i = Table38_BLL.Table38_Deletes(DWID);
        MyPublicMin.WriteStr(i.ToString());
    }
    /// <summary>
    /// 根据节点代码查询DWID
    /// </summary>
    public void get_table38()
    {
        String JDDM = Request.QueryString["JDDM"];
        MyPublicMin.WriteStr(Table38_BLL.get_table38(JDDM));
    }
    /// <summary>
    /// 组织机构修改查询
    /// </summary>
    public void SelectTable38Where()
    {
        String DWID = Request.QueryString["DWID"];
        MyPublicMin.WriteStr(Table38_BLL.SelectTable38Where(DWID));
    }
    public void EmployeesTreeSaveA()
    {
        //NameText = "组织机构保存";
        String json = Request["data"];
        string i = Table38_BLL.EmployeesTreeSaveA(json).ToString();
        MyPublicMin.WriteStr(i); 
    }
    /// <summary>
    /// 查询组织机构下级部门
    /// </summary>
    public void getdepartment()
    {
       String Jddm = Request.Form["dept_id"];
       String Json = Table38_BLL.getdepartment(Jddm);
       MyPublicMin.WriteStr(Json);
    }
    #endregion
    #region  职位管理模块操作
    /// <summary>
    /// 维护账户时  选择职位查询
    /// </summary>
    public void TableSelect()
    {
        String Json = Table37_BLL.Select_Table37();
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 职位维护查询
    /// </summary>
    public void PositiionGet()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = Table37_BLL.SelectTable37_Json(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 职位保存
    /// </summary>
    public void SavePositiion()
    {
        //NameText = "职位保存";
        String json = Request["data"];
        String i = Table37_BLL.Table37Edit(json).ToString();
        MyPublicMin.WriteStr(i);
    }
    public void Table37_Where()
    {
        String Zwid = Request["ZWID"];
        String Json = Table37_BLL.Table37_Where(Zwid);
        MyPublicMin.WriteStr(Json);
    }
    public void Table37_Deletes()
    {
        //NameText = "职位删除";
        String Zwid = Request["ZWID"];
        int i  = Table37_BLL.Table37_Deletes(Zwid);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    #endregion
    #region 角色管理模块操作
    /// <summary>
    /// 维护账户时查询  
    /// </summary>
    public void sysRolesDicSearchEmployees()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json =sysRolesDic_BLL.Select_sysRolesDic(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 角色维护查询  
    /// </summary>
    public void sysRolesDicindex()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = sysRolesDic_BLL.Select_sysRolesDic(_nameValueCollection);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 角色保存
    /// </summary>
    public void sysRolesDicSave()
    {
        //NameText = "角色保存";
        String data = Request["data"];
        String i = sysRolesDic_BLL.sysRolesDicEditSave(data).ToString();
        MyPublicMin.WriteStr(i);
    }
    public void sysRolesDic_Where()
    {
        String RoleID = Request["RoleID"];
        String Json =sysRolesDic_BLL.sysRolesDic_Where(RoleID);
        MyPublicMin.WriteStr(Json);
    }
    public void sysRolesDic_Deletes()
    {
        //NameText = "角色删除";
        String RoleID = Request["RoleID"];
        int i = sysRolesDic_BLL.sysRolesDic_Deletes(RoleID);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    public void sysEmpRoles_xx()
    {
        String userid = Request["userid"];
        String Json = sysEmpRoles_BLL.sysEmpRoles_xx(userid);
        MyPublicMin.WriteStr(Json);
    }
    public void sysEmpRoles_useridxx()
    {
        String userid = Request["userid"];
        String Json = sysEmpRoles_BLL.sysEmpRoles_useridxx(userid);
        MyPublicMin.WriteStr(Json);
    }
    public void Delete_sysEmpRoles()
    {
        //NameText = "用户角色删除";
        String Roleid = Request["RoleID"];
        int a = sysEmpRoles_BLL.Delete_sysEmpRoles(Roleid);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void Insert_sysEmpRoles()
    {
        //NameText = "用户角色增加";
        String Roleid = Request["RoleID"];
        String userid = Request["userid"];
        int a = sysEmpRoles_BLL.Insert_sysEmpRoles(userid,Roleid);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void Insert_sysEmpRolesAndUser()
    {
        String Roleid = Request["RoleID"];
        String userid = Request["userid"];
        int a = sysEmpRoles_BLL.Insert_sysEmpRolesAndUser(userid, Roleid);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void sysEmpRolesAndUser()
    {
        String Roleid = Request["RoleID"];
        String Json = sysEmpRoles_BLL.sysEmpRolesAndUser(Roleid);
        MyPublicMin.WriteStr(Json);
    }
    public void sysEmpRolesNoAndUser()
    {
        String Roleid = Request["RoleID"];
        String Json = sysEmpRoles_BLL.sysEmpRolesNoAndUser(Roleid);
        MyPublicMin.WriteStr(Json);
    }
    public void Delete_user_sysEmpRoles() 
    {
        String Roleid = Request["RoleID"];
        String userid = Request["userid"];
        int a = sysEmpRoles_BLL.Delete_sysEmpRoles(userid, Roleid);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void sysRolesDicAndsysEmpRolesUser()
    {
        String LoginID = Request["LoginID"];
        String Json = sysRolesDic_BLL.sysRolesDicAndsysEmpRolesUser(LoginID);
        MyPublicMin.WriteStr(Json);
    }
    #endregion
    #region 查询角色菜单所拥有的功能菜单操作
    public void sysGroupPowerGet()
    {
        String Json =sysGroupPower_BLL.sysGroupPowerSelect(Request["RoleID"]);
        MyPublicMin.WriteStr(Json);
    }
    public void sysGroupPowerUser()
    {
        String Json = sysGroupPower_BLL.sysGroupPowerUser(Request["LoginID"]);
        MyPublicMin.WriteStr(Json);
    }
    public void SysGroupPowerOrganizationSelect()
    {
        String Json = sysGroupPower_BLL.SysGroupPowerOrganizationSelect(Request["DWID"]);
        MyPublicMin.WriteStr(Json);
    }
    public void SysGroupPowerPositiionSelect()
    {
        String Json = sysGroupPower_BLL.SysGroupPowerPositiionSelect(Request["ZWID"]);
        MyPublicMin.WriteStr(Json);
    }
    public void ButtonRoles()
    {
        String MenuBh = Request["MenuBh"];
        String Json = sysGroupPower_BLL.ButtonRoles(MenuBh);
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 角色保存
    /// </summary>
    public void sysGroupPowerSave()
    {
        //NameText = "角色保存";
        String json = Request["data"];//选择节点值
        String RoleID = Request["RoleID"];//组ID
        String i = sysGroupPower_BLL.sysGroupPowerSave(json, RoleID).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    public void SysGroupPowerUserSave()
    {
        //NameText = "人员权限批量保存设置";
        String Userid = Request["Userid"];//
        String Roles = Request.Form["Roles"];//
        String MenuJson = Request.Form["MenuJson"];
        String i = SysGroupPowerUser_BLL.SysGroupPowerUserSave(Userid,Roles,MenuJson).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    /// <summary>
    /// 组织机构权限设置保存
    /// </summary>
    public void SysGroupPowerOrganizationSave()
    {
        //NameText = "组织机构权限保存设置";
        String DWID = Request["DWID"];//
        String MenuJson = Request.Form["MenuJson"];
        String i = SysGroupPowerOrganization_BLL.SysGroupPowerOrganizationSave(DWID, MenuJson).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    /// <summary>
    /// 职位权限保存
    /// </summary>
    public void sysGroupPowerPositiionSave()
    {
        //NameText = "职位权限保存设置";
        String ZWID = Request["ZWID"];//
        String MenuJson = Request.Form["MenuJson"];
        String i = SysGroupPowerPositiion_BLL.sysGroupPowerPositiionSave(ZWID, MenuJson).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    #endregion
    #region 系统日志模块操作
    /// <summary>
    /// 日志查询
    /// </summary>
    public void LoginfoGet()
    {
        NameValueCollection namevaluecollection = Request.Form;
        MyPublicMin.WriteStr(Loginfo_BLL.LoginfoSelect(namevaluecollection));
    }
    /// <summary>
    /// 日志删除
    /// </summary>
    public void LoginfoDel()
    {
        //NameText = "日志删除";
        String K_Date = Request["KDate"];
        String J_Date = Request["JDate"];
        int a = Loginfo_BLL.Loginfo_Delete(K_Date, J_Date);
        MyPublicMin.WriteStr(MyMessage.Message_Show(a.ToString()));
    }
    public void getUserLoginfo()
    {
        //NameValueCollection namevaluecollection = Request.Form;
        MyPublicMin.WriteStr(Loginfo_BLL.getUserLoginfo());
    }
    #endregion 
    #region  系统异常管理模块操作
    /// <summary>
    /// 查询
    /// </summary>
    public void ExceptionGet()
    {
        NameValueCollection namevaluecollection = Request.Form;
        MyPublicMin.WriteStr(Exception_BLL.ExceptionSelect(namevaluecollection));
    }
    /// <summary>
    /// 异常删除
    /// </summary>
    public void ExceptionDel()
    {
        //NameText = "异常信息删除";
        String K_Date = Request["KDate"];
        String J_Date = Request["JDate"];
        int a =Exception_BLL.Exception_Delete(K_Date, J_Date);
        MyPublicMin.WriteStr(MyMessage.Message_Show(a.ToString()));
    }
    #endregion
    #region 菜单管理模块操作
    /// <summary>
    /// 查询所有菜单
    /// </summary>
    public void MenuLeftGet()
    {
        String Json = DisplayZb_BLL.Display_ZbSelect();
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 查询子菜单
    /// </summary>
    public void MenuRightGet()
    {
        String Fid = Request["dept_id"];
        string json=DisplayZb_BLL.Display_poweridSelect(Fid);
        MyPublicMin.WriteStr(json);
    }
    /// <summary>
    /// 菜单保存
    /// </summary>
    public void MenuSave()
    {
        String Json = Request["data"];
        int i=DisplayZb_BLL.Menu_Save(Json);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    /// <summary>
    /// 模块管理按钮查询
    /// </summary>
    public void SelectDisButton()
    {
        String parentid = Request["parentid"];
        String Json = DisplayZb_BLL.SelectDisButton(parentid);
        MyPublicMin.WriteStr(Json);
    }
    public void DeleteDisButton()
    {
        String Powerids = Request["Powerids"];
        int i= DisplayZb_BLL.DeleteDisButton(Powerids);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void InsertDisButton()
    {
        String parentid = Request["parentid"];
        String buttonids = Request["buttonids"];
        String buttontexts = Request["buttontexts"];
        String buttonimgs = Request["buttonimgs"];
        int i = DisplayZb_BLL.InsertDisButton(parentid, buttonids, buttontexts, buttonimgs);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void UpDisplay_Zb_XuHao()
    {
        String Json = Request.Form["data"];
        int i = DisplayZb_BLL.UpDisplay_Zb_XuHao(Json);
        MyPublicMin.WriteStr(i.ToString());
    }
    #endregion
    #region  报表设计管理
    public void ReportGet()
    {
        String Json = KY_Report_BLL.Select_Report();
        MyPublicMin.WriteStr(Json);
    }
    #endregion
    #region 按钮操作管理
    public void Insert_sysButtonCtion()
    {
        //NameText = "按钮操作保存";
        String json = Request["data"];
        String i = sysButtonCtion_BLL.Insert_sysButtonCtion(json).ToString();
        MyPublicMin.WriteStr(MyMessage.Message_Show(i));
    }
    public void Delete_sysButtonCtion()
    {
        //NameText = "按钮操作删除";
        String Guid = Request["Guid"];
        int i = sysButtonCtion_BLL.Delete_sysButtonCtion(Guid);
        MyPublicMin.WriteStr(MyMessage.Message_Show(i.ToString()));
    }
    public void get_sysButtonCtion()
    { 
        String Json = sysButtonCtion_BLL.get_sysButtonCtion();
        MyPublicMin.WriteStr(Json);
    }
    public void get_sysButtonCtionWhere()
    {
        String Guid = Request["Guid"];
        String Json = sysButtonCtion_BLL.get_sysButtonCtionWhere(Guid);
        MyPublicMin.WriteStr(Json);
    }
    public void Icon_GetImg()
    {
        String Json = sysButtonCtion_BLL.Icon_GetImg();
        MyPublicMin.WriteStr(Json);
    }
    /// <summary>
    /// 添加模块按钮-按钮查询
    /// </summary>
    public void Select_MenuPowerid()
    {
        String parentid = Request["parentid"];
        String Json = sysButtonCtion_BLL.Select_MenuPowerid(parentid);
        MyPublicMin.WriteStr(Json);
    }
    #endregion
    #region 高级查询字段转换
    public void jszd()
    {
        string json = Server.UrlDecode(Request.Form["Cols"]);
        MyPublicMin.WriteStr(json);
    }
    #endregion
    #region 字典操作函数
    public void Select_Where()
    {
        String YWLX = Request["YWLX"];
        String Json = KY_ZD_BLL.Select_Where("YWLX='" + YWLX + "' order by xh");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
    public void Select_WhereDist()
    {
        String YWLX = Request["YWLX"];
        String Json = KY_ZD_BLL.Select_WhereDist("YWLX='" + YWLX + "' order by xh ");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
    public void Select_WhereDJBH()
    {
        String DJBH = Request["DJBH"];
        String Json = KY_ZD_BLL.Select_WhereDJBH("DJBH='" + DJBH + "'");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
    public void DeleteList()
    {
        String DJBH = Request["DJBH"];
        int i =KY_ZD_BLL.DeleteList(DJBH);
        KY.ERPOffice.Common.MyPublicMin.WriteStr(i.ToString());
    }
    public void ZDAdd()
    {
        NameText = "字典保存";
        String data = Request["data"];
        int i = KY_ZD_BLL.Add(data);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void UpZiDian_XuHao()
    {
        String data = Request.Form["data"];
        int i = KY_ZD_BLL.UpZiDian_XuHao(data);
        MyPublicMin.WriteStr(i.ToString());
    }
    #endregion 
    #region 附件操作函数
    public void FJ_Delete()
    {
        String DJBH = Request.QueryString["DJBH"];
        String i = pub_BLL.FileUploadDelete(DJBH);
        int g = KY_FJ_BLL.KYFJ_Delete(" And FPath='" + DJBH + "'");
        MyPublicMin.WriteStr(i);
    }
    public void FJ_Select()
    {
        String DJBH = Request.QueryString["DJBH"];
        String Json = KY_FJ_BLL.SelectFJWhere(" And DocBh='" + DJBH + "'");
        MyPublicMin.WriteStr(Json);
    }
    #endregion 
    #region 消息提醒操作
    /// <summary>
    /// 信息提醒查询
    /// </summary>
    public void MessageSelTiXing()
    {
       String Json = BaseMessage_BLL.SelTiXing(SessionGetSet.getUserID(), SessionGetSet.getAccountNum(), "0");
       if (Json != "[]")
       {
           MyPublicMin.WriteStr(Json);
       }
       else
       {
           MyPublicMin.WriteStr("");
       }
    }
    public void MessageUpdatezt()
    {
        String ID = Request["ID"];
        int a = BaseMessage_BLL.Updatezt(ID);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void MessageUpdateztYWLX()
    {
        String XXLX = Request["XXLX"];
        int a = BaseMessage_BLL.UpdateztYWLX(XXLX);
        MyPublicMin.WriteStr(a.ToString());
    }
    #endregion
    #region 升级执行函数
    public void SQLSave()
    {
        String TypeZt = Request["Type"];
        int a = WindewsDataBaseUpgrade.UpgradeSave(TypeZt);
        MyPublicMin.WriteStr(a.ToString());
    }
    public void YeWuSQLSave()
    {
        String SQLText = Request["SQLText"];
        int a = WindewsDataBaseUpgrade.YeWuUpgradeSave(SQLText);
        MyPublicMin.WriteStr(a.ToString());
    }
    #endregion
    #region 系统数据表操作
    public void SelectDataBase()
    {
        MyPublicMin.WriteStr(ErpDataBase_BLL.SelectDataBase());
    }
    public void SelectDataBaseField()
    {
        string TableName = Request.Form["TableName"];
        string json = ErpDataBase_BLL.SelectDataBaseField(TableName);
        MyPublicMin.WriteStr(json);
    }
    public void getWinData()
    {
        String TableName = Request.QueryString["TableName"];
        NameValueCollection _nameValueCollection = Request.Form;
        string json = ErpDataBase_BLL.getWinData(_nameValueCollection, TableName);
        MyPublicMin.WriteStr(json);
    }
    public void DataComCount()
    {
        String DataTableName = Request.QueryString["DataTableName"];
        String DataColmName = Request.QueryString["DataColmName"];
        string i = ErpDataBase_BLL.DataColmCount(DataTableName, DataColmName);
        MyPublicMin.WriteStr(i);
    }
    public void ColmSave()
    {
        String json = Request["data"];
        int i = ErpDataBase_BLL.AddColm(json);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void ColmDel()
    {
        String ids = Request.QueryString["id"];
        String DataTableName = Request.QueryString["DataTableName"];
        int i = ErpDataBase_BLL.DelColm(ids,DataTableName);
        MyPublicMin.WriteStr(i.ToString());
    }
    #endregion
    #region Tree字典操作函数
    public void getTreeData()
    {
        String YWLX = Request["YWLX"];
        String Json = KY_ZD_Tree_BLL.KY_ZD_Tree_JsonSelectWhere(" And YWLX='" + YWLX + "'");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
    public void getTreeDataWhere()
    {
        String YWLX = Request["YWLX"];
        String JDDM=Request["JDDM"];
        String Json = KY_ZD_Tree_BLL.KY_ZD_Tree_Json_SelectWhere(" And YWLX='" + YWLX + "' And KY_ZD_Tree.JDDM='" + JDDM + "'");
        KY.ERPOffice.Common.MyPublicMin.WriteStr(Json);
    }
    public void KY_ZD_Tree_Insert()
    {
        NameValueCollection name = Request.Form;
        int i = KY_ZD_Tree_BLL.KY_ZD_Tree_Insert(name);
        MyPublicMin.WriteStr(i.ToString());
    }
    public void KY_ZD_Tree_Delete()
    {
        String JDDM = Request["JDDM"];
        String YWLX=Request["YWLX"];
        int i = KY_ZD_Tree_BLL.KY_ZD_Tree_Delete(" And jddm='"+JDDM+"' or fjddm='"+JDDM+"' And YWLX='"+YWLX+"'");
        MyPublicMin.WriteStr(i.ToString());
    }
    #endregion
    public void cs()
    {
        //Hashtable sd = new Hashtable();
        //sd["@strND"] = "'ND12500B50-2013000002～00004'";
        //sd["@fl"] = "'RP'";
        //sd["@LJTXM"] = "XP-201303281716.TXM_20131022";
        //int b = (int)KY.ERPOffice.Common.pub_BLL.Sp_ExGetReturnValueCount("HP_Test", sd);
        Hashtable sd = new Hashtable();
        Hashtable ExCstext = new Hashtable();
        sd["@FLBM"] = "0001";  //(0001 和0001001)都可以
        sd["@CodeType"] = "WZBM_A";
        sd["@AccountNum"] = "009";
        string[] MM = new string[3];
        MM[0] = "@DMLJ";
        MM[1] = "@LSH";
        MM[2] = "@errtext";
        //MM[3] = "@FLBM";
        int  b = (int)KY.ERPOffice.Common.pub_BLL.Sp_ExGetReturnValueCount("生成新的药品编码", sd, MM, ref ExCstext);
        //JS_BM03_Models.DMLJ = ExCstext["@DMLJ"].ToString();
    }
    public void Demo()
    {
        NameValueCollection _nameValueCollection = Request.Form;
        String Json = KY.ERPOffice.BLL.Flows_BLL.Get_FlowsLook("BC-2013-12-01-0001");
        MyPublicMin.WriteStr(Json);
    }

}

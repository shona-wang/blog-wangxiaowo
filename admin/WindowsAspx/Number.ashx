<%@ WebHandler Language="C#" Class="Number" %>

using System;
using System.Web;
using KY.ERPOffice.Common;
public class Number :CodeImage   
{
    protected override void CallRead()
    {
        string Code = MyPublicMin.RandNum(5);
        CreateCheckCodeImage(Code, 15.0, 21);
    }
}
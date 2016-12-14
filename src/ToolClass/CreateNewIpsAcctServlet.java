package ToolClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

//4.2开户
public class CreateNewIpsAcctServlet extends HttpServlet 
{
		private static final long serialVersionUID = -1054205774679878549L;
		private final Log log=LogFactory.getLog(getClass());
		
		public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			String pMerCode  =  request.getParameter("pMerCode");
			String txtXml = 	request.getParameter("txtXml");
			String strxml = "";
			
			if(txtXml!=null&&!"".equals(txtXml))
			{//手动改报文提交
				strxml = txtXml.trim();
			}
			else
			{
				String pMerBillNo = request.getParameter("pMerBillNo");
				String pIdentType = request.getParameter("pIdentType");
				String pIdentNo = request.getParameter("pIdentNo");
				String pRealName = request.getParameter("pRealName");
				String pMobileNo = request.getParameter("pMobileNo");
				String pEmail = request.getParameter("pEmail");
				String pSmDate = request.getParameter("pSmDate");
				String pWebUrl = request.getParameter("pWebUrl");
				String pS2SUrl = request.getParameter("pS2SUrl");
				String pMemo1 = request.getParameter("pMemo1");
				String pMemo2 = request.getParameter("pMemo2");
				String pMemo3 = request.getParameter("pMemo3");
				
				strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
			            + "<pReq>"
			            + "<pMerBillNo>" + pMerBillNo + "</pMerBillNo>"
			            + "<pIdentType>" + pIdentType + "</pIdentType>"
			            + "<pIdentNo>" + pIdentNo + "</pIdentNo>"
			            + "<pRealName>" + pRealName + "</pRealName>"
			            + "<pMobileNo>" + pMobileNo + "</pMobileNo>"
			            + "<pEmail>" + pEmail + "</pEmail>"
			            + "<pSmDate>"+ pSmDate + "</pSmDate>"
			            + "<pWebUrl>" + pWebUrl + "</pWebUrl>"
			            + "<pS2SUrl>" + pS2SUrl + "</pS2SUrl>"
			            + "<pMemo1>" + pMemo1 + "</pMemo1>"
			            + "<pMemo2>" + pMemo2 + "</pMemo2>"
			            + "<pMemo3>" + pMemo3 + "</pMemo3>"
			        + "</pReq>";
			}
		    
		    try
		    {
		    	String  str3DesXmlPana = strxml ;
		        log.info("DesXmlPana = " + str3DesXmlPana);
		        //3DES加密
		    	str3DesXmlPana = com.ips.security.utility.IpsCrypto.triDesEncrypt(strxml,Config.DES_KEY,Config.DES_IV);
		    	//去掉换行、空格等
		    	str3DesXmlPana = str3DesXmlPana.replaceAll("\r\n", "");
		    	//MD5加密
		        String  strSign = com.ips.security.utility.IpsCrypto.md5Sign(pMerCode+str3DesXmlPana+Config.CERT_MD5);
		    
			    log.info("DES = "+str3DesXmlPana);
			    log.info("Sign = "+strSign);
		
			    //提交到测试环境
			    String Url = Config.POST_URL+"CreateNewIpsAcct.aspx";
			    
			    try 
			    {
			        out.println("<!DOCTYPE html>");
			        out.println("<html>");
			        out.println("<head>");
			        out.println("<title>Servlet AccountServlet</title>");
			        out.println("</head>");
			        out.println("<body>");
			        out.println("<form action="+Url+" id=\"frm1\" method=\"post\">");
			        out.println("<input type=\"hidden\" name=\"argMerCode\" value=" + pMerCode + ">");
			        out.println("<input type=\"hidden\" name=\"arg3DesXmlPara\" value=" + str3DesXmlPana + ">");
			        out.println("<input type=\"hidden\" name=\"argSign\" value=" + strSign + ">");
			        out.println("</form>");
			        out.println("<script language=\"javascript\">");
			        out.println("document.getElementById(\"frm1\").submit();");
			        out.println("</script>");
			        out.println("</body>");
			        out.println("</html>");
			    } finally {
			        out.close();
			    }
		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    	log.error(e.getMessage(),e);
		    }
			
		}
	
}

package ToolClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//4.4登记债权人
public class RegisterCreditorServlet extends HttpServlet {
	private static final long serialVersionUID = -2051318009158786147L;
	private final Log log=LogFactory.getLog(getClass());

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
{
	request.setCharacterEncoding("UTF-8");
	PrintWriter out = response.getWriter();
	
	String pMerCode  =  request.getParameter("pMerCode");
	String txtXml = request.getParameter("txtXml");
	String strxml = "";
	if(txtXml!=null&&!"".equals(txtXml)){
		strxml=txtXml;
	}else{
	String pMerBillNo = request.getParameter("pMerBillNo");
	String pMerDate = request.getParameter("pMerDate");
	String pBidNo  =  request.getParameter("pBidNo");
	String pContractNo = request.getParameter("pContractNo");
	String pRegType = request.getParameter("pRegType");
	String pAuthAmt = request.getParameter("pAuthAmt");
	String pAuthNo = request.getParameter("pAuthNo");
	String pTrdAmt = request.getParameter("pTrdAmt");
	String pFee = request.getParameter("pFee");
	String pAcctType = request.getParameter("pAcctType");
	String pIdentNo = request.getParameter("pIdentNo");
	String pRealName = request.getParameter("pRealName");
	String pAccount = request.getParameter("pAccount");
	String pUse = request.getParameter("pUse");
	String pWebUrl = request.getParameter("pWebUrl");
	String pS2SUrl = request.getParameter("pS2SUrl");
	String pMemo1 = request.getParameter("pMemo1");
	String pMemo2 = request.getParameter("pMemo2");
	String pMemo3 = request.getParameter("pMemo3");
 
    strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        + "<pReq>"+
        "<pMerBillNo>"+pMerBillNo+"</pMerBillNo>"+
        "<pMerDate>" + pMerDate + "</pMerDate>" +
        "<pBidNo>"+pBidNo+"</pBidNo>"+
        "<pContractNo>" + pContractNo + "</pContractNo>" +
        "<pRegType>" + pRegType + "</pRegType>" +
        "<pAuthNo>" + pAuthNo + "</pAuthNo>" +
        "<pAuthAmt>" + pAuthAmt + "</pAuthAmt>" +
        "<pTrdAmt>" + pTrdAmt + "</pTrdAmt>" +
        "<pFee>" + pFee + "</pFee>" +
        "<pAcctType>" + pAcctType + "</pAcctType>" +
        "<pIdentNo>" + pIdentNo + "</pIdentNo>" +
        "<pRealName>" + pRealName + "</pRealName>" +
        "<pAccount>" + pAccount + "</pAccount>" +
        "<pUse>" + pUse + "</pUse>" +
        "<pWebUrl>" + pWebUrl + "</pWebUrl>"+ 
        "<pS2SUrl>" + pS2SUrl + "</pS2SUrl>"+ 
        "<pMemo1>" + pMemo1 + "</pMemo1>"+ 
        "<pMemo2>" + pMemo2 + "</pMemo2>"+ 
        "<pMemo3>" + pMemo3 + "</pMemo3>"+ 
       "</pReq>";
	}
    try{
 
		String  str3DesXmlPana = strxml ;
		log.info("DesXmlPana = " + str3DesXmlPana);
		str3DesXmlPana = com.ips.security.utility.IpsCrypto.triDesEncrypt(strxml,Config.DES_KEY,Config.DES_IV);
		str3DesXmlPana = str3DesXmlPana.replaceAll("\r\n", "");
	
		String  strSign = com.ips.security.utility.IpsCrypto.md5Sign(pMerCode+str3DesXmlPana+Config.CERT_MD5);
	
		log.info("DES = "+str3DesXmlPana);
		log.info("Sign = "+strSign);
		
		response.setContentType("text/html;charset=UTF-8");
		String Url = Config.POST_URL+"registerCreditor.aspx";
		
		try {
			/* TODO output your page here. You may use following sample code. */
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet AccountServlet</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("<form action="+Url+" id=\"frm1\" method=\"post\">");
			out.println("<input type=\"hidden\" name=\"pMerCode\" value=" + pMerCode + ">");
			out.println("<input type=\"hidden\" name=\"p3DesXmlPara\" value=" + str3DesXmlPana + ">");
			out.println("<input type=\"hidden\" name=\"pSign\" value=" + strSign + ">");
			out.println("</form>");
			out.println("<script language=\"javascript\">");
			out.println("document.getElementById(\"frm1\").submit();");
			out.println("</script>");
			out.println("</body>");
			out.println("</html>");
		} finally {
			out.close();
		}
	}catch(Exception e)
	{
		e.printStackTrace();
		log.error(e.getMessage(), e);
	}
	
}
}

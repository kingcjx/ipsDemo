package ToolClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//4.3登记标的 
public class RegisterSubjectServlet extends HttpServlet {
	private static final long serialVersionUID = -252853616126379598L;
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
	String pBidNo  =  request.getParameter("pBidNo");
	String pRegDate = request.getParameter("pRegDate");
	String pLendAmt = request.getParameter("pLendAmt");
	String pGuaranteesAmt = request.getParameter("pGuaranteesAmt");
	String pTrdLendRate = request.getParameter("pTrdLendRate");
	String pTrdCycleType = request.getParameter("pTrdCycleType");
	String pTrdCycleValue = request.getParameter("pTrdCycleValue");
	String pLendPurpose = request.getParameter("pLendPurpose");
	String pRepayMode = request.getParameter("pRepayMode");
	String pOperationType = request.getParameter("pOperationType");
	String pLendFee = request.getParameter("pLendFee");
	String pAcctType = request.getParameter("pAcctType");
	String pIdentNo = request.getParameter("pIdentNo");
	String pRealName = request.getParameter("pRealName");
	String pIpsAcctNo = request.getParameter("pIpsAcctNo");
	String pWebUrl = request.getParameter("pWebUrl");
	String pS2SUrl = request.getParameter("pS2SUrl");
	String pMemo1 = request.getParameter("pMemo1");
	String pMemo2 = request.getParameter("pMemo2");
	String pMemo3 = request.getParameter("pMemo3");

    strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        + "<pReq>"+
        "<pMerBillNo>"+pMerBillNo+"</pMerBillNo>"+
        "<pBidNo>"+pBidNo+"</pBidNo>"+
        "<pRegDate>"+pRegDate+"</pRegDate>"+
        "<pLendAmt>" + pLendAmt + "</pLendAmt>" +
        "<pGuaranteesAmt>" + pGuaranteesAmt + "</pGuaranteesAmt>" +
        "<pTrdLendRate>" + pTrdLendRate + "</pTrdLendRate>" +
        "<pTrdCycleType>" + pTrdCycleType + "</pTrdCycleType>" +
        "<pTrdCycleValue>" + pTrdCycleValue + "</pTrdCycleValue>" +
        "<pLendPurpose>" + pLendPurpose + "</pLendPurpose>" +
        "<pRepayMode>" + pRepayMode + "</pRepayMode>" +
        "<pOperationType>" + pOperationType + "</pOperationType>" +
        "<pLendFee>" + pLendFee + "</pLendFee>" +
        "<pAcctType>" + pAcctType + "</pAcctType>" +
        "<pIdentNo>" + pIdentNo + "</pIdentNo>" +
        "<pRealName>" + pRealName + "</pRealName>" +
        "<pIpsAcctNo>" + pIpsAcctNo + "</pIpsAcctNo>" +
        "<pWebUrl><![CDATA[" + pWebUrl + "]]></pWebUrl>" +
        "<pS2SUrl><![CDATA[" + pS2SUrl + "]]></pS2SUrl>" +
        "<pMemo1>" + pMemo1 + "</pMemo1>" +
        "<pMemo2>" + pMemo2 + "</pMemo2>" +
        "<pMemo3>" + pMemo3 + "</pMemo3>" 
       + "</pReq>";
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

		String Url = Config.POST_URL+"registerSubject.aspx";
		
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
    }
	
}
}

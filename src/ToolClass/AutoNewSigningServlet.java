package ToolClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//4.7自动投标签约 
public class AutoNewSigningServlet  extends HttpServlet {
	private static final long serialVersionUID = -7819695162922965182L;
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
		String pSigningDate = request.getParameter("pSigningDate");
		String pIdentNo = request.getParameter("pIdentNo");
		String pRealName = request.getParameter("pRealName");
		String pIpsAcctNo = request.getParameter("pIpsAcctNo");
		
		String pValidType = request.getParameter("pValidType");
		String pValidDate = request.getParameter("pValidDate");
		String pTrdCycleType = request.getParameter("pTrdCycleType");
		String pSTrdCycleValue = request.getParameter("pSTrdCycleValue");
		String pETrdCycleValue = request.getParameter("pETrdCycleValue");
		String pSAmtQuota = request.getParameter("pSAmtQuota");
		String pEAmtQuota = request.getParameter("pEAmtQuota");
		String pSIRQuota = request.getParameter("pSIRQuota");
		String pEIRQuota = request.getParameter("pEIRQuota");
		String pWebUrl = request.getParameter("pWebUrl");
		String pS2SUrl = request.getParameter("pS2SUrl");
		String pMemo1 = request.getParameter("pMemo1");
		String pMemo2 = request.getParameter("pMemo2");
		String pMemo3 = request.getParameter("pMemo3");
		
        strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                + "<pReq>"+
                "<pMerBillNo>"+pMerBillNo+"</pMerBillNo>"+
                "<pSigningDate>" + pSigningDate + "</pSigningDate>" +
                "<pIdentNo>" + pIdentNo + "</pIdentNo>" +
                "<pRealName>" + pRealName + "</pRealName>" +
                "<pIpsAcctNo>" + pIpsAcctNo + "</pIpsAcctNo>" +
                "<pValidType>" + pValidType + "</pValidType>" +
                "<pValidDate>" + pValidDate + "</pValidDate>" +
                "<pTrdCycleType>" + pTrdCycleType + "</pTrdCycleType>" +
                "<pSTrdCycleValue><![CDATA[" + pSTrdCycleValue + "]]></pSTrdCycleValue>" +
                "<pETrdCycleValue><![CDATA[" + pETrdCycleValue + "]]></pETrdCycleValue>" +
                "<pSAmtQuota><![CDATA[" + pSAmtQuota + "]]></pSAmtQuota>" +
                "<pEAmtQuota><![CDATA[" + pEAmtQuota + "]]></pEAmtQuota>" +
                "<pSIRQuota><![CDATA[" + pSIRQuota + "]]></pSIRQuota>" +
                "<pEIRQuota><![CDATA[" + pEIRQuota + "]]></pEIRQuota>" +
                "<pWebUrl><![CDATA[" + pWebUrl + "]]></pWebUrl>" +
                "<pS2SUrl><![CDATA[" + pS2SUrl + "]]></pS2SUrl>" +
                "<pMemo1>" + pMemo1 + "</pMemo1>" +
                "<pMemo2>" + pMemo2 + "</pMemo2>" +
                "<pMemo3>" + pMemo3 + "</pMemo3>" +
            "</pReq>";
		}
		
	    try{
	 
	    	String  p3DesXmlPara = strxml ;
	    	log.info("3DesXmlPana = "+p3DesXmlPara);
	    	p3DesXmlPara = com.ips.security.utility.IpsCrypto.triDesEncrypt(strxml,Config.DES_KEY,Config.DES_IV);
	    	p3DesXmlPara = p3DesXmlPara.replaceAll("\r\n", "");
	  
	        String  pSign = com.ips.security.utility.IpsCrypto.md5Sign(pMerCode+p3DesXmlPara+Config.CERT_MD5);
	    
	        log.info("pMerCode=="+pMerCode);
		    log.info("p3DesXmlPara = "+p3DesXmlPara);
		    log.info("pSign = "+pSign);
		    
		    response.setContentType("text/html;charset=UTF-8");
		    String Url = Config.POST_URL+"AutoNewSigning.aspx";
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
		        out.println("<input type=\"hidden\" name=\"p3DesXmlPara\" value=" + p3DesXmlPara + ">");
		        out.println("<input type=\"hidden\" name=\"pSign\" value=" + pSign + ">");
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
	    	log.error(e.getMessage(),e);
	    }
	}
}

package ToolClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * Servlet implementation class WsTestServlet
 */
//S2S返回
public class WsTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Log log=LogFactory.getLog(getClass());

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		
		String resultStr = (String)request.getAttribute("resultStr");
		String returnStr = (String)request.getAttribute("returnStr");
		
		String pMerCode = getXmlNodeValue(resultStr, "pMerCode");
		String pErrCode = getXmlNodeValue(resultStr, "pErrCode");
		String pErrMsg = getXmlNodeValue(resultStr,"pErrMsg");
		String p3DesXmlPara = getXmlNodeValue(resultStr,"p3DesXmlPara");
		String pSign = getXmlNodeValue(resultStr,"pSign");
		
		log.info("pMerCode = " + pMerCode);
		log.info("pErrCode = " + pErrCode);
		log.info("pErrMsg = " + pErrMsg);
		log.info("p3DesXmlPara = " + p3DesXmlPara);
		log.info("pSign = " + pSign);

		try 
		{
            if (Config.CERT_MD5 == null)
            {
                out.println("<br />" + "获取平台商户证书失败");
                return;
            }
			String signPlainText = pMerCode + pErrCode + pErrMsg + p3DesXmlPara+ Config.CERT_MD5;
			log.info("signPlainText==="+signPlainText);
			String localSign = com.ips.security.utility.IpsCrypto.md5Sign(signPlainText);

			response.setContentType("text/html;charset=UTF-8");
			
			if (localSign.equals(pSign)) {
				log.info("MD5验签通过！");
				String str3XmlParaInfo = com.ips.security.utility.IpsCrypto.triDesDecrypt(p3DesXmlPara, Config.DES_KEY, Config.DES_IV);
				
				if("".equals(str3XmlParaInfo)||str3XmlParaInfo==null)
				{
					out.println("<br />3DES解密失败");
					return;
				}
				log.info("str3XmlParaInfo = " + str3XmlParaInfo);
				/*
				out.println("<br />pMerCode=" + pMerCode + "<br />"
						+ "pErrCode=" + pErrCode + "<br />" 
						+ "pErrMsg="+ pErrMsg + "<br />" 
						+ "p3DesXmlPara=" + p3DesXmlPara+ "<br />" 
						+ "内容=" + str3XmlParaInfo + "<br />");
				*/
				request.setAttribute("resultStr",resultStr);
				javax.servlet.RequestDispatcher requestDispatcher = request.getRequestDispatcher(returnStr);
				requestDispatcher.forward(request, response);
			} else {
				log.info("MD5验签失败！");
				out.println("<br />MD5验签失败 <br />");
                out.println("<br />localSign = " + localSign+ "<br />");
                out.println("<br />pSign = " + pSign+ "<br />");
                out.println("<br />CERT_MD5 = " + Config.CERT_MD5+ "<br />");
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}
	}
    
	public String getXmlNodeValue(String xml ,String nodeName){
		String temp1[] = xml.split("<"+nodeName+">");
		String temp2[] = temp1[1].split("</"+nodeName+">");
		String resultXml = temp2[0];
		return resultXml;
	}
}

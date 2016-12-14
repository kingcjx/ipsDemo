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
 * Servlet implementation class TestServlet
 */
// Web返回
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Log log = LogFactory.getLog(getClass());

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String pMerCode = request.getParameter("pMerCode");
		String pErrCode = request.getParameter("pErrCode");
		String pErrMsg = request.getParameter("pErrMsg");
		String p3DesXmlPara = request.getParameter("p3DesXmlPara");
		String pSign = request.getParameter("pSign");

		try 
		{
            if (Config.CERT_MD5 == null)
            {
                out.println("<br />" + "获取平台商户证书失败");
                return;
            }
			String signPlainText = pMerCode + pErrCode + pErrMsg + p3DesXmlPara+ Config.CERT_MD5;
			String localSign = com.ips.security.utility.IpsCrypto.md5Sign(signPlainText);

			response.setContentType("text/html;charset=UTF-8");
			
			if (localSign.equals(pSign)) 
			{
				log.info("MD5验签通过！");
				String str3XmlParaInfo = com.ips.security.utility.IpsCrypto.triDesDecrypt(p3DesXmlPara, Config.DES_KEY, Config.DES_IV);
				if("".equals(str3XmlParaInfo)||str3XmlParaInfo==null)
				{
					out.println("<br />3DES解密失败");
					return;
				}
				log.info("str3XmlParaInfo = " + str3XmlParaInfo);
				out.println("<br />pMerCode=" + pMerCode + "<br />"
						+ "pErrCode=" + pErrCode + "<br />" 
						+ "pErrMsg="+ pErrMsg + "<br />" 
						+ "p3DesXmlPara=" + p3DesXmlPara+ "<br />" 
						+ "内容=" + str3XmlParaInfo + "<br />");
			}
			else
			{
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
}

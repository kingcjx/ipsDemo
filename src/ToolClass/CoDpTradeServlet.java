package ToolClass;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Servlet implementation class CoDpTradeServlet
 */
//4.13自动代扣充值 
public class CoDpTradeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Log log=LogFactory.getLog(getClass());
	String StrUrl=Config.WS_URL;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CoDpTradeServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html;charset=UTF-8");
		
		String pMerCode  =  request.getParameter("pMerCode");
		String txtXml = request.getParameter("txtXml");
		String strxml = "";
		if(txtXml!=null&&!"".equals(txtXml)){
			strxml=txtXml;
		}else{
		String pMerBillNo = request.getParameter("pMerBillNo");
		String pTrdDate = request.getParameter("pTrdDate");
		String pTrdAmt =request.getParameter("pTrdAmt");
		String pMerFee = request.getParameter("pMerFee");
		String pIpsFeeType =request.getParameter("pIpsFeeType");
		String pAcctType = request.getParameter("pAcctType");
		String pIdentNo =request.getParameter("pIdentNo");
		String pRealName = request.getParameter("pRealName");
		String pIpsAcctNo =request.getParameter("pIpsAcctNo");
		String pS2SUrl = request.getParameter("pS2SUrl");
		String pMemo1 = request.getParameter("pMemo1");
		String pMemo2 = request.getParameter("pMemo2");
		String pMemo3 = request.getParameter("pMemo3");
		strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+
						"<pReq>"+
			                "<pMerBillNo>" + pMerBillNo + "</pMerBillNo>"+
			                "<pTrdDate>" + pTrdDate + "</pTrdDate>"+
			                "<pTrdAmt>" + pTrdAmt + "</pTrdAmt>"+
			                "<pMerFee>" + pMerFee + "</pMerFee>"+
			                "<pIpsFeeType>" + pIpsFeeType + "</pIpsFeeType>"+
			                "<pAcctType>" + pAcctType + "</pAcctType>"+
			                "<pIdentNo>" + pIdentNo + "</pIdentNo>"+
			                "<pRealName>" + pRealName + "</pRealName>"+
			                "<pIpsAcctNo>" + pIpsAcctNo + "</pIpsAcctNo>"+
			                "<pS2SUrl>" + pS2SUrl + "</pS2SUrl>"+
			                "<pMemo1>" + pMemo1 + "</pMemo1>"+
			                "<pMemo2>" + pMemo2 + "</pMemo2>"+
			                "<pMemo3>" + pMemo3 + "</pMemo3>"+
						"</pReq>";
		}
		
		String  str3DesXmlPana = strxml ;
    	log.info("DesXmlPana = "+str3DesXmlPana);
    	str3DesXmlPana = com.ips.security.utility.IpsCrypto.triDesEncrypt(strxml,Config.DES_KEY,Config.DES_IV);
    	str3DesXmlPana = str3DesXmlPana.replaceAll("\r\n", "");
    	
        String  strSign = com.ips.security.utility.IpsCrypto.md5Sign(pMerCode+str3DesXmlPana+Config.CERT_MD5);
        log.info("DES = "+str3DesXmlPana);
        log.info("Sign = "+strSign);
    
		String data = getSoapInputStream(StrUrl,pMerCode,str3DesXmlPana,strSign);
		log.info("WS返回数据==="+data);
		
		XmlTool1 Tool = new XmlTool1();
		Tool.SetDocument(data);
		String xml = Tool.getNodeValue("CoDpTradeResult");
		log.info("xml = "+xml);
		
		
		request.setAttribute("resultStr",xml);
		request.setAttribute("returnStr", "/coDpTrade.jsp");
		javax.servlet.RequestDispatcher requestDispatcher = request.getRequestDispatcher("/wstest");
		requestDispatcher.forward(request, response);
		}

	private String getSoapInputStream(String Url,String argMerCode,String arg3DesXmlPara,String argSign) {  
        try {  
            String soap = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+
            "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
            "<soap:Body>"+
            "  <CoDpTrade xmlns=\"http://tempuri.org/\">"+
            "    <argMerCode>"+argMerCode+"</argMerCode>"+
            "    <arg3DesXmlPara>"+arg3DesXmlPara+"</arg3DesXmlPara>"+
            "    <argSign>"+argSign+"</argSign>"+
            "  </CoDpTrade>"+
            "</soap:Body>"+
            "</soap:Envelope>";
            
            URL url = new URL(Url);  
            URLConnection conn = url.openConnection();  
            conn.setUseCaches(false);  
            conn.setDoInput(true);  
            conn.setDoOutput(true);  
  
            conn.setRequestProperty("Content-Length", Integer.toString(soap  
                    .length()));  
            conn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");  
            conn.setRequestProperty("SOAPAction",  
                    "http://tempuri.org/CoDpTrade");  
  
            OutputStream os = conn.getOutputStream();  
            OutputStreamWriter osw = new OutputStreamWriter(os, "utf-8");  
            osw.write(soap);
            osw.flush();  
            osw.close();  

            InputStream is = conn.getInputStream();  
            
            DataInputStream dis=new DataInputStream(is);
     	   	byte d[]=new byte[dis.available()];
     	   	dis.read(d);
     	    String data=new String(d,"UTF-8");
           
     	    return data;
  
        } catch (Exception e) {  
            e.printStackTrace();
            log.error(e.getMessage(),e);
            return null;  
        }  
    } 

}

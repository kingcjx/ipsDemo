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
 * Servlet implementation class TransferServlet
*/
//4.10转账
public class TransferServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Log log=LogFactory.getLog(getClass());
	String StrUrl=Config.WS_URL;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransferServlet() {
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
		String pBidNo = request.getParameter("pBidNo");
		String pDate = request.getParameter("pDate");
		String pTransferType =request.getParameter("pTransferType");
		String pTransferMode =request.getParameter("pTransferMode");
		String pDetails =request.getParameter("pDetails");
		String pS2SUrl = request.getParameter("pS2SUrl");
		String pMemo1 = request.getParameter("pMemo1");
		String pMemo2 = request.getParameter("pMemo2");
		String pMemo3 = request.getParameter("pMemo3");
		strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+
						"<pReq>"+
							"<pMerBillNo>"+pMerBillNo+"</pMerBillNo>"+
							"<pBidNo>" + pBidNo + "</pBidNo>" +
							"<pDate>" + pDate + "</pDate>" +
							"<pTransferType>" + pTransferType + "</pTransferType>" +
							"<pTransferMode>" + pTransferMode + "</pTransferMode>" +
							"<pDetails>" + pDetails + "</pDetails>" +
							"<pS2SUrl><![CDATA[" + pS2SUrl + "]]></pS2SUrl>" +
							"<pMemo1>" + pMemo1 + "</pMemo1>" +
							"<pMemo2>" + pMemo2 + "</pMemo2>" +
							"<pMemo3>" + pMemo3 + "</pMemo3>" +
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
		String xml = Tool.getNodeValue("TransferResult");
		log.info("xml = "+xml);
		
		

		request.setAttribute("resultStr",xml);
		request.setAttribute("returnStr", "/transfer.jsp");
		javax.servlet.RequestDispatcher requestDispatcher = request.getRequestDispatcher("/wstest");
		requestDispatcher.forward(request, response);

		}

	private String getSoapInputStream(String Url,String argMerCode,String arg3DesXmlPara,String argSign) {  
        try {  
            String soap = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+
            "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
            "<soap:Body>"+
            "  <Transfer xmlns=\"http://tempuri.org/\">"+
            "    <pMerCode>"+argMerCode+"</pMerCode>"+
            "    <p3DesXmlPara>"+arg3DesXmlPara+"</p3DesXmlPara>"+
            "    <pSign>"+argSign+"</pSign>"+
            "  </Transfer>"+
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
                    "http://tempuri.org/Transfer");  
  
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
            log.error(e.getMessage(), e);
            return null;  
        }  
    } 

}

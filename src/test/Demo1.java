package test;

import ToolClass.Config;
import ToolClass.XmlTool1;

public class Demo1 
{
	public static void main(String[] args) 
	{
		String p3DesXmlPara="O75eJ5spQphliWkDyBTXItr9RH/lz3O0Qj08cPVAFYjmboeyvbx3itLYU80BmCwt9IaoUmJvrk9oIfPSpamC9hbYCFraLc3dOlYQJ5wAIAfYFQz/ayCcEATCUiBF9VAUnJGAu1LNDynMIiBFPZBVG3dd7ehfRiUIlWmDSnCodPalCYAvz5T7+q/MP7qnTDUmjJbAxrRCev4JKkboyrRpbJZbQSTQwHMnFp9Vltblp37tyydLetoWXse+HzQ+qS7XZu/87MzdqMdxDOXCALSyXHVDmwoMwztZfwDOkVALJqbjh4wFnFtVVia2++dtszn1hYlnH3hI2/uCM3R1kKeIyOtq02CflzIXPDpDjf0wwsq/cPhY9W83VwqJH6opEOC+sIiDxf/OAoLwXYfnEIIBgigMahkRaJ+krGSaXJhRp1uxWCEWnRIollv5XohHRqy+QJluQ7CojI9RcarlylocXTUhUyxKAWMSHbBHC7oOulBX5kLW62peMi8uzyB5ZHOggJu380/W3lLdJd1qW4JTMsexuPdoyVppG7f8B/mwgcPe0Kwnq4fnzwCnabvTtu1nmZW0ZWBvlmNFjuM9W4jfgzI5ZFuhJ+TE5jk4wkjPqaej8Gcao33OaATvhics1Kn/1v7C+yO3I1p/XaLfjhKhTY72/EugSTd2Am3XIiAWwkIptTrFEguZ/diUzxiqZ7dw4eNcAf7437fK22m4MKqgMMyvrJQ/TQhDQb6LrbOTDn3CjeiP52Qp9dU+sWDnNiSN/j97Lcwtfwq0gpSB1AhXa+1XG5A+qrKZ6ZlEkytJXK0F661+SI+t1g==";
				
		
		String result = com.ips.security.utility.IpsCrypto.triDesDecrypt(p3DesXmlPara, Config.DES_KEY, Config.DES_IV);
		
		System.out.println("********"+result);
	}
}

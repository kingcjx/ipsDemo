package ToolClass;

public class Config 
{
	/*测试环境*/
    public static final String POST_URL="http://p2p.ips.net.cn/CreditWeb/";
    
    public static final String WS_URL=  "http://p2p.ips.net.cn/CreditWS/Service.asmx";
    

    
    public static final String pWebUrl="http://localhost:8080/ipsDemo/test";//web方式返回
    public static final String pS2SUrl="http://localhost:8080/ipsDemo/wstest";//s2s方式返回
    
    /* IPS证书 */
    
    //MD5证书、IPS证书
    public static final String CERT_MD5	= "GPhKt7sh4dxQQZZkINGFtefRKNPyAj8S00cgAwtRyy0ufD7alNC28xCBKpa6IU7u54zzWSAv4PqUDKMgpOnM7fucO1wuwMi4RgPAnietmqYIhHXZ3TqTGKNzkxA55qYH";
    //3DES密钥
    public static final String DES_KEY	="ICHuQplJ0YR9l7XeVNKi6FMn";
    //3DES向量
    public static final String DES_IV =	"2EDxsEfp";
}
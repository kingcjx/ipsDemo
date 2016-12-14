<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自动代扣充值</title>
</head>
<body>
	<form action="CoDpTrade" method="post">
			<table border="1" cellspacing="0" cellpadding="3"
				style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
				align="center">
				<tr style="background-color: #8070FF; color: #FFFF00">
					<td colspan="2" align="Center"><b>自动代扣充值（WS）</b></td>
				</tr>
				<tr>
					<td style="width: 50%">平台账号</td>
					<td style="width: 50%"><input type="text" id="pMerCode"
						name="pMerCode" value="808801" /><br />由IPS颁发的商户号</td>
				</tr>
				<tr>
					<td>商户充值订单号</td>
					<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz); 
					%>
					<%
						SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
						Date currentTime0 = new Date();//得到当前系统时间
						String pMerBillNo="PCDP"+formatter0.format(currentTime0)+"12";
						
					%>
					<td><input type="text" id="pMerBillNo" name="pMerBillNo" value="<%=pMerBillNo%>"/></td>
				</tr>
				<tr>
					<td>充值日期</td>
					<%
						SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
						Date currentTime1 = new Date();//得到当前系统时间
						String pTrdDate = formatter1.format(currentTime1); //将日期时间格式化
					%>
					<td><input type="text" id="pTrdDate" name="pTrdDate"
						value="<%=pTrdDate%>" /><br />格式：YYYYMMDD</td>
				</tr>
				<tr>
					<td>充值金额</td>
					<td><input type="text" id="pTrdAmt" name="pTrdAmt"
						value="10.00" /></td>
				</tr>
				<tr>
					<td>平台手续费</td>
					<td><input type="text" id="pMerFee" name="pMerFee"
						value="1.00" /></td>
				</tr>
				<tr>
					<td>谁付IPS手续费</td>
					<td><input type="text" id="pIpsFeeType" name="pIpsFeeType"
						value="1" /> <br />IPS收取的费用 1：平台支付 2：用户支付</td>
				</tr>
				<tr>
					<td>账户类型</td>
					<td><input type="text" id="pAcctType" name="pAcctType" value="1" />
					<br/>0#非托管；1#托管</td>
				</tr>
				<tr>
					<td>证件号码</td>
					<td style="height: 32px"><input type="text" id="pIdentNo"
						name="pIdentNo" value="310229198708270301" /></td>
				</tr>
				<tr>
					<td>姓名</td>
					<td><input type="text" id="pRealName" name="pRealName" value="张天一" /></td>
				</tr>
				<tr>
					<td>IPS账户号</td>
					<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo"
						value="4021000014680735" /> <br /> 账户类型为1时，IPS账号 <br />
						账户类型为0时，平台账号</td>
				</tr>
				<tr>
					<td>异步返回地址2</td>
					<td><input type="text" id="pS2SUrl" name="pS2SUrl"
						value="<%=Config.pS2SUrl %>"
						style="width: 100%;" />异步返回地址</td>
				</tr>
				<tr>
					<td>备注1</td>
					<td><input type="text" id="pMemo1" name="pMemo1" value="备注1"/></td>
				</tr>
				<tr>
					<td>备注2</td>
					<td><input type="text" id="pMemo2" name="pMemo2" value="备注2"/></td>
				</tr>
				<tr>
					<td>备注3</td>
					<td><input type="text" id="pMemo3" name="pMemo3" value="备注3"/></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="提交(WS)" /></td>
				</tr>
				<tr>
					<td colspan="2">返回结果
					<%
						String resultStr = (String) request.getAttribute("resultStr");
					%>
					<textarea rows="10" cols="100%" id="resultStr" name="resultStr"><%= resultStr==null?"":resultStr%></textarea></td>
				</tr>
			<tr>
				<td colspan="2">手动修改报文信息
					<textarea rows="5" cols="100%" id="txtXml"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" id="btnPost" value="手动改报文提交" onclick="submitXml();"/>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript" language="javascript">
		var pMerCode = document.getElementById("pMerCode").value;
		
		function formTxtXml(){
			var txtXml="<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                + "<pReq>"
                + "<pMerBillNo>" + document.getElementById("pMerBillNo").value + "</pMerBillNo>"
                + "<pTrdDate>" + document.getElementById("pTrdDate").value + "</pTrdDate>"
                + "<pTrdAmt>" + document.getElementById("pTrdAmt").value + "</pTrdAmt>"
                + "<pMerFee>" + document.getElementById("pMerFee").value + "</pMerFee>"
                + "<pIpsFeeType>" + document.getElementById("pIpsFeeType").value + "</pIpsFeeType>"
                + "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>"
                + "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>"
                + "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>"
                + "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>"
                + "<pS2SUrl>" + document.getElementById("pS2SUrl").value + "</pS2SUrl>"
                + "<pMemo1><![CDATA[" + document.getElementById("pMemo1").value + "]]></pMemo1>"
                + "<pMemo2><![CDATA[" + document.getElementById("pMemo2").value + "]]></pMemo2>"
                + "<pMemo3><![CDATA[" + document.getElementById("pMemo3").value + "]]></pMemo3>"
            + "</pReq>";
            document.getElementById("txtXml").value=txtXml;
		}
		setTimeout("formTxtXml()",10);//定时器,隔10毫秒执行formTxtXml()函数
		
		
		function post(URL, PARAMS) { 
		    var temp = document.createElement("form");
		    temp.action = URL; 
		    temp.method = "post"; 
		    temp.style.display = "none"; 
		    for (var x in PARAMS) {
		        var opt = document.createElement("textarea");
		        opt.name = x;
		        opt.value = PARAMS[x];
		        // alert(opt.name)      
		        temp.appendChild(opt);
		    }      
		    document.body.appendChild(temp);
		    temp.submit();
		    return temp;
		}      
		
		function submitXml(){
		post('CoDpTrade', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
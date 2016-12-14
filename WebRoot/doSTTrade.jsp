<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提现</title>
</head>
<body>
	<form action="DoSTTrade" method="post" target="_blank">
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>提现（POST）</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /></td>
			</tr>
			
			<tr>
				<td>商户提款订单号</td>
				<%
				TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
				TimeZone.setDefault(tz);
				SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
				Date currentTime0 = new Date();//得到当前系统时间
				String pMerBillNo = "PREP"+formatter0.format(currentTime0); //将日期时间格式化
				%>
				<td><input type="text" id="pMerBillNo"
					name="pMerBillNo" value="<%=pMerBillNo %>" /></td>
			</tr>
			<tr>
				<td>账户类型</td>
				<td><input type="text" id="pAcctType" name="pAcctType" value="1" />
				<br />0#非托管；1#托管</td>
			</tr>
			<tr>
				<td>提款模式</td>
				<td><input type="text" id="pOutType" name="pOutType" value="1" /> <br />
					1#普通提款；2#定向提款</td>
			</tr>

			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo" name="pBidNo" value="000001" />
				<br />提款模式为2时，此字段生效内容是投标时的标号</td>
			</tr>
			<tr>
				<td>合同号</td>
				<td><input type="text" id="pContractNo" name="pContractNo" value="MER20140717110943" />
				<br />提款模式为2时，此字段生效内容是投标时的合同号</td>
			</tr>
			<tr>
				<td>提款去向</td>
				<td><input type="text" id="pDwTo" name="pDwTo" value="4021000014467865" />
				<br />提款模式为2时，此字段生效上送IPS账号（个人/商户号）</td>
			</tr>
			<tr>
				<td>证件号码</td>
				<td style="height: 32px"><input type="text" id="pIdentNo"
					name="pIdentNo" value="410621198501222222" /></td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input type="text" id="pRealName" name="pRealName" value="郑小亮" /></td>
			</tr>
			<tr>
				<td>IPS账户号</td>
				<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo" value="4021000029936843" />
				<br /> 账户类型为1时，IPS账号 <br /> 账户类型为0时，平台账号</td>
			</tr>


			<%
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
				Date currentTime = new Date();//得到当前系统时间
				String pDwDate = formatter.format(currentTime); //将日期时间格式化
			%>
			<tr>
				<td>提款日期</td>
				<td><input type="text" id="pDwDate" name="pDwDate"
					value="<%=pDwDate%>" /><br />格式：yyyyMMdd</td>
			</tr>


			<tr>
				<td>提款金额</td>
				<td><input type="text" id="pTrdAmt" name="pTrdAmt" value="100.00" /></td>
			</tr>
			<tr>
				<td>平台手续费</td>
				<td><input type="text" id="pMerFee" name="pMerFee" value="1.00" /></td>
			</tr>
			<tr>
				<td>IPS手续费收取方</td>
				<td><input type="text" id="pIpsFeeType" name="pIpsFeeType" value="1" />
				<br />这里是IPS收取的费用1：平台支付 2：提款方支付</td>
			</tr>
			<tr>
				<td>浏览器返回地址</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl" value="<%=Config.pWebUrl %>" style="width:99%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl" value="<%=Config.pS2SUrl %>" style="width:99%;"/></td>
			</tr>
			<tr>
				<td>备注1</td>
				<td><input type="text" id="pMemo1" name="pMemo1" value="备注1" /></td>
			</tr>
			<tr>
				<td>备注2</td>
				<td><input type="text" id="pMemo2" name="pMemo2" value="备注2" /></td>
			</tr>
			<tr>
				<td>备注3</td>
				<td><input type="text" id="pMemo3" name="pMemo3" value="备注3" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" ><input type="submit" value="申&nbsp;&nbsp;请" /></td>
			</tr>
			<tr>
				<td colspan="2">手动修改报文信息
					<textarea rows="7" cols="100%" id="txtXml"></textarea>
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
			var txtXml= "<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
		        "<pReq>" +
		             "<pMerBillNo>" + document.getElementById("pMerBillNo").value + "</pMerBillNo>" +
		             "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>" +
		             "<pOutType>" + document.getElementById("pOutType").value + "</pOutType>" +
		             "<pBidNo>" + document.getElementById("pBidNo").value + "</pBidNo>" +
		             "<pContractNo>" + document.getElementById("pContractNo").value + "</pContractNo>" +
		             "<pDwTo>" + document.getElementById("pDwTo").value + "</pDwTo>" +
		             "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
		             "<pRealName>" + document.getElementById("pRealName").value + "</pRealName>" +
		             "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>" +
		             "<pDwDate>" + document.getElementById("pDwDate").value + "</pDwDate>" +
		             "<pTrdAmt>" + document.getElementById("pTrdAmt").value + "</pTrdAmt>" +
		             "<pMerFee>" + document.getElementById("pMerFee").value + "</pMerFee>" +
		             "<pIpsFeeType>" + document.getElementById("pIpsFeeType").value + "</pIpsFeeType>" +
		             "<pWebUrl>" + document.getElementById("pWebUrl").value + "</pWebUrl>" +
		             "<pS2SUrl>" + document.getElementById("pS2SUrl").value + "</pS2SUrl>" +
		             "<pMemo1>" + document.getElementById("pMemo1").value + "</pMemo1>" +
		             "<pMemo2>" + document.getElementById("pMemo2").value + "</pMemo2>" +
		             "<pMemo3>" + document.getElementById("pMemo3").value + "</pMemo3>" +
		       "</pReq>";
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
		post('DoSTTrade', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登记债权人</title>
</head>
<body>
	<form action="RegisterCreditor" method="post" target="_blank">
		
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>登记债权人</b></td>
			</tr>
			<tr>
				<td style="width: 50%">商户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /></td>
			</tr>
			<tr>
				<td>商户订单号</td>
				<td><input type="text" id="pMerBillNo"
					name="pMerBillNo" value="000001" /></td>
			</tr>
			<tr>
				<td>商户日期</td>
				<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pMerDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" id="pMerDate" name="pMerDate" value="<%=pMerDate %>"/></td>
			</tr>
			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo" name="pBidNo"
					value="" /><br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>
			<tr>
				<td>合同号</td>
				<td><input type="text" id="pContractNo"
					name="pContractNo" value="CON00001" /><br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>
			<tr>
				<td>登记方式</td>
				<td><input type="text" id="pRegType"
					name="pRegType" value="1" /> <br /> 1：手动投标  2：自动投标</td>
			</tr>
			<tr>
				<td>授权号</td>
				<td><input type="text" id="pAuthNo"
					name="pAuthNo" value="1" /> <br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>
			<tr>
				<td>债权面额</td>
				<td><input type="text" id="pAuthAmt" name="pAuthAmt"
					value="100.00" /><br />金额单位元，不能为负，不允许为0</td>
			</tr>
			<tr>
				<td>交易金额</td>
				<td><input type="text" id="pTrdAmt" name="pTrdAmt" value="100.00"/></td>
			</tr>
			<tr>
				<td>手续费</td>
				<td><input type="text" id="pFee" name="pFee" value="1.00"/><br />金额单位元，不能为负，不允许为0</td>
			</tr>
			<tr>
				<td>账号类型</td>
				<td><input type="text" id="pAcctType" name="pAcctType"
					value="1" /> <br />0#机构；1#个人</td>
			</tr>
			<tr>
				<td style="height: 32px">证件号码</td>
				<td style="height: 32px"><input type="text" id="pIdentNo"
					name="pIdentNo" value="410621198501222222" /><br />真实身份证（个人）/企业机构号（商户）</td>
			</tr>
			<tr>
				<td>投资人姓名</td>
				<td><input type="text" id="pRealName" name="pRealName"
					value="郑小亮" /></td>
			</tr>
			<tr>
				<td>投资人账号</td>
				<td><input type="text" id="pAccount" name="pAccount"
					value="4021000029936843" /> <br />账户类型为1时，IPS托管账户号（个人/商户）账户类型为0时，商户号</td>
			</tr>
			<tr>
				<td>借款用途</td>
				<td><input type="text" id="pUse" name="pUse"
					value="购材料" /></td>
			</tr>
			<tr>
				<td>浏览器返回地址</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl" 
				value="<%=Config.pWebUrl %>" style="width:100%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl" 
				value="<%=Config.pS2SUrl %>" style="width:100%;"/></td>
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
				<td colspan="2" align="center" ><input type="submit" value="提 post 交" /></td>
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
			var txtXml="<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
            "<pReq>" +
            "<pMerBillNo>" + document.getElementById("pMerBillNo").value + "</pMerBillNo>" +
            "<pMerDate>" + document.getElementById("pMerDate").value + "</pMerDate>" +
            "<pBidNo>" + document.getElementById("pBidNo").value + "</pBidNo>" +
            "<pContractNo>" + document.getElementById("pContractNo").value + "</pContractNo>" +
            "<pRegType>" + document.getElementById("pRegType").value + "</pRegType>" +
            "<pAuthNo>" + document.getElementById("pAuthNo").value + "</pAuthNo>" +
            "<pAuthAmt>" + document.getElementById("pAuthAmt").value + "</pAuthAmt>" +
            "<pTrdAmt>" + document.getElementById("pTrdAmt").value + "</pTrdAmt>" +
            "<pFee>" + document.getElementById("pFee").value + "</pFee>" +
            "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>" +
            "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
            "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>" +
            "<pAccount>" + document.getElementById("pAccount").value + "</pAccount>" +
            "<pUse><![CDATA[" + document.getElementById("pUse").value + "]]></pUse>" +
            "<pWebUrl><![CDATA[" + document.getElementById("pWebUrl").value + "]]></pWebUrl>" +
            "<pS2SUrl><![CDATA[" + document.getElementById("pS2SUrl").value + "]]></pS2SUrl>" +
            "<pMemo1><![CDATA[" + document.getElementById("pMemo1").value + "]]></pMemo1>" +
            "<pMemo2><![CDATA[" + document.getElementById("pMemo2").value + "]]></pMemo2>" +
            "<pMemo3><![CDATA[" + document.getElementById("pMemo3").value + "]]></pMemo3>" +
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
		post('RegisterCreditor', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
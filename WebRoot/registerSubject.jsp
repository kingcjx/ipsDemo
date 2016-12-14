<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>标的登记</title>
</head>
<body>
	<form action="RegisterSubject" method="post" target="_blank" target="_blank">
		
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>标的登记(POST)</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /><br/>由IPS颁发的商户号</td>
			</tr>
			<tr>
				<td>商户订单号</td>
				<%
				SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
				Date currentTime0 = new Date();//得到当前系统时间
				String pMerBillNo = "MER"+formatter0.format(currentTime0); //将日期时间格式化
				String pBidNo=formatter0.format(currentTime0);
				%>
				<td><input type="text" id="pMerBillNo"
					name="pMerBillNo" value="<%=pMerBillNo %>" /><br/>商户系统唯一不重复</td>
			</tr>
			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo"
					name="pBidNo" value="<%=pBidNo %>" /><br/>标的号，商户系统唯一不重复</td>
			</tr>
			<tr>
				<td>商户日期</td>
				<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pRegDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" id="pRegDate" name="pRegDate" value="<%=pRegDate %>" /><br/>格式：YYYYMMDD</td>
			</tr>
			<tr>
				<td>借款金额</td>
				<td><input type="text" id="pLendAmt" name="pLendAmt"
					value="100.00" /></td>
			</tr>
			<tr>
				<td>借款保证金</td>
				<td><input type="text" id="pGuaranteesAmt" name="pGuaranteesAmt"
					value="2.00" /></td>
			</tr>
			<tr>
				<td>借款利率</td>
				<td><input type="text" id="pTrdLendRate"
					name="pTrdLendRate" value="45.12" />%<br />借款利率  &lt; 48%，例如：45.12%传入45.12</td>
			</tr>
			<tr>
				<td>借款周期类型</td>
				<td><input type="text" id="pTrdCycleType"
					name="pTrdCycleType" value="1" /> <br />借款周期类型，1：天；3：月；借款周期  &lt;= 5年</td>
			</tr>
			<tr>
				<td>借款周期值</td>
				<td><input type="text" id="pTrdCycleValue"
					name="pTrdCycleValue" value="1" /> <br />借款周期  &lt;= 5年。如果借款周期类型为天，则借款周期值 &lt;= 1800(360 * 5)；如果借款周期类型为月，则借款周期值&lt;= 60(12 * 5)</td>
			</tr>
			<tr>
				<td>借款用途</td>
				<td><input type="text" id="pLendPurpose" name="pLendPurpose"
					value="买材料" /></td>
			</tr>
			<tr>
				<td>还款方式</td>
				<td><input type="text" id="pRepayMode" name="pRepayMode" value="1"/>
				<br />1：等额本息，2：按月还息到期还本；3：等额本金；99：其他；	</td>
			</tr>
			<tr>
				<td>标的操作类型</td>
				<td><input type="text" id="pOperationType" name="pOperationType" value="1"/><br />标的操作类型，1：新增，2：结束</td>
			</tr>
			<tr>
				<td>借款人手续费</td>
				<td><input type="text" id="pLendFee" name="pLendFee"
					value="10.00" /></td>
			</tr>
			<tr>
				<td>账户类型</td>
				<td><input type="text" id="pAcctType" name="pAcctType"
					value="1" /> <br />0#机构（暂未开放）；1#个人</td>
			</tr>
			<tr>
				<td>证件号码</td>
				<td><input type="text" id="pIdentNo" name="pIdentNo"
					value="410621198406155011" /> <br />真实身份证（个人）/企业机构号（商户）</td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input type="text" id="pRealName" name="pRealName"
					value="郑二亮" /></td>
			</tr>
			<tr>
				<td>IPS账号</td>
				<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo"
					value="4021000029937027" /> <br />账户类型为1时，IPS托管账户号（个人/商户）账户类型为0时，商户号</td>
			</tr>
			<tr>
				<td>浏览器返回地址</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl" value="<%=Config.pWebUrl %>" style="width:99%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl"  value="<%=Config.pS2SUrl %>" style="width:99%;"/></td>
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
					<textarea rows="8" cols="100%" id="txtXml"></textarea>
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
            "<pBidNo>" + document.getElementById("pBidNo").value + "</pBidNo>" +
            "<pRegDate>" + document.getElementById("pRegDate").value + "</pRegDate>" +
            "<pLendAmt>" + document.getElementById("pLendAmt").value + "</pLendAmt>" +
            "<pGuaranteesAmt>" + document.getElementById("pGuaranteesAmt").value + "</pGuaranteesAmt>" +
            "<pTrdLendRate>" + document.getElementById("pTrdLendRate").value + "</pTrdLendRate>" +
            "<pTrdCycleType>" + document.getElementById("pTrdCycleType").value + "</pTrdCycleType>" +
            "<pTrdCycleValue>" + document.getElementById("pTrdCycleValue").value + "</pTrdCycleValue>" +
            "<pLendPurpose><![CDATA[" + document.getElementById("pLendPurpose").value + "]]></pLendPurpose>" +
            "<pRepayMode>" + document.getElementById("pRepayMode").value + "</pRepayMode>" +
            "<pOperationType>" + document.getElementById("pOperationType").value + "</pOperationType>" +
            "<pLendFee>" + document.getElementById("pLendFee").value + "</pLendFee>" +
            "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>" +
            "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
            "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>" +
            "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>" +
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
		post('RegisterSubject', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
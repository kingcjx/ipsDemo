<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登记担保人</title>
</head>
<body>
	<form action="RegisterGuarantor" method="post" target="_blank">
		
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>登记担保人</b></td>
			</tr>
			<tr>
				<td style="width: 50%">商户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /></td>
			</tr>
			<tr>
				<td>商户订单号</td>
				<%
				TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
				TimeZone.setDefault(tz);
				SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
				Date currentTime0 = new Date();//得到当前系统时间
				String pMerBillNo = "MERG"+formatter0.format(currentTime0); //将日期时间格式化
				String pBidNo=formatter0.format(currentTime0);
				%>
				<td><input type="text" id="pMerBillNo"
					name="pMerBillNo" value="<%=pMerBillNo %>" /><br />商户系统唯一不重复</td>
			</tr>
			<tr>
				<td>商户日期</td>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pMerDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" id="pMerDate" name="pMerDate" value="<%=pMerDate %>"/><br />格式：yyyyMMdd</td>
			</tr>
			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo"
					name="pBidNo" value="" /><br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>
			<tr>
				<td>担保金额</td>
				<td><input type="text" id="pAmount" name="pAmount"
					value="100.00" /><br />金额单位元，不能为负，不允许为0</td>
			</tr>
			<tr>
				<td>担保保证金</td>
				<td><input type="text" id="pMarginAmt" name="pMarginAmt"
					value="2.00" /></td>
			</tr>
			<tr>
				<td>担保收益</td>
				<td><input type="text" id="pProFitAmt"
					name="pProFitAmt" value="10.00" /></td>
			</tr>
			<tr>
				<td>担保方类型</td>
				<td><input type="text" id="pAcctType"
					name="pAcctType" value="1" /> <br />0#机构；1#个人 </td>
			</tr>
			<tr>
				<td>担保方证件号码</td>
				<td><input type="text" id="pFromIdentNo"
					name="pFromIdentNo" value="410621198501222222" /> <br />0#机构；1#个人 
					<br/>针对担保方类型为1时：真实身份证（个人）
                    <br/>针对担保方类型为0时：由IPS颁发的商户号
				</td>
			</tr>
			<tr>
				<td>担保方账户姓名</td>
				<td><input type="text" id="pAccountName"
					name="pAccountName" value="郑小亮" /><br />担保方账户真实姓名</td>
			</tr>
			<tr>
				<td>担保方账户</td>
				<td><input type="text" id="pAccount" name="pAccount"
					value="4021000029936843" /> <br /></td>
			</tr>
			<tr>
				<td>结果成功返回的商户URL</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl" value="<%=Config.pWebUrl %>" style="width:100%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl" value="<%=Config.pS2SUrl %>" style="width:100%;"/></td>
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
					<textarea rows="6" cols="100%" id="txtXml"></textarea>
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
            "<pAmount>" + document.getElementById("pAmount").value + "</pAmount>" +
            "<pMarginAmt>" + document.getElementById("pMarginAmt").value + "</pMarginAmt>" +
            "<pProFitAmt>" + document.getElementById("pProFitAmt").value + "</pProFitAmt>" +
            "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>" +
            "<pFromIdentNo>" + document.getElementById("pFromIdentNo").value + "</pFromIdentNo>" +
            "<pAccountName><![CDATA[" + document.getElementById("pAccountName").value + "]]></pAccountName>" +
            "<pAccount>" + document.getElementById("pAccount").value + "</pAccount>" +
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
		post('RegisterGuarantor', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
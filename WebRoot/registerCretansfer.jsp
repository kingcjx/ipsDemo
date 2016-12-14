<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" language="java" 
	import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登记债权转让</title>
</head>
<body>
	<form action="RegisterCretansfer" method="post" target="_blank">

		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>登记债权转让</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账号</td>
				<td style="width: 50%"><input type="text" name="pMerCode" value="808801" id="pMerCode" />
				<br/>由IPS颁发的商户号</td>
			</tr>
			<tr>
				<td>商户订单号</td>
				<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat transformat = new SimpleDateFormat("yyyyMMddHHmmss");
					Date currentTime = new Date();//得到当前系统时间
					String pMerBillNo = "MERC"+transformat.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" name="pMerBillNo" value="<%=pMerBillNo %>" id="pMerBillNo" />
				<br/>商户系统唯一不重复</td>
			</tr>
			<tr>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentDate = new Date();//得到当前系统时间
					String pMerDate = formatter.format(currentDate); //将日期时间格式化
				%>
				<td>商户日期</td>
				<td><input type="text" name="pMerDate" value="<%=pMerDate%>" id="pMerDate" />
				<br/>格式：YYYYMMDD</td>
			</tr>
			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo" name="pBidNo"
					value="BID0001" /><br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>
			<tr>
				<td>合同号</td>
				<td><input type="text" id="pContractNo"
					name="pContractNo" value="CON0001" /><br />字母和数字，如a~z,A~Z,0~9</td>
			</tr>

			<tr>
				<td>出让方账户类型</td>
				<td><input type="text" id="pFromAccountType" name="pFromAccountType" value="1" />
				<br/>1：个人 0：机构</td>
			</tr>
			<tr>
				<td>出让方账户姓名</td>
				<td><input type="text" id="pFromName" name="pFromName" value="债权人小一" />
				<br/>出让方账户真实姓名</td>
			</tr>
			<tr>
				<td>出让方账户</td>
				<td><input type="text" id="pFromAccount" name="pFromAccount" value="4021000014719788"/>
				<br />出让方账户类型为1时，IPS托管账户号（个人/商户）出让方账户类型为0时，商户号
				</td>
			</tr>
			<tr>
				<td>出让方证件类型</td>
				<td><input type="text" id="pFromIdentType" name="pFromIdentType" value="1"/>
				<br />出让方证件类型 1#身份证，默认：1
				</td>
			</tr>
			<tr>
				<td>出让方证件号码</td>
				<td><input type="text" id="pFromIdentNo" name="pFromIdentNo" value="310101199102172011"/>
				<br/>出让方证件号码 真实身份证（个人）</td>
			</tr>
			<tr>
			<td>受让方账户类型</td>
				<td><input type="text" id="pToAccountType" name="pToAccountType" value="1"/>
				<br/> 1：个人 0：机构</td>
			</tr>
			<tr>
				<td>受让方账户姓名</td>
				<td><input type="text" id="pToAccountName" name="pToAccountName"
					value="债权人小二" /></td>
			</tr>
			<tr>
				<td>受让方账户</td>
				<td><input type="text" id="pToAccount" name="pToAccount" value="4021000014719996"/>
					<br />受让方账户类型为1时，IPS托管账户号（个人/商户）受让方账户类型为0时，商户号</td>
			</tr>
			<tr>
				<td>受让方证件类型</td>
				<td><input type="text" id="pToIdentType" name="pToIdentType" value="1" />
				<br />受让方证件类型 1#身份证，默认：1
				</td>
			</tr>
			<tr>
				<td>受让方证件号码</td>
				<td><input type="text" id="pToIdentNo" name="pToIdentNo" value="310101199102172011" />
				<br/>受让方证件号码 真实身份证（个人）</td>
			</tr>

			<tr>
				<td>登记债权人时提交的订单号</td>
				<td><input type="text" id="pCreMerBillNo" name="pCreMerBillNo" value=""/>
				<br />字母和数字，如a~z,A~Z,0~9 登记债权人时提交的订单号
				</td>
			</tr>
			<tr>
				<td>债权面额</td>
				<td><input type="text" id="pCretAmt" name="pCretAmt" value="100.00"/>
				<br />金额单位元，不能为负，不允许为0
				</td>
			</tr>
			<tr>
				<td>支付金额</td>
				<td><input type="text" id="pPayAmt" name="pPayAmt" value="101.00"/>
				<br />金额单位元，不能为负，不允许为0 债权面额（1-30%） &lt;=  支付金额  &lt;=  债权面额（1+30%）
				</td>
			</tr>
			<tr>
			<td>出让方手续费</td>
				<td><input type="text" id="pFromFee" name="pFromFee" value="1.00" />
				<br/>金额单位元，不能为负，不允许为0</td>
			</tr>
			<tr>
				<td>受让方手续费</td>
				<td><input type="text" id="pToFee" name="pToFee" value="1.00" />
				<br/>金额单位元，不能为负，不允许为0</td>
			</tr>
			<tr>
				<td>转让类型</td>
				<td><input type="text" id="pCretType" name="pCretType"
					value="1" />
					<br />1：全部转让 2：部分转让</td>
			</tr>
			<tr>
				<td>结果成功返回的商户URL</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl"
					value="<%=Config.pWebUrl %>"  style="width:100%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl"
					value="<%=Config.pS2SUrl %>" style="width:100%;"/></td>
			</tr>
			<tr>
				<td>备注1</td>
				<td><input type="text" id="pMemo1" name="pMemo1" value="备注1"/></td>
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
					<textarea rows="10" cols="100%" id="txtXml"></textarea>
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
            "<pFromAccountType>" + document.getElementById("pFromAccountType").value + "</pFromAccountType>" +
            "<pFromName><![CDATA[" + document.getElementById("pFromName").value + "]]></pFromName>" +
            "<pFromAccount>" + document.getElementById("pFromAccount").value + "</pFromAccount>" +
            "<pFromIdentType>" + document.getElementById("pFromIdentType").value + "</pFromIdentType>" +
            "<pFromIdentNo>" + document.getElementById("pFromIdentNo").value + "</pFromIdentNo>" +
            "<pToAccountType>" + document.getElementById("pToAccountType").value + "</pToAccountType>" +
            "<pToAccountName><![CDATA[" + document.getElementById("pToAccountName").value + "]]></pToAccountName>" +
            "<pToAccount>" + document.getElementById("pToAccount").value + "</pToAccount>" +
            "<pToIdentType>" + document.getElementById("pToIdentType").value + "</pToIdentType>" +
            "<pToIdentNo>" + document.getElementById("pToIdentNo").value + "</pToIdentNo>" +
             "<pCreMerBillNo>" + document.getElementById("pCreMerBillNo").value + "</pCreMerBillNo>" +
            "<pCretAmt>" + document.getElementById("pCretAmt").value + "</pCretAmt>" +
            "<pPayAmt>" + document.getElementById("pPayAmt").value + "</pPayAmt>" +
            "<pFromFee>" + document.getElementById("pFromFee").value + "</pFromFee>" +
            "<pToFee>" + document.getElementById("pToFee").value + "</pToFee>" +
            "<pCretType>" + document.getElementById("pCretType").value + "</pCretType>" +
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
		post('RegisterCretansfer', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
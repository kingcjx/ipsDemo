<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" language="java" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自动还款签约</title>
</head>
<body>
	<form action="RepaymentSigning" method="post">
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>自动还款签约</b></td>
			</tr>
			<tr>
				<td style="width: 50%">商户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /></td>
			</tr>
			<tr>
			<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
					Date currentTime0 = new Date();//得到当前系统时间
					String pMerBillNo = "REPAYSI"+formatter0.format(currentTime0); //将日期时间格式化
			%>
				<td>商户签约订单号</td>
				<td><input type="text" id="pMerBillNo" name="pMerBillNo"
					value="<%=pMerBillNo %>" /></td>
			</tr>
			<tr>
				<td>签约日期</td>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pSigningDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" id="pSigningDate" name="pSigningDate" value="<%=pSigningDate%>"/></td>
			</tr>
			<tr>
				<td>证件类型 </td>
				<td><input type="text" id="pIdentType" name="pIdentType"
					value="1" />
				<br />1#身份证，默认：1</td>
			</tr>
			<tr>
				<td>借款人证件号码</td>
				<td style="height: 32px"><input type="text" id="pIdentNo"
					name="pIdentNo" value="410621198501222222" /></td>
			</tr>
			<tr>
				<td>借款人姓名</td>
				<td><input type="text" id="pRealName" name="pRealName"
					value="郑小亮" /></td>
			</tr>
			<tr>
				<td>借款人IPS账户号</td>
				<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo"
					value="4021000029936843" />
				<br /> 由IPS生成颁发的资金账号</td>
			</tr>
			<tr>
				<td>有效期类型 </td>
				<td><input type="text" id="pValidType" name="pValidType"
					value="N" />
				<br />D 代表天，M代表月，N 长期有效</td>
			</tr>
			<tr>
				<td>有效期 </td>
				<td><input type="text" id="pValidDate" name="pValidDate"
					value="0" />
				<br />D：以天计算有效期，数值范围1 – 365 任选
				<br />M：以月计算有效期，数值范围1 – 12任选 
				<br />N:  空值</td>
			</tr>

			<tr>
				<td>浏览器返回地址</td>
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
			var txtXml="<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
            "<pReq>" +
                  "<pMerBillNo>" + document.getElementById("pMerBillNo").value + "</pMerBillNo>" +
                  "<pSigningDate>" + document.getElementById("pSigningDate").value + "</pSigningDate>" +
                  "<pIdentType>" + document.getElementById("pIdentType").value + "</pIdentType>" +
                  "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
                  "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>" +
                  "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>" +
                  "<pValidType>" + document.getElementById("pValidType").value + "</pValidType>" +
                  "<pValidDate>" + document.getElementById("pValidDate").value + "</pValidDate>" +
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
		post('RepaymentSigning', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
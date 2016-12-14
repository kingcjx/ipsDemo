<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" language="java" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自动投标签约</title>
</head>
<body>
	<form action="AutoNewSigning" method="post" target="_blank">
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>自动投标签约</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /></td>
			</tr>
			<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
					Date currentTime0 = new Date();//得到当前系统时间
					String pMerBillNo = "TENDSI"+formatter0.format(currentTime0); //将日期时间格式化
			%>
			<tr>
				<td>商户签约订单号</td>
				<td><input type="text" id="pMerBillNo" name="pMerBillNo"
					value="<%=pMerBillNo %>" /></td>
			</tr>
			<tr>
				<td>商户签约日期</td>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pSigningDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td><input type="text" id="pSigningDate" name="pSigningDate" value="<%=pSigningDate%>"/></td>
			</tr>
			<tr>
				<td>债权人证件号码</td>
				<td style="height: 32px"><input type="text" id="pIdentNo"
					name="pIdentNo" value="410621198501222222" /></td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input type="text" id="pRealName" name="pRealName"
					value="郑小亮" /></td>
			</tr>
			<tr>
				<td>债权人IPS账户号</td>
				<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo"
					value="4021000029936843" />
				<br /> 账户类型为1时，IPS账号; 账户类型为0时，平台账号</td>
			</tr>
			<tr>
				<td>有效期类型 </td>
				<td><input type="text" id="pValidType" name="pValidType" value="D" />
				<br />D#代表天;M#代表月</td>
			</tr>
			<tr>
				<td>有效期 </td>
				<td><input type="text" id="pValidDate" name="pValidDate" value="180" />
				<br />D：以天计算有效期，数值范围1 – 365 任选 M：以月计算有效期，数值范围1 – 12任选</td>
			</tr>
			<tr>
				<td>标的借款周期类型 </td>
				<td><input type="text" id="pTrdCycleType" name="pTrdCycleType" value="D" />
					<br />D#代表天;M#代表月</td>
			</tr>
			<tr>
				<td>借款周期最小值</td>
				<td><input type="text" id="pSTrdCycleValue" name="pSTrdCycleValue" value="20"/>
				<br/>借款周期值（范围），根据pSTrdCycleValue 传入限制如下：
				<br/>D： 以天计算周期，数值范围 1 – 1800 任选
				<br/>M： 以月计算周期，数值范围1 – 60 任选
				</td>
			</tr>
			<tr>
				<td>借款周期最大值</td>
				<td><input type="text" id="pETrdCycleValue" name="pETrdCycleValue" value="40" />
				<br/>借款周期值（范围），根据pETrdCycleValue 传入限制如下：
				<br/>D： 以天计算周期，数值范围 1 – 1800 任选
				<br/>M： 以月计算周期，数值范围1 – 60 任选
				</td>
			</tr>
			 <tr>
				<td>标的借款额度限额最小值</td>
				<td><input  type="text" id="pSAmtQuota" name="pSAmtQuota" value="100.00" />
				<br/>设置投资者认同标的借款额度范围。值都必须 &gt;=1.00 格式要求如：整数104.00 带小数104.23</td>
			</tr>
			<tr>
				<td>标的借款额度限额最大值</td>
				<td><input type="text" id="pEAmtQuota" name="pEAmtQuota" value="1000.00" />
				<br/>设置投资者认同标的借款额度范围。值都必须 &gt;=1.00 格式要求如：整数104.00 带小数104.23</td>
			</tr>
			<tr>
				<td>标的利率限额最小值</td>
				<td><input type="text" id="pSIRQuota" name="pSIRQuota" value="23.12" />%
				<br />百分比，设置标的回报利率范围。值都必须 &gt;=1.00 只需传入数值，%号不传入。 如： 23.12% 只传入 23.12 </td>
			</tr>
			<tr>
				<td>标的利率限额最大值</td>
				<td><input type="text" id="pEIRQuota" name="pEIRQuota" value="34.28" />%
				<br />百分比，设置标的回报利率范围。值都必须 &gt;=1.00 只需传入数值，%号不传入。 如： 23.12% 只传入 23.12 </td>
			</tr>
			<tr>
				<td>结果成功返回的商户URL</td>
				<td><input type="text" id="pWebUrl" name="pWebUrl" value="<%=Config.pWebUrl %>" style="width:98%" /></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" id="pS2SUrl" name="pS2SUrl" value="<%=Config.pS2SUrl %>" style="width:98%" /></td>
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
                  "<pSigningDate>" + document.getElementById("pSigningDate").value + "</pSigningDate>" +
                  "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
                  "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>" +
                  "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>" +
                  "<pValidType>" + document.getElementById("pValidType").value + "</pValidType>" +
                  "<pValidDate>" + document.getElementById("pValidDate").value + "</pValidDate>" +
                  "<pTrdCycleType>" + document.getElementById("pTrdCycleType").value + "</pTrdCycleType>" +
                  "<pSTrdCycleValue><![CDATA[" + document.getElementById("pSTrdCycleValue").value +"]]></pSTrdCycleValue>" +
                  "<pETrdCycleValue><![CDATA[" + document.getElementById("pETrdCycleValue").value +"]]></pETrdCycleValue>" +
                  "<pSAmtQuota><![CDATA[" + document.getElementById("pSAmtQuota").value +"]]></pSAmtQuota>" +
                  "<pEAmtQuota><![CDATA[" + document.getElementById("pEAmtQuota").value +"]]></pEAmtQuota>" +
                  "<pSIRQuota><![CDATA[" + document.getElementById("pSIRQuota").value +"]]></pSIRQuota>" +
                  "<pEIRQuota><![CDATA[" + document.getElementById("pEIRQuota").value +"]]></pEIRQuota>" +
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
		post('AutoNewSigning', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
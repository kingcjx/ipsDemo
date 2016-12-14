<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*,java.text.*,ToolClass.Config" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>开户</title>
</head>

<body>
	4.2开户(POST)
	债权人戒借款人以个人名义在“平台”开户，“平台”将开户信息发给环迅支付，由环迅支付开通 IPS个人账户。环迅支付提供接口，由“供应商”实现系统调用。  
	<br>
	<form action="CreateNewIpsAcct" method="post" target="_blank">
		<table border="1" cellspacing="0" cellpadding="3" style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;" align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>开户</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账号</td>
				<td style="width: 50%"><input type="text" name="pMerCode" value="808801" id="pMerCode" /><br/>由IPS颁发的商户号</td>
			</tr>
			<tr>
				<td>商户开户流水号</td>
				<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
					Date currentTime0 = new Date();//得到当前系统时间
					String pMerBillNo = "PACT"+formatter0.format(currentTime0); //将日期时间格式化
				%>
				<td>
					<input type="text" name="pMerBillNo" value="<%=pMerBillNo %>" id="pMerBillNo" /><br/>商户系统唯一不重复
				</td>
			</tr>
			<tr>
				<td>证件类型</td>
				<td>
					<input type="text" name="pIdentType" value="1" id="pIdentType" /><br/>1#身份证，默认：1
				</td>
			</tr>
			<tr>
				<td>证件号码</td>
				<td>
					<input type="text" name="pIdentNo" value="410621198406155011" id="pIdentNo" /></td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input type="text" name="pRealName" value="环迅"
					id="pRealName" /></td>
			</tr>
			<tr>
				<td>手机号</td>
				<td><input type="text" name="pMobileNo" value="18621748780"
					id="pMobileNo" /></td>
			</tr>
			<tr>
				<td>注册邮件</td>
				<td><input type="text" name="pEmail" value="lzheng@ips.com.cn"
					id="pEmail" /></td>
			</tr>
			<tr>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String pSmDate = formatter.format(currentTime); //将日期时间格式化
				%>
				<td>提交日期</td>
				<td><input type="text" name="pSmDate" value="<%=pSmDate%>"
					id="pSmDate" /><br/>时间格式“yyyyMMdd”, 商户提交日期。</td>
			</tr>
			<!-- http://192.168.1.234:8101/test.aspx -->
			<tr>
				<td>结果成功返回的商户URL</td>
				<td><input type="text" name="pWebUrl"
					value="<%=Config.pWebUrl %>" id="pWebUrl" style="width:99%;"/></td>
			</tr>
			<tr>
				<td>S2S返回地址</td>
				<td><input type="text" name="pS2SUrl"
					value="<%=Config.pS2SUrl %>" id="pS2SUrl" style="width:99%;"/></td>
			</tr>
			<tr>
				<td>备注1</td>
				<td><input type="text" name="pMemo1" value="备注1" id="pMemo1" /></td>
			</tr>
			<tr>
				<td>备注2</td>
				<td><input type="text" name="pMemo2" value="备注2" id="pMemo2" /></td>
			</tr>
			<tr>
				<td>备注3</td>
				<td><input type="text" name="pMemo3" value="备注3" id="pMemo3" /></td>
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
                  "<pIdentType>" + document.getElementById("pIdentType").value + "</pIdentType>" +
                  "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
                  "<pRealName><![CDATA[" + document.getElementById("pRealName").value + "]]></pRealName>" +
                  "<pMobileNo>" + document.getElementById("pMobileNo").value + "</pMobileNo>" +
                  "<pEmail>" + document.getElementById("pEmail").value + "</pEmail>" +
                  "<pSmDate>" + document.getElementById("pSmDate").value + "</pSmDate>" +
                  "<pWebUrl ><![CDATA[" + document.getElementById("pWebUrl").value + "]]></pWebUrl >" +
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
		post('CreateNewIpsAcct', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
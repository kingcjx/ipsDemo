<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解冻保证金</title>
</head>
<body>
	<form action="GuaranteeUnfreeze" method="post">
			<table border="1" cellspacing="0" cellpadding="3"
				style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
				align="center">
				<tr style="background-color: #8070FF; color: #FFFF00">
					<td colspan="2" align="Center"><b>解冻保证金(WS)</b></td>
				</tr>
				<tr>
					<td style="width: 50%">平台账号</td>
					<td style="width: 50%"><input type="text" id="pMerCode"
						name="pMerCode" value="808801" /><br />由IPS颁发的商户号</td>
				</tr>
				<tr>
					<td>商户订单号</td>
					<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz); 
					%>
					<%
						SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
						Date currentTime0 = new Date();//得到当前系统时间
						String pMerBillNo="MER"+formatter0.format(currentTime0)+"12";
						
					%>
					<td><input type="text" id="pMerBillNo" name="pMerBillNo" value="<%=pMerBillNo%>"/></td>
				</tr>
				<tr>
					<td>标的号：</td>
					<td><input type="text" id="pBidNo" name="pBidNo" value="" />
					<br/>标的号，商户系统唯一不重复</td>
				</tr>
				<tr>
					<td>解冻日期：</td>
					<%
						SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
						Date currentTime1 = new Date();//得到当前系统时间
						String pUnfreezeDate = formatter1.format(currentTime1); //将日期时间格式化
					%>
					<td><input type="text" id="pUnfreezeDate" name="pUnfreezeDate"
						value="<%=pUnfreezeDate %>" /><br />格式：YYYYMMDD</td>
				</tr>
				<tr>
					<td>解冻金额：</td>
					<td><input type="text" id="pUnfreezeAmt" name="pUnfreezeAmt" value="" />
					<br/>金额单位，不能为负，不允许为0；解冻金额&lt;=当时冻结时的保证金</td>
				</tr>
				<tr>
					<td>解冻类型：</td>
					<% String pUnfreezenType=request.getParameter("pUnfreezenType"); %>
					<td><input type="text" id="pUnfreezenType" name="pUnfreezenType" value="<%= pUnfreezenType==null ? "":pUnfreezenType%>" />
					<br/>1#解冻借款方；2#解冻担保方</td>
				</tr>
				<tr>
					<td>解冻者账户类型：</td>
					<td><input type="text" id="pAcctType" name="pAcctType" value="" />
					<br/>0#机构（暂未开放）；1#个人</td>
				</tr>
				<tr>
					<td>解冻者证件号码：</td>
					<td><input type="text" id="pIdentNo" name="pIdentNo" value="" />
					<br/>真实身份证（个人）/企业机构号（商户）</td>
				</tr>
				<tr>
					<td>解冻者姓名：</td>
					<td><input type="text" id="pRealName" name="pRealName" value="" />
					<br/>真实姓名（中文）
					</td>
				</tr>
				<tr>
					<td>解冻者IPS账号：</td>
					<td><input type="text" id="pIpsAcctNo" name="pIpsAcctNo" value="" />
					<br/>账户类型为1时，IPS托管账户号（个人/商户）账户类型为0时，商户号</td>
				</tr>
				<tr>
					<td>异步返回地址2</td>
					<td><input type="text" id="pS2SUrl" name="pS2SUrl"
						value="<%=Config.pS2SUrl %>"
						style="width: 99%;" />异步返回地址</td>
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
					<td colspan="2" align="center"><input type="submit" value="提交(WS)"/></td>
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
					<textarea rows="4" cols="100%" id="txtXml"></textarea>
				</td>
			</tr>
			<!-- 
			<tr>
				<td>MD5</td>
				<td><input type="text" id="pSign" style="width: 99%;" />
					<br/>MD5(pMerCode+p3DesXmlPara+Ips证书)取32位小写 “+”此处仅表示字符串拼接此处若不填，则默认是对上面报文加密的MD5，若填写，则用填写的内容当做签名
				</td>
			</tr>
			 -->
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
            "<pUnfreezeDate>" + document.getElementById("pUnfreezeDate").value + "</pUnfreezeDate>" +
            "<pUnfreezeAmt>" + document.getElementById("pUnfreezeAmt").value + "</pUnfreezeAmt>" +
            "<pUnfreezenType>" + document.getElementById("pUnfreezenType").value + "</pUnfreezenType>" +
            "<pAcctType>" + document.getElementById("pAcctType").value + "</pAcctType>" +
            "<pIdentNo>" + document.getElementById("pIdentNo").value + "</pIdentNo>" +
            "<pRealName>" + document.getElementById("pRealName").value + "</pRealName>" +
            "<pIpsAcctNo>" + document.getElementById("pIpsAcctNo").value + "</pIpsAcctNo>" +
            "<pS2SUrl><![CDATA[" + document.getElementById("pS2SUrl").value + "]]></pS2SUrl>" +
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
		post('GuaranteeUnfreeze', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
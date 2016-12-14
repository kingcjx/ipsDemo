<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>还款</title>
</head>
<body>
	<form action="RepaymentNewTrade" method="post" target="_blank">
		
		<table border="1" cellspacing="0" cellpadding="3"
			style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
			align="center">
			<tr style="background-color: #8070FF; color: #FFFF00">
				<td colspan="2" align="Center"><b>还款（POST）</b></td>
			</tr>
			<tr>
				<td style="width: 50%">平台账户号</td>
				<td style="width: 50%"><input type="text" id="pMerCode" name="pMerCode"
					value="808801" /><br/>由IPS颁发的商户号</td>
			</tr>
			<tr>
				<td>标的号</td>
				<td><input type="text" id="pBidNo"
					name="pBidNo" value="000001" /></td>
			</tr>
				<%
					TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
					TimeZone.setDefault(tz);
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
					Date currentTime = new Date();//得到当前系统时间
					String repaymentDate = formatter.format(currentTime); //将日期时间格式化
				%>
			<tr>
				<td>还款日期</td>
				<td><input type="text" id="pRepaymentDate"
					name="pRepaymentDate" value="<%=repaymentDate %>" /></td>
			</tr>
			<tr>
				<td>商户还款订单号</td>
				<%
				SimpleDateFormat formatter0 = new SimpleDateFormat("yyyyMMddHHmmss");
				Date currentTime0 = new Date();//得到当前系统时间
				String pMerBillNo = "PREP"+formatter0.format(currentTime0); //将日期时间格式化
				%>
				<td><input type="text" id="pMerBillNo"
					name="pMerBillNo" value="<%=pMerBillNo %>" /></td>
			</tr>
			<tr>
				<td>还款类型</td>
				<td><input type="text" id="pRepayType" name="pRepayType"
					value="1" /><br/> 	还款类型，1#手动还款，2#自动还款</td>
			</tr>
			<tr>
				<td>授权号</td>
				<td><input type="text" id="pIpsAuthNo" name="pIpsAuthNo"
					value="" /><br/>当还款类型为自动还款时不为空，为手动还款时为空</td>
			</tr>
			<tr>
				<td>转出方IPS账号</td>
				<td><input type="text" id="pOutAcctNo" name="pOutAcctNo"
					value="4021000014719572" /><br/>借款人在IPS注册的资金托管账号</td>
			</tr>
			<tr>
				<td>转出金额</td>
				<td><input type="text" id="pOutAmt" name="pOutAmt"
					value="100.00" />
					<br/>表示此次个还款总金额。 转出金额=Sum(pInAmt) Sum:此处代表合计，一个或多个投资人时的还款金额的累加。 金额单位：元，不能为负，不允许为0，保留2位小数； 格式：12.00 </td>
			</tr>
			<tr>
				<td>转出方总手续费</td>
				<td><input type="text" id="pOutFee" name="pOutFee"
					value="12.00" />
					<br/>表示此次还款借款人所承担的还款手续费，此手续费由商户平台收取，IPS为商户平台代收。 金额单位：元，不能为负，允许为0，保留2位小数； 格式：12.00 pOutFee = Sum(pOutInfoFee) </td>
			</tr>
			<tr>
                <td>转入方-批量</td>
                <td>
                <textarea id="pDetails" name="pDetails" 
                rows="5" cols="50%">&lt;pRow&gt;&lt;pCreMerBillNo&gt;string&lt;/pCreMerBillNo&gt;&lt;pInAcctNo&gt;转入方IPS托管账户号&lt;/pInAcctNo&gt;&lt;pInFee&gt;1.00&lt;/pInFee&gt;&lt;pOutInfoFee&gt;12.00&lt;/pOutInfoFee&gt;&lt;pInAmt&gt;100.00&lt;/pInAmt&gt;&lt;/pRow&gt;</textarea>
                <br/>&lt;pDetails&gt;转入方-批量，转出方一次最大300限制&lt;/pDetails&gt; （&lt;pRow&gt; 此标签内只包含一笔传出方明细信息，如批量此标签为多个）
				</td>
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
			var txtXml= "<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
            "<pReq>" +
            "<pBidNo>" + document.getElementById("pBidNo").value + "</pBidNo>" +
            "<pRepaymentDate>" + document.getElementById("pRepaymentDate").value + "</pRepaymentDate>" +
            "<pMerBillNo>" + document.getElementById("pMerBillNo").value + "</pMerBillNo>" +
            "<pRepayType>" + document.getElementById("pRepayType").value + "</pRepayType>" +
            "<pIpsAuthNo>" + document.getElementById("pIpsAuthNo").value + "</pIpsAuthNo>" +
            "<pOutAcctNo>" + document.getElementById("pOutAcctNo").value + "</pOutAcctNo>" +
            "<pOutAmt>" + document.getElementById("pOutAmt").value + "</pOutAmt>" +
            "<pOutFee>" + document.getElementById("pOutFee").value + "</pOutFee>" +
            "<pWebUrl><![CDATA[" + document.getElementById("pWebUrl").value + "]]></pWebUrl>" +
            "<pS2SUrl><![CDATA[" + document.getElementById("pS2SUrl").value + "]]></pS2SUrl>" +
            "<pDetails>" + document.getElementById("pDetails").value + "</pDetails>" +
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
		post('RepaymentNewTrade', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
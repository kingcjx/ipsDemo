<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.text.*,ToolClass.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>转账</title>
</head>
<body>
<form action="Transfer" method="post">
    <table border="1" cellspacing="0" cellpadding="3"
		style="background-color: #F0F0FF; text-align: left; vertical-align: middle; width: 784px;"
		align="center">
		<tr style="background-color: #8070FF; color: #FFFF00">
			<td colspan="2" align="Center"><b>转账（WS）</b></td>
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
           <td><input type="text" id="pMerBillNo" name="pMerBillNo" value="<%= pMerBillNo%>"/><br/>商户系统唯一不重复</td>
		</tr>
      <tr>
           <td>标的号</td>
           <td><input type="text" id="pBidNo" name="pBidNo" value="<%= pBidNo%>"/><br/>标的号，商户系统唯一不重复</td>
      </tr>
      <tr>
           <td>商户日期</td>
			<% 
			TimeZone tz = TimeZone.getTimeZone("GMT+08:00");
			TimeZone.setDefault(tz);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Date currentTime = new Date();//得到当前系统时间
			String pDate = formatter.format(currentTime); //将日期时间格式化
			%>
           <td><input type="text" id="pDate" name="pDate" value="<%=pDate %>"/><br/>格式：YYYYMMDD</td>
       </tr>
       <tr>
            <td>转账类型</td>
            <% String pTransferType=request.getParameter("pTransferType"); %>
            <td><input type="text" id="pTransferType" name="pTransferType" value="<%= pTransferType==null? "":pTransferType %>" /><br/>转账类型，1：投资， 2：代偿；3：代偿还款；4：债权转让；5：结算担保收益；</td>
        </tr>
        <tr>
            <td>转账方式</td>
            <td><input type="text" id="pTransferMode" name="pTransferMode" value="1"/><br/>转账方式(1：逐笔入账；2：批量入账)</td>
        </tr>
			<tr>
				<td>投资人信息</td>
				<td>
				<textarea rows="5" cols="50%" id="pDetails" 
					name="pDetails">&lt;pRow&gt;&lt;pOriMerBillNo&gt;string&lt;/pOriMerBillNo&gt;&lt;pTrdAmt&gt;string&lt;/pTrdAmt&gt;&lt;pFAcctType&gt;string&lt;/pFAcctType&gt;&lt;pFIpsAcctNo&gt;string&lt;/pFIpsAcctNo&gt;&lt;pFTrdFee&gt;string&lt;/pFTrdFee&gt;&lt;pTAcctType&gt;string&lt;/pTAcctType&gt;&lt;pTIpsAcctNo&gt;string&lt;/pTIpsAcctNo&gt;&lt;pTTrdFee&gt;string&lt;/pTTrdFee&gt;&lt;/pRow&gt;&lt;pRow&gt;&lt;pOriMerBillNo&gt;string&lt;/pOriMerBillNo&gt;&lt;pTrdAmt&gt;string&lt;/pTrdAmt&gt;&lt;pFAcctType&gt;string&lt;/pFAcctType&gt;&lt;pFIpsAcctNo&gt;string&lt;/pFIpsAcctNo&gt;&lt;pFTrdFee&gt;string&lt;/pFTrdFee&gt;&lt;pTAcctType&gt;string&lt;/pTAcctType&gt;&lt;pTIpsAcctNo&gt;string&lt;/pTIpsAcctNo&gt;&lt;pTTrdFee&gt;string&lt;/pTTrdFee&gt;&lt;/pRow&gt;</textarea>
				<br />&lt;pDetails&gt; &lt;pRow
					&gt;投资人信息，如下所示&lt;/pRow&gt;&lt;/pDetails&gt;
					&lt;pRow&gt;的个数必须小于等于3000</td>
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
			<tr><td colspan="2" align="center">
				<input type="submit" value="提交(WS)"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				返回结果<% String resultStr = (String)request.getAttribute("resultStr"); %>
				<textarea rows="10" cols="100%" id="resultStr" name="resultStr"><%= resultStr==null?"":resultStr%></textarea></td>
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
	            "<pBidNo>" + document.getElementById("pBidNo").value + "</pBidNo>" +
	            "<pDate>" + document.getElementById("pDate").value + "</pDate>" +
	            "<pTransferType>" + document.getElementById("pTransferType").value + "</pTransferType>" +
	            "<pTransferMode>" + document.getElementById("pTransferMode").value + "</pTransferMode>" +
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
		post('Transfer', {pMerCode:pMerCode,txtXml:document.getElementById("txtXml").value});
		};
	</script>
</body>
</html>
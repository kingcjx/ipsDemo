<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>P2P资金管理平台模拟提交导航</title>
<style type="text/css">
/*<![CDATA[*/
body,html {background-color: #CCE8CF;}
tr{height: 30px;}
#head {width:100%;height: 40px;text-align: center;font-size: xx-large;}
#left {width: 43%;height: 100%;float: left;}
#right {width: 57%;height: 100%;float: left;display: block;} 
/*]]>*/
</style>
<body>
</head>
<body>
	<div id="head">P2P资金管理平台模拟提交导航</div>
	<div id="left"></div>
	<div id="right">
		<table>
			<tr>
				<td><a href="createNewIpsAcct.jsp" target="_blank">（01）用户开户</a></td>
			</tr>
			<tr>
				<td><a href="registerSubject.jsp" target="_blank">（02）平台发布借款标(标的登记)</a></td>
			</tr>
			<tr>
				<td><a href="registerGuarantor.jsp" target="_blank">（03）担保方对标的担保(登记担保方)</a></td>
			</tr>
			<tr>
				<td><a href="registerCreditor.jsp" target="_blank">（04）投资人投标</a>
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="transfer.jsp?pTransferType=2" target="_blank">└─转账&lt;一次性放款&gt;</a>&nbsp;
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="transfer.jsp?pTransferType=1" target="_blank">└─转账&lt;随投随放&gt;</a></td>
			</tr>
			<tr>
				<td><a href="registerCretansfer.jsp" target="_blank">（05）个人债权转让(登记债权转让)</a>
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="transfer.jsp?pTransferType=4" target="_blank">└─转账</a></td>
			</tr>
			<tr>
				<td><a href="repaymentNewTrade.jsp" target="_blank">（06）借款人还款</a></td>
			</tr>
			<tr>
				<td><a href="transfer.jsp?pTransferType=2" target="_blank">（07）担保方代偿</a></td>
			</tr>
			<tr>
				<td><a href="transfer.jsp?pTransferType=5" target="_blank">（08）结算担保收益</a></td>
			</tr>
			<tr>
				<td><a href="transfer.jsp?pTransferType=3" target="_blank">（09）借款人针对代偿的还款</a></td>
			</tr>
			<tr>
				<td><a href="recharge.jsp?pChannelType=1" target="_blank">（10）托管账户充值&lt;网银&gt;</a></td>
			</tr>
			<tr>
				<td><a href="recharge.jsp?pChannelType=2" target="_blank">（11）托管账户充值&lt;委托收款-用户发起&gt;</a></td>
			</tr>
			<tr>
				<td><a href="coDpTrade.jsp" target="_blank">（12）托管账户充值&lt;委托收款-商户发起&gt;</a></td>
			</tr>
			<tr>
				<td><a href="doSTTrade.jsp" target="_blank">（13）托管账户提现</a></td>
			</tr>
			<tr>
				<td><a href="guaranteeUnfreeze.jsp?pUnfreezenType=2" target="_blank">（14）解冻担保方保证金</a></td>
			</tr>
			<tr>
				<td><a href="guaranteeUnfreeze.jsp?pUnfreezenType=1" target="_blank">（15）解冻借款人保证金</a></td>
			</tr>
			<tr>
				<td><a href="autoNewSigning.jsp" target="_blank">（16）投资人设置自动投标</a></td>
			</tr>
			<tr>
				<td><a href="repaymentSigning.jsp" target="_blank">（17）借款人设置自动还款</a></td>
			</tr>
		</table>
	</div>
</body>
</html>
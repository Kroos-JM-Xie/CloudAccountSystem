<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,com.cloudaccount.entities.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	int name = ((UserLogin) session.getAttribute("user")).getUserID();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1，maximum-scale=1, user-scalable=no">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrapValidator.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/index.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
<title>WEB云记账</title>
<style type="text/css">
.table th, .table td {
	text-align: center;
	vertical-align: middle !important;
}
</style>
</head>
<script type="text/javascript">
	function ine(msg) {

		if (msg == 1) {
			document.getElementById("checkUN").innerHTML = "<b style='color: green'>旧密码码输入正确</b>";
		} else if (msg == 0) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>旧密码输入错误</b>"
		} else {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>未知错误</b>"
		}
	}
	function checkPassword() {
		var password = $.trim($("#oldPwd").val());
		var s = 0;
		$.ajax({
			url : '${pageContext.request.contextPath}/user/checkPwd.action',
			data : "password=" + password,
			type : "POST",
			success : function(msg) {
				ine(msg);
				// alert(msg);
			}
		});

	}

	$(document).ready(function() {
		$("#oldPwd").blur(function() {
			checkPassword();
		});
	})

	$(function() {
		$('#changePwdForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				oldPwd : {
					validators : {
						notEmpty : {
							message : '旧密码不能为空'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_]+$/,
							message : '密码只能包含字母和数字'
						}
					}
				},
				newPwd : {
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						identical : {
							field : 'anewPwd',
							message : '两次输入的密码不一致'
						},
						different : {
							field : 'oldPwd',
							message : '新密码不能和旧密码一致'
						},
						stringLength : {
							min : 6,
							max : 18,
							message : '密码长度必须在6到10位之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_]+$/,
							message : '密码只能包含字母和数字'
						}
					}
				},
				anewPwd : {
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						identical : {
							field : 'newPwd',
							message : '两次输入的密码不一致'
						},
						different : {
							field : 'oldPwd',
							message : '新密码不能和旧密码一致'
						},
						stringLength : {
							min : 6,
							max : 18,
							message : '密码长度必须在6到10位之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_]+$/,
							message : '密码只能包含字母和数字'
						}
					}
				},
				submitHandler : function(validator, form, submitButton) {
					alert("submit");
				}
			}
		});
	});
</script>
<script type="text/javascript">
	var loginName =
<%=name%>
	$(function() {
		//去首页
		//alert(document.cookie);
		toPagefirst();
	});
	function toPagefirst() {
		to_pageic(loginName);
		to_page(1);
		showf();
	}
	function to_pageic(loginName) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/income.action",
			data : "userID=" + loginName,
			type : "GET",
			success : function(result) {
				//console.log(result);
				//build_emps_tableic(result);
				$("#samount").empty();
				//alert(result);
				$("#samount").text(result);
				$("#sText").text("总收入：¥");
			}
		});
	}
	function to_page(pn) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/chart/searchAmountInBySWName.action",
					data : "pn=" + pn,
					type : "get",
					//dataType : 'json',
					async : false,
					success : function(result) {
						build_emps_table(result);
					}
				});
	}
	function showf() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/chart/getColumnChart.action",
					//data : "pn=" + pn,
					type : "get",
					//dataType : 'json',
					async : false,
					success : function(result) {
						$("#preview").attr("src", result);
					}
				});
	}
	//列表1结束
	function toPageS() {
		showPayment(loginName);
		to_pages(1);
		shows();
	}
	function showPayment(loginName) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/payment.action",
			data : "userID=" + loginName,
			type : "GET",
			success : function(result) {
				//console.log(result);
				$("#samount").empty();
				//alert(result);
				$("#samount").text(result);
				$("#sText").text("总支出：¥");
			}
		});
	}
	function shows() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/chart/getColumnChartout.action",
					//data : "pn=" + pn,
					type : "get",
					//dataType : 'json',
					async : false,
					success : function(result) {
						$("#preview").attr("src", result);
					}
				});
	}
	function to_pages(pn) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/chart/searchAmountOutBySWName.action",
					//data : "pn=" + pn,
					type : "get",
					//dataType : 'json',
					async : false,
					success : function(result) {
						build_emps_table(result);
					}
				});
	}
	//列表2结束
	function toPaget() {
		to_pageic(loginName);
		to_page(1);
		showt();
	}
	function showt() {
		$.ajax({
			url : "${pageContext.request.contextPath}/chart/getPieIn.action",
			//data : "pn=" + pn,
			type : "get",
			//dataType : 'json',
			async : false,
			success : function(result) {
				$("#preview").attr("src", result);
			}
		});
	}
	//列表3结束
	function toPagefo() {
		showPayment(loginName);
		to_pages(1);
		showfo();
	}
	function showfo() {
		$.ajax({
			url : "${pageContext.request.contextPath}/chart/getPieOut.action",
			//data : "pn=" + pn,
			type : "get",
			//dataType : 'json',
			async : false,
			success : function(result) {
				$("#preview").attr("src", result);
			}
		});
	}
	function build_emps_table(result) {
		//清空table表格
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		//alert(emps);
		$.each(emps, function(index, item) {
			var empIdTd = $("<td></td>").append(item.amount);
			var emailTd = $("<td></td>").append(item.swName);
			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(empIdTd).append(emailTd).appendTo(
					"#emps_table tbody");
		});
	}
</script>
<body>
	<!-- 导航条 -->
	<nav class="navbar navbar-inverse navbar-static-top">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/index.jsp"><span
				class="glyphicon glyphicon-cloud"></span>云记账系统<!--    <img alt="云记账" src="${pageContext.request.contextPath}/pictures/logo.jpg">-->
			</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a
					href="${pageContext.request.contextPath}/amount/addamountpage.action">记账</a></li>
				<li><a
					href="${pageContext.request.contextPath}/amount/searchamountpage.action">查账</a></li>
				<li><a
					href="${pageContext.request.contextPath}/amount/countpage.action">统计</a></li>
				<li><a>帮助</a></li>
				<li><a>联系</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a href="##"><span class="glyphicon glyphicon-user"></span>${user.userName}</a></li>
				<li><a data-toggle="modal" data-target="#changePwd" href=""><span
						class="glyphicon glyphicon-transfer"></span>修改密码</a></li>
			</ul>

		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- 主体页面 -->
	<div class="row">
		<div class="col-xs-2">
			<ul class="nav nav-pills nav-stacked">
				<li role="presentation" class="active" onclick="toPagefirst();"><a
					href="##">收入来源统计</a></li>
				<li role="presentation" class="active" onclick="toPageS();"><a
					href="##">支出去向统计</a></li>
				<li role="presentation" class="active" onclick="toPaget();"><a
					href="##">收入来源分布</a></li>
				<li role="presentation" class="active" onclick="toPagefo();"><a
					href="##">支出去向分布</a></li>
			</ul>
		</div>
		<center>
			<img src="" width=600 height=400 id="preview" border=0 color=gray>
		</center>
		<br>
		<center>
			<span id="sText"></span> <span name="samount" id="samount"></span> <span>元</span>
		</center>
		<div class="col-md-5 table th table td">
			<table class="table table-hover " id="emps_table">
				<thead>
					<tr>
						<th>金额:¥(元)</th>
						<th>来源去处</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	<!-- 显示表格数据 -->
	<div style="text-align: center">
		<!-- 
	<div style="text-align: center">
		jfreechart _3D柱状图 <br> <br> 点击显示柱状图<a
			href="${pageContext.request.contextPath}/chart/getColumnChartout.action">getMajorChart</a>
		<br> <br> -->

	</div>
	<div class="row">

		<!-- 修改密码窗口 -->
		<div id="changePwd" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body">
						<button class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
					</div>
					<div class="modal-title">
						<h1 class="text-center">修改密码</h1>
					</div>
					<div class="modal-body">
						<form
							action="${pageContext.request.contextPath}/user/changePwd.action"
							method="post" class="form-group" id="changePwdForm">
							<div class="form-group">
								<label for="">旧密码</label> <input class="form-control"
									type="password" name="oldPwd" id="oldPwd" placeholder="旧密码"><span
									id="checkUN"></span>
							</div>
							<div class="form-group">
								<label for="">新密码</label> <input class="form-control"
									type="password" name="newPwd" id="newPwd"
									placeholder="至少6位字母或数字">
							</div>
							<div class="form-group">
								<label for="">确认密码</label> <input class="form-control"
									type="password" name="anewPwd" id="anewPwd"
									placeholder="至少6位字母或数字">
							</div>

							<div class="text-right">
								<button class="btn btn-primary" type="submit">提交</button>
								<button class="btn btn-danger" data-dismiss="modal">取消</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 脚注开始 -->
		<footer class="bs-docs-footer">
		<div class="container">
			<ul class="bs-docs-footer-links">
				<li><a href="http://www.gdei.edu.cn/2014/">GDEI</a></li>
				<li><a href="http://www.cnki.net/">中国知网</a></li>
				<li><a href="http://www.bootcss.com/">BootStrap</a></li>
				<li><a href="https://spring.io/">Spring</a></li>
				<li><a href="https://www.gdca.gov.cn/">广东省通管局</a></li>
			</ul>

			<p>This Project was designed and finished by XieJM with the help
				of Mr.Xu. Good luck for everyone.</p>

			<p>
				本项目源码受 <a rel="license" href="http://www.gdei.edu.cn/2014/"
					target="_blank">gdei</a>保护，论文受 <a rel="license"
					href="http://210.38.64.108/bysj/" target="_blank">gdei2018</a>
				论文受承诺协议保护。
			</p>

		</div>
		</footer>
</body>
</html>
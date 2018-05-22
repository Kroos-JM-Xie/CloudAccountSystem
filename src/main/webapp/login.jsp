<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
<title>WEB云记账</title>
<style>
.container {
	display: table;
	height: 100%;
}

.row {
	display: table-cell;
	vertical-align: middle;
}
/* centered columns styles */
.row-centered {
	text-align: center;
	height: 100%;
}

.col-centered {
	display: inline-block;
	float: none;
	text-align: left;
	margin-right: -4px;
	height: 100%;
}
</style>
</head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript">
	function ine(msg) {

		if (msg == 1) {
			document.getElementById("checkUN").innerHTML = "<b style='color: green'>用户名正确</b>";
		} else if (msg == 2) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>不能为空</b>";
		} else if (msg == 3) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>该用户名不存在</b>"
		} else if (msg == 0) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>ajax成功返回值为空</b>"
		} else {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>未知错误</b>"
		}
	}
	function checkUser() {
		var name = $.trim($("#userName").val());
		var s = 0;
		$.ajax({
			url : '${pageContext.request.contextPath}/user/checkUser.action',
			data : "name=" + name,
			type : "POST",
			success : function(msg) {
				ine(msg);
				// alert(msg);
			}
		});

	}

	$(document).ready(function() {
		$("#userName").blur(function() {
			checkUser();
		});
	})
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
		<ul class="nav navbar-nav navbar-right">
			<li><a href="${pageContext.request.contextPath}/index.jsp"><span
					class="glyphicon glyphicon-user"></span>注册</a></li>
		</ul>

	</div>
	<!-- /.navbar-collapse --> <!-- /.container-fluid --> </nav>
	<div class="container">
		<div class="row row-centered">
			<div class="well col-md-6 col-centered">
				<center>
					<h2>登&nbsp;陆</h2>
				</center>
				<form action="${pageContext.request.contextPath }/user/login.action"
					method="post" class="form-horizontal">
					<div class="input-group input-group-md">
						<span class="input-group-addon" id="sizing-addon1"><i
							class="glyphicon glyphicon-user" aria-hidden="true"></i></span> <input
							type="text" class="form-control" id="userName" name="userName"
							placeholder="请输入用户名" /><span id="checkUN"></span>
					</div>
					<div class="input-group input-group-md">
						<span class="input-group-addon" id="sizing-addon1"><i
							class="glyphicon glyphicon-lock"></i></span> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="请输入密码" />
					</div>
					<br />
					<button type="submit" class="btn btn-info btn-block">登&nbsp;陆</button>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>

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

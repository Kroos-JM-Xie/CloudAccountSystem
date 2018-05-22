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


</head>
<script type="text/javascript">
	function ine(msg) {

		if (msg == 1) {
			document.getElementById("checkUN").innerHTML = "<b style='color: red'>用户名已存在</b>";
		} else if (msg == 2) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>用户名不能为空</b>";
		} else if (msg == 3) {
			document.getElementById("checkUN").innerHTML = "<b style='color:green'>该用户名可用</b>"
		} else if (msg == 0) {
			document.getElementById("checkUN").innerHTML = "<b style='color:red'>用户名只能包含字母和数字</b>"
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

	$(function() {
		$('form').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				userName : {
					message : '用户名验证失败',
					validators : {
						notEmpty : {
							message : '用户名不能为空'
						},
						stringLength : {
							min : 6,
							max : 18,
							message : '用户名长度必须在6到10位之间'
						},
						regexp : {
							regexp : /^[a-zA-Z0-9_]+$/,
							message : '用户名只能包含字母和数字'
						}
					}
				},
				password : {
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						identical : {
							field : 'apassword',
							message : '两次输入的密码不一致'
						},
						different : {
							field : 'userName',
							message : '密码不能和用户名一致'
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
				apassword : {
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						identical : {
							field : 'password',
							message : '两次输入的密码不一致'
						},
						different : {
							field : 'userName',
							message : '密码不能和用户名一致'
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
				<li><a href="${pageContext.request.contextPath}/login.jsp"><span
						class="glyphicon glyphicon-log-in"></span> 登陆</a></li>
				<li><a data-toggle="modal" data-target="#register" href=""><span
						class="glyphicon glyphicon-user"></span>注册</a></li>
			</ul>

		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- 主体页面 -->
	<center>
		<h1>密码错误</h1>
		<h2>
			<a href="${pageContext.request.contextPath}/login.jsp">返回登陆</a>
		</h2>
	</center>
	<!-- 注册窗口 -->
	<div id="register" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<button class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-title">
					<h1 class="text-center">注册</h1>
				</div>
				<div class="modal-body">
					<form
						action="${pageContext.request.contextPath}/user/register.action"
						method="post" class="form-group">
						<div class="form-group">
							<label for="">用户名</label> <input class="form-control" type="text"
								name="userName" id="userName" placeholder="6-15位字母或数字">
							<span id="checkUN"></span>
						</div>
						<div class="form-group">
							<label for="">密码</label> <input class="form-control"
								type="password" name="password" id="password"
								placeholder="至少6位字母或数字">
						</div>
						<div class="form-group">
							<label for="">确认密码</label> <input class="form-control"
								type="password" name="apassword" id="apassword"
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
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
	$(function() {
		$('#addAmountForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				amount : {
					validators : {
						notEmpty : {
							message : '金额不能为空'
						},
						regexp : {
							regexp : /^[0-9]+([.]{1}[0-9]{1,2})?$/,
							message : '金额只能为数字，且只能精确到小数点后2位'
						}
					}
				},
				amountType:{
					validators:{
						notEmpty:{
							message:'请选择是输入还是支出'
						}
					}
				},
				writeTime:{
					validators:{
						notEmpty:{
							message:'请选择日期'
						},
						date : { 
							format : 'YYYY-MM-DD', 
							message : '日期格式不正确'
							} 
					}
				},
				swName:{
					validators:{
						notEmpty:{
							message:'请选择来源去向'
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
	$(function() {
		$('#datetimepicker2').datetimepicker({
			format : 'YYYY-MM-DD',
			locale : moment.locale('zh-cn')
		});
	});
</script>
<script type="text/javascript">
function catalogABC(){  
    var object = $("#amountType").val();
    $("#swName").empty();
    if(object !=null){
         $.ajax({
                url : "${pageContext.request.contextPath}/swtype/swtypesbydesc.action?desc="+object,
                type : 'post',
                dataType : 'json',
                async : false,
                success : function(data) {
                    var vendorJson = eval(data);
                       if(data!=null){
                           $("#swName").prepend("<option value='0'>来源去向</option>");
                            $.each(vendorJson,function(i,item){
                                  $.each(item,function(j,val){
                                      $("#swName").append("<option value="+val.swNameID+">"+val.swName+"</option>"); 
                                  })

                              }); 
                       }                                                    
                }
         })
    }
    else{
        alert("请选择收入或支出！！");
    }
}
function getSWNameValues() {
	var swNameValue=$('#swName option:selected').text();
	var writeTimeValue=$.trim($("#writeTime").val());
	var amountTypeValue=$('#amountType option:selected').text();
	var amountValue=$.trim($("#amount").val());
	$.ajax({
		type:'post',  
        url:'${pageContext.request.contextPath}/amount/addamount.action', 
        dataType: 'text',  
        contentType:'application/json;charset=UTF-8',
        data:JSON.stringify({'amount':amountValue,'amountType':amountTypeValue,'writeTime':writeTimeValue,'swName':swNameValue}), 
        success:function (result) {  
        	//alert(result);
        	//location.reload();
        	if(result==1){
        		alert("添加成功");
        		location.reload();
        	}else{
        		alert("添加失败");
        		location.reload();
        	}
        },  
        error:function (result) {  
        }  
    });  
}
</script>
<script type="text/javascript">
var loginName="<%=name%>";
	$(function() {
		//去首页
		//alert(document.cookie);
		to_page(loginName);
		showPayment(loginName);
		showBalance(loginName);
	});
	function to_page(loginName) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/income.action",
			data : "userID=" + loginName,
			type : "GET",
			success : function(result) {
				//console.log(result);
				build_emps_table(result);
			}
		});
	}
	function build_emps_table(result) {
		$("#samount").empty();
		//alert(result);
		$("#samount").val(result);

	}
	function showPayment(loginName) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/payment.action",
			data : "userID=" + loginName,
			type : "GET",
			success : function(result) {
				//console.log(result);
				buildZamount(result);
			}
		});
	}
	function buildZamount(result) {
		$("#zamount").empty();
		//alert(result);
		$("#zamount").val(result);
	}
	function showBalance(loginName) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/balance.action",
			data : "userID=" + loginName,
			type : "GET",
			success : function(result) {
				//console.log(result);
				buildBalnace(result);
			}
		});
	}
	function buildBalnace(result) {
		$("#balnaceAmount").empty();
		//alert(result);
		$("#balnaceAmount").val(result);
		if (result < 100) {
			alert("您所记录账本余额为" + result + "元。\n" + "请理性消费！");
		}
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
	<div style="width: 100%; display: block">
		<table class="table">
			<tr>
				<td width="300px">
					<center>
						<form action="" method="post" class="form-group"
							id="addAmountForm">
							<h1>
								<span class="glyphicon glyphicon-plus-sign"></span>增加账本
							</h1>
							<br />
							<div class="input-group ">
								<span class="input-group-addon">金额：¥</span> <input type="text"
									class="form-control" name="amount" id="amount"
									placeholder="1.00"> <span class="input-group-addon">元</span>
							</div>
							<br>
							<div class="form-horizontal">
								<div class="col-lg-15">
									<select name="amountType" id="amountType"
										onchange="catalogABC();" class="form-control">
										<option value="">收入/支出</option>
										<option value="收入"
											<c:if test="${param.catalog == '收入'} ">selected</c:if>>收入</option>
										<option value="支出"
											<c:if test="${param.catalog == '支出'} ">selected</c:if>>支出</option>
									</select>
								</div>
							</div>
							<br>
							<!--指定 date标记-->
							<div class='input-group date' id='datetimepicker2'>
								<span class="input-group-addon">选择日期：</span> <input type='text'
									class="form-control" name="writeTime" id="writeTime" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
							<br>
							<div class="form-horizontal">
								<div class="col-lg-15">
									<select name="swName" id="swName" class="form-control">
										<option value="">来源去向</option>
									</select>

								</div>
							</div>
							<br>
							<button type="button" class="btn btn-info btn-block"
								onclick="getSWNameValues();">保&nbsp;存</button>
						</form>
					</center>
				</td>
				
				<td width="600px"><h1>
						<span class="glyphicon glyphicon-align-justify"></span>记账金额统计
					</h1>
					<br>
				<center>
						<h2>
							<div class="row">
								<div class="col-xs-8">
									<div class="input-group ">
										<span class="input-group-addon">收入：¥</span> <input type="text"
											class="form-control" name="samount" id="samount"
											readonly="readonly"> <span class="input-group-addon">元</span>
									</div>
									<br>
									<div class="input-group ">
										<span class="input-group-addon">支出：¥</span> <input type="text"
											class="form-control" name="zamount" id="zamount"
											readonly="readonly"> <span class="input-group-addon">元</span>
									</div>
									<br>
									<div class="input-group ">
										<span class="input-group-addon">余额：¥</span> <input type="text"
											class="form-control" name="balnaceAmount" id="balnaceAmount"
											readonly="readonly"> <span class="input-group-addon">元</span>
									</div>
								</div>
							</div>
						</h2>
					</center></td>
				<td><img alt=""
					src="${pageContext.request.contextPath}/pictures/inst2.jpg"></td>
			</tr>
		</table>
	</div>
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
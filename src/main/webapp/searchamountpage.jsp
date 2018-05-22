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
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
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
				camount : {
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
				camountType : {
					validators : {
						notEmpty : {
							message : '请选择是输入还是支出'
						}
					}
				},
				cwriteTime : {
					validators : {
						notEmpty : {
							message : '请选择日期'
						},
						date : {
							format : 'YYYY-MM-DD',
							message : '日期格式不正确'
						}
					}
				},
				swName : {
					validators : {
						notEmpty : {
							message : '请选择来源去向'
						}
					}
				},
				submitHandler : function(validator, form, submitButton) {
				//	alert("submit");
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
	function catalogABC() {
		var object = $("#camountType").val();
		$("#cswName").empty();
		if (object != null) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/swtype/swtypesbydesc.action?desc="
								+ object,
						type : 'post',
						dataType : 'json',
						async : false,
						//contentType: "application/json; charset=utf-8",
						success : function(data) {
							// console.log(data);
							var vendorJson = eval(data);
							// alert(vendorJson);
							if (data != null) {
								$("#cswName").prepend(
										"<option value='0'>来源去向</option>");
								$.each(vendorJson, function(i, item) {
									$.each(item, function(j, val) {
										$("#cswName").append(
												"<option value="+val.swNameID+">"
														+ val.swName
														+ "</option>");
										//$("#swName").append(val.swName); 
									})

								});
							}
						}

					})
		} else {
			alert("请选择收入或支出！！");
		}
	}
	function getSWNameValues() {
		var swNameValue = $('#cswName option:selected').text();
		var writeTimeValue = $.trim($("#cwriteTime").val());
		var amountTypeValue = $('#camountType option:selected').text();
		var amountValue = $.trim($("#camount").val());
		var amountIDValue = $('#camountID').text();
		//alert(amountIDValue);
		//alert(amountValue);
		//var str="main";
		$.ajax({
			type : 'put',
			url : '${pageContext.request.contextPath}/amount/' + amountIDValue,
			dataType : 'text',
			contentType : 'application/json;charset=UTF-8',
			data : JSON.stringify({
				'amountID' : amountIDValue,
				'amount' : amountValue,
				'amountType' : amountTypeValue,
				'writeTime' : writeTimeValue,
				'swName' : swNameValue
			}),
			// data:'amount='+amountValue&'amountType='+amountTypeValue&'writeTime='+writeTimeValue&'swName='+swNameValue,  
			success : function(result) {
				//alert(result);
				//location.reload();
				if (result == 1) {
					alert("修改成功");
					location.reload();
				} else {
					alert("修改失败");
					location.reload();
				}
			},
			error : function(result) {

			}
		});
	}
</script>
<script type="text/javascript">
	var totalRecord, currentPage;
	//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
	$(function() {
		//去首页
		to_page(1);
	});

	function to_page(pn) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/amount/searchamountbyuser.action",
					data : "pn=" + pn,
					type : "get",
					//dataType : 'json',
					async : false,
					success : function(result) {
						//console.log(result);
						//alert(pn);
						//1、解析并显示数据
						build_emps_table(result);
						//2、解析并显示分页信息
						build_page_info(result);
						//3、解析显示分页条数据
						build_page_nav(result);
					}
				});
	}

	function build_emps_table(result) {
		//清空table表格
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		//alert(emps);
		$.each(emps, function(index, item) {
			var empIdId = $("<td></td>").append(item.amountID);
			var empIdTd = $("<td></td>").append(item.amount);
			var empNameTd = $("<td></td>").append(item.amountType);
			var genderTd = $("<td></td>").append(item.writeTime);
			var emailTd = $("<td></td>").append(item.swName);
			//var deptNameTd = $("<td></td>").append(item.department.deptName);
			var editBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm edit_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-edit"))
					.append("修改");
			//为编辑按钮添加一个自定义的属性，来表示当前id
			editBtn.attr("edit-id", item.amountID);
			var delBtn = $("<button></button>").addClass(
					"btn btn-danger btn-sm delete_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-erase"))
					.append("删除");
			//为删除按钮添加一个自定义的属性来表示当前删除的id
			delBtn.attr("del-id", item.amountID);
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(
					delBtn);
			//var delBtn = 
			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(empIdId).append(empIdTd).append(empNameTd)
					.append(genderTd).append(emailTd).append(btnTd).appendTo(
							"#emps_table tbody");
		});
	}
	//解析显示分页信息
	function build_page_info(result) {
		$("#page_info_area").empty();
		$("#page_info_area").append(
				"当前" + result.extend.pageInfo.pageNum + "页,总"
						+ result.extend.pageInfo.pages + "页,总"
						+ result.extend.pageInfo.total + "条记录");
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	//解析显示分页条，点击分页要能去下一页....
	function build_page_nav(result) {
		//page_nav_area
		$("#page_nav_area").empty();
		var ul = $("<ul></ul>").addClass("pagination");

		//构建元素
		var firstPageLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if (result.extend.pageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		} else {
			//为元素添加点击翻页的事件
			firstPageLi.click(function() {
				to_page(1);
			});
			prePageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum - 1);
			});
		}

		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append(
				$("<a></a>").append("末页").attr("href", "#"));
		if (result.extend.pageInfo.hasNextPage == false) {
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			nextPageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum + 1);
			});
			lastPageLi.click(function() {
				to_page(result.extend.pageInfo.pages);
			});
		}

		//添加首页和前一页 的提示
		ul.append(firstPageLi).append(prePageLi);
		//1,2，3遍历给ul中添加页码提示
		$.each(result.extend.pageInfo.navigatepageNums, function(index, item) {

			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.extend.pageInfo.pageNum == item) {
				numLi.addClass("active");
			}
			numLi.click(function() {
				to_page(item);
			});
			ul.append(numLi);
		});
		//添加下一页和末页 的提示
		ul.append(nextPageLi).append(lastPageLi);

		//把ul加入到nav
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}
	//删除功能
	$(document).on("click", ".delete_btn", function() {
		//1、弹出是否确认删除对话框
		//var empName = $(this).parents("tr").find("td:eq(1)").text();
		var empId = $(this).attr("del-id");
		//alert($(this).parents("tr").find("td:eq(1)").text());
		if (confirm("确认删除【" + empId + "】吗？")) {
			//确认，发送ajax请求删除即可
			$.ajax({
				url : "${pageContext.request.contextPath}/amount/" + empId,
				type : "delete",
				//data:"amountID="+empId,
				success : function(result) {
					if (result == 1) {
						alert("删除成功");
					} else if (result == 0) {
						alert("删除失败");
					} else {
						alert("未知错误")
					}
					//回到本页
					location.reload();
				}
			});
		}
	});
	//按条件查询
	function searchByType() {
		var object = $("#amountType").val();
		$("#emps_table tbody").empty();
		if (object != null) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/amount/searchamountbytype.action?type="
								+ object,
						type : 'get',
						// dataType : 'json',
						async : false,
						//contentType: "application/json; charset=utf-8",
						success : function(data) {
							// console.log(data);
							build_emps_table(data);
							build_page_info(data);
							//3、解析显示分页条数据
							build_page_nav(data);
						}

					})
		} else {
			alert("请选择收入或支出！！");
		}
	}
	$(document).on("click", ".edit_btn", function() {
		//alert("edit");
		//getDepts("#empUpdateModal select");

		getEmp($(this).attr("edit-id"));

		//3、把员工的id传递给模态框的更新按钮
		$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
		$("#changeAmount").modal({
			backdrop : "static"
		});
	});
	function getEmp(id) {
		$.ajax({
			url : "${pageContext.request.contextPath}/amount/" + id,
			type : "GET",
			success : function(result) {
				//console.log(result);
				var empData = result.extend.amount;
				$("#camountID").text(empData.amountID);
				$("#camount").val(empData.amount);
				//	$("#email_update_input").val(empData.email);
				$("#cwriteTime").val([ empData.writeTime ]);
				$("#cswName").append(
						"<option value="+empData.amountID+">" + empData.swName
								+ "</option>");
			}
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
				<li><a href="${pageContext.request.contextPath}/amount/countpage.action">统计</a></li>
				<li><a>帮助</a></li>
				<li><a>联系</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li ><a href="##"><span class="glyphicon glyphicon-user"></span>${user.userName}</a></li>
				<li><a data-toggle="modal" data-target="#changePwd" href=""><span
						class="glyphicon glyphicon-transfer"></span>修改密码</a></li>
			</ul>

		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- 主体页面 -->
	<!-- 条件选择区 -->
	<form action="" method="get" class="form-inline">
		<div class="form-group">
			<select name="amountType" id="amountType" class="form-control">
				<option value="">收入/支出</option>
				<option value="收入"
					<c:if test="${param.catalog == '收入'} ">selected</c:if>>收入</option>
				<option value="支出"
					<c:if test="${param.catalog == '支出'} ">selected</c:if>>支出</option>
			</select>
			<button type="button" class="btn btn-info " onclick="searchByType();">查&nbsp;询</button>
		</div>
	</form>
	<!-- 显示表格数据 -->
	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover" id="emps_table">
				<thead>
					<tr>
						<th>#</th>
						<th>金额:¥(元)</th>
						<th>收入/支出</th>
						<th>记录时间</th>
						<th>来源去处</th>
						<th>操 作</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	<!-- 显示分页信息 -->
	<div class="row">
		<!--分页文字信息  -->
		<div class="col-md-6" id="page_info_area"></div>
		<!-- 分页条信息 -->
		<div class="col-md-6" id="page_nav_area"></div>
	</div>
	<!-- 修改模态框 -->

	<!-- 账本修改模态框开始 -->
	<div id="changeAmount" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<button class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-title">
					<h1 class="text-center">修改账本</h1>
				</div>
				<div class="modal-body">
					<form action="" method="put" class="form-group" id="addAmountForm">
						<div class="form-group">
							<label class="col-sm-2 control-label">账本ID</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="camountID"></p>
							</div>
						</div>
						<br>
						<div class="input-group ">
							<span class="input-group-addon">金额：¥</span> <input type="text"
								class="form-control" name="camount" id="camount"
								placeholder="1.00"> <span class="input-group-addon">元</span>
						</div>
						<br>
						<div class="form-horizontal">
							<div class="col-lg-15">
								<select name="camountType" id="camountType"
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
								class="form-control" name="cwriteTime" id="cwriteTime" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
						<br>
						<div class="form-horizontal">
							<div class="col-lg-15">
								<select name="cswName" id="cswName" class="form-control">
									<!--  	<option value="">来源去向</option>-->
								</select>

							</div>
						</div>
						<br>
						<button type="button" class="btn btn-info btn-block"
							id="emp_update_btn" onclick="getSWNameValues();">保&nbsp;存</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 修改密码窗口 -->
	<div id="changePwd" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
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
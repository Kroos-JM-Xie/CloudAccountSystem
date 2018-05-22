package com.cloudaccount.controller;

import java.awt.Font;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartColor;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cloudaccount.entities.Amount;
import com.cloudaccount.entities.Msg;
import com.cloudaccount.entities.UserLogin;
import com.cloudaccount.services.IAmountServices;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.sf.json.JSONObject;

/**
 * 账本控制器
 * 
 * @author XieJM
 *
 */
@Controller
@RequestMapping(value = "/amount")
public class AmountController {
	@Autowired
	private IAmountServices amountServices;

	@RequestMapping("/view")
	public String view() {
		return "main/login";
	}

	@RequestMapping("/indexview")
	public String index() {
		return "main/index";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	/**
	 * 生成账本ID
	 * 
	 * @return
	 */
	private long createAmountID() {
		long amountID = 0;
		Date now = new Date();
		amountID = now.getTime();// 根据日期生成唯一id
		return amountID;
	}

	/**
	 * 字符串转化成日期
	 * 
	 * @param dateString
	 * @return
	 * @throws ParseException
	 */
	private Date stringParseDate(String dateString) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(dateString);
	}

	/**
	 * 跳转到记账页面
	 */
	@RequestMapping(value = "/addamountpage.action")
	public String registerpage() {
		return "main";
	}

	/**
	 * 跳转到记账页面
	 */
	@RequestMapping(value = "/searchamountpage.action")
	public String searchAmountPage() {
		return "searchamountpage";
	}

	/**
	 * 跳转到统计页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/countpage.action")
	public String countPage() {
		return "count";
	}

	/**
	 * 增加账本
	 * 
	 * @param amount
	 * @param session
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(value = "/addamount.action", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public int addAmountControl(@RequestBody Amount amount, HttpSession session, HttpServletRequest request)
			throws ParseException {
		int result = 0;
		JSONObject obj = new JSONObject();
		UserLogin user = (UserLogin) session.getAttribute("user");
		Date date = amount.getWriteTime();
		System.out.println(date);
		String swName = amount.getSwName();
		String amountType = amount.getAmountType();
		double amountS = amount.getAmount();
		System.out.println(swName);
		amount.setUserID(user.getUserID());
		amount.setAmountID(createAmountID());
		amount.setSwName(swName);
		result = amountServices.addAmount(amount);
		System.out.println("result=" + result);
		if (result > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	/**
	 * 修改账本操作
	 * 
	 * @param amount
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/{amountId}", method = RequestMethod.PUT, produces = "application/json; charset=utf-8")
	public int changeAmountControl(@RequestBody Amount amount, HttpServletRequest request) {
		int result = 0;
		JSONObject obj = new JSONObject();
		// UserLogin user = (UserLogin) session.getAttribute("user");
		Date date = amount.getWriteTime();
		System.out.println(date);
		String swName = amount.getSwName();
		String amountType = amount.getAmountType();
		double amountS = amount.getAmount();
		Long amountID = amount.getAmountID();
		System.out.println(amountID);
		result = amountServices.changeAmount(amount);
		System.out.println("result-----change----" + result);
		if (result > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	/**
	 * 删除账本记录
	 * 
	 * @param ids
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "{ids}", method = RequestMethod.DELETE)
	public int cutAmountControl(@PathVariable("ids") String ids, HttpSession session) {
		int result = 0;
		long amountID = 0;
		System.out.println("ids---" + ids);
		amountID = Long.parseLong(ids);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		System.out.println("账号id==" + amountID);
		result = amountServices.cutAmount(amountID, userID);
		if (result > 0) {
			System.out.println(result);
			return 1;
		} else {
			return 0;
		}
	}

	/**
	 * 显示该用户记账
	 * 
	 * @param pn
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/searchamountbyuser.action")
	@ResponseBody
	public Msg searchAmount(@RequestParam(value = "pn", defaultValue = "1") int pn,HttpSession session) {
		PageHelper.startPage(pn, 5);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> list = amountServices.findAmountByID(userID);
		if (!list.isEmpty()) {
			System.out.println(list.size());
			for (Amount amount : list) {
				System.out.println(list);
			}
		}
		PageInfo page = new PageInfo(list, 5);
		return Msg.success().add("pageInfo", page);
	}

	/**
	 * 分页查询
	 * 
	 * @param pn
	 * @param model
	 * @param session
	 * @return
	 */
	public String getAmount(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			HttpSession session) {
		PageHelper.startPage(pn, 5);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> list = amountServices.findAmountByID(userID);
		PageInfo page = new PageInfo(list, 5);
		model.addAttribute("pageInfo", page);
		return "list";

	}

	/**
	 * 条件查询
	 * 
	 * @param session
	 * @param type
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchamountbytype.action", method = RequestMethod.GET)
	public Msg searchAmountByType(HttpSession session, String type, Model model) {
		PageHelper.startPage(5, 5);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> list = amountServices.findAmountByType(type, userID);
		if (!list.isEmpty()) {
			for (Amount amount : list) {
				System.out.println(list.toArray());
			}
		}
		PageInfo page = new PageInfo(list, 5);
		model.addAttribute("pageInfo", page);
		return Msg.success().add("pageInfo", page);
	}

	@RequestMapping(value = "/searchamountbydate.action", method = RequestMethod.GET)
	public String searchAmountByDate(HttpSession session, String dateS) throws ParseException {
		UserLogin user = (UserLogin) session.getAttribute("user");
		amountServices.findAmountByDate(stringParseDate(dateS));
		return "list";
	}

	@RequestMapping(value = "/searchamountbydateandtype.action", method = RequestMethod.GET)
	public String searchAmountByDateAndType(HttpSession session, String dateS, String date2, String type)
			throws ParseException {
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		amountServices.findAmountByDateAndType(stringParseDate(dateS), stringParseDate(date2), type);
		return "list";
	}

	/**
	 * 统计收入
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/income.action", method = RequestMethod.GET)
	public double sumIncome(HttpSession session, Model model) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		System.out.println("UserID=" + user.getUserID());
		int userID = user.getUserID();
		double sumInAmount = 0;
		sumInAmount = amountServices.sumIncomeAmount(userID);
		model.addAttribute("sumInAmount", sumInAmount);
		System.out.println(sumInAmount);
		return sumInAmount;
	}

	/**
	 * 统计支出
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/payment.action", method = RequestMethod.GET)
	public double sumPayment(HttpSession session, Model model) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		System.out.println("UserID=" + user.getUserID());
		int userID = user.getUserID();
		double sumOutAmount = 0;
		sumOutAmount = amountServices.sumOutAmount(userID);
		model.addAttribute("sumOutAmount", sumOutAmount);
		System.out.println(sumOutAmount + "payment");
		return sumOutAmount;
	}

	/**
	 * 计算记账余额
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/balance.action", method = RequestMethod.GET)
	public double balanceMoney(HttpSession session, Model model) {
		double balanceMoney = 0;
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		balanceMoney = amountServices.sumIncomeAmount(userID) - amountServices.sumOutAmount(userID);
		return balanceMoney;
	}

	@RequestMapping(value = "/{amountID}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getAmountByID(@PathVariable("amountID") Long amountID, HttpSession session) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		Amount amount = amountServices.findAmountByAmountID(amountID, userID);
		System.out.println(amount.toString());
		return Msg.success().add("amount", amount);

	}

	/**
	 * 分组统计
	 * 
	 * @param session
	 * @return
	 */
	public List<Amount> getAmountIn(HttpSession session) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> list = amountServices.countAmountIn(userID);
		return list;

	}

	public List<Amount> getAmountOut(HttpSession session) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> list = amountServices.countAmountOut(userID);
		return list;

	}

}

package com.cloudaccount.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.awt.Font;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartColor;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cloudaccount.entities.Amount;
import com.cloudaccount.entities.Msg;
import com.cloudaccount.entities.UserLogin;
import com.cloudaccount.services.IAmountServices;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping(value = "/chart")
public class ChartController {
	@Autowired
	private IAmountServices countAmountServvices;

	/**
	 * 分组统计 由于Mybatis使用Group by sum统计时，返回值为0 此函数是为了实现MySQL 分组统计的功能
	 * 
	 * @param list
	 * @return
	 */
	private List<Amount> getListByGroup(List<Amount> list) {
		List<Amount> result = new ArrayList<Amount>();
		Map<String, Double> map = new HashMap<String, Double>();

		for (Amount amount : list) {
			if (map.containsKey(amount.getSwName())) {
				map.put(amount.getSwName(), map.get(amount.getSwName()) + amount.getAmount());
			} else {
				map.put(amount.getSwName(), amount.getAmount());
			}
		}
		for (Entry<String, Double> entry : map.entrySet()) {
			result.add(new Amount(entry.getKey(), entry.getValue()));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchAmountInBySWName.action", method = RequestMethod.GET)
	public Msg searchAmountInBySWName(HttpSession session, Model model) {
		PageHelper.startPage(5, 5);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID=user.getUserID();
		List<Amount> amount=countAmountServvices.countAmountIn(userID);
		List<Amount> list = getListByGroup(amount);
		if(!list.isEmpty()){
			for (Amount amounts : amount) {
				System.out.println(amounts);
			}
		}
		PageInfo page=new PageInfo(list,5);
		model.addAttribute("pageInfo", page);
		return Msg.success().add("pageInfo", page);
	}
	@ResponseBody
	@RequestMapping(value = "/searchAmountOutBySWName.action", method = RequestMethod.GET)
	public Msg searchAmountOutBySWName(HttpSession session, Model model) {
		PageHelper.startPage(5, 5);
		UserLogin user = (UserLogin) session.getAttribute("user");
		int userID=user.getUserID();
		List<Amount> amount=countAmountServvices.countAmountOut(userID);
		List<Amount> list = getListByGroup(amount);
		if(!list.isEmpty()){
			for (Amount amounts : amount) {
				System.out.println(amounts);
			}
		}
		PageInfo page=new PageInfo(list,5);
		model.addAttribute("pageInfo", page);
		return Msg.success().add("pageInfo", page);
	}
	/**
	 * 柱状图统计区域
	 * @param seession
	 * @return
	 */
	private CategoryDataset createDateSetIn(HttpSession seession) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		// List<CountAmount> data = new ArrayList<CountAmount>();
		UserLogin user = (UserLogin) seession.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> amount = countAmountServvices.countAmountIn(userID);
		List<Amount> list = getListByGroup(amount);
		double value = 0;
		String rowKeys = null;
		String columnKeys = null;
		for (Amount amounts : list) {
			value = amounts.getAmount();
			rowKeys = amounts.getSwName();
			columnKeys = amounts.getSwName();
			dataset.addValue(value, rowKeys, columnKeys);
			System.out.println(value + "  " + rowKeys + "  " + columnKeys);
		}
		return dataset;
	}

	/**
	 * 收入条形统计图
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getColumnChart.action")
	public String getColumnChartIn(HttpServletRequest request, HttpSession response, ModelMap modelMap)
			throws Exception {
		CategoryDataset dataset = createDateSetIn(response);
		JFreeChart chart = ChartFactory.createBarChart3D("收入来源统计图", "来源", 
				"金额（元）",dataset, PlotOrientation.VERTICAL, false, false, false );
		chart.setBackgroundPaint(ChartColor.WHITE); 
		CategoryPlot p = chart.getCategoryPlot();
		p.setBackgroundPaint(ChartColor.white);
		p.setRangeGridlinePaint(ChartColor.WHITE);
		BarRenderer renderer = (BarRenderer) p.getRenderer();
		renderer.setMaximumBarWidth(0.06);
		getChartByFont(chart);
		String fileName = ServletUtilities.saveChartAsJPEG(chart, 700, 400, null, request.getSession());
		String chartURL = request.getContextPath() + "/chart?filename=" + fileName;
		modelMap.put("chartURL", chartURL);
		return chartURL;
	}

	private CategoryDataset createDateSetOut(HttpSession seession) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		// List<CountAmount> data = new ArrayList<CountAmount>();
		UserLogin user = (UserLogin) seession.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> amount = countAmountServvices.countAmountOut(userID);
		List<Amount> list = getListByGroup(amount);
		double value = 0;
		String rowKeys = null;
		String columnKeys = null;
		for (Amount amounts : list) {
			value = amounts.getAmount();
			rowKeys = amounts.getSwName();
			columnKeys = amounts.getSwName();
			dataset.addValue(value, rowKeys, columnKeys);
			System.out.println(value + "  " + rowKeys + "  " + columnKeys);
		}
		return dataset;
	}
	@ResponseBody
	@RequestMapping(value = "/getColumnChartout.action")
	public String getColumnChartOut(HttpServletRequest request, HttpSession response, ModelMap modelMap)
			throws Exception {
		// 1. 获得数据集合
		CategoryDataset dataset = createDateSetOut(response);
		// 2. 创建柱状图
		JFreeChart chart = ChartFactory.createBarChart3D("支出去向统计图", // 图表标题
				"去向", // 目录轴的显示标签
				"金额（元）", // 数值轴的显示标签
				dataset, // 数据集
				PlotOrientation.VERTICAL, // 图表方向：水平、垂直
				false, // 是否显示图例(对于简单的柱状图必须是false)
				false, // 是否生成工具
				false // 是否生成URL链接
		);
		// 3. 设置整个柱状图的颜色和文字（char对象的设置是针对整个图形的设置）
		chart.setBackgroundPaint(ChartColor.WHITE); // 设置总的背景颜色

		// 4. 获得图形对象，并通过此对象对图形的颜色文字进行设置
		CategoryPlot p = chart.getCategoryPlot();// 获得图表对象
		p.setBackgroundPaint(ChartColor.WHITE);// 图形背景颜色
		p.setRangeGridlinePaint(ChartColor.WHITE);// 图形表格颜色

		// 5. 设置柱子宽度
		BarRenderer renderer = (BarRenderer) p.getRenderer();
		renderer.setMaximumBarWidth(0.06);

		// 解决乱码问题
		getChartByFont(chart);

		// 6. 将图形转换为图片，传到前台
		String fileName = ServletUtilities.saveChartAsJPEG(chart, 700, 400, null, request.getSession());
		String chartURL = request.getContextPath() + "/chart?filename=" + fileName;
		modelMap.put("chartURL", chartURL);
		return chartURL;
	}

	// 设置文字样式
	private static void getChartByFont(JFreeChart chart) {
		// 1. 图形标题文字设置
		TextTitle textTitle = chart.getTitle();
		textTitle.setFont(new Font("宋体", Font.BOLD, 20));

		// 2. 图形X轴坐标文字的设置
		CategoryPlot plot = (CategoryPlot) chart.getPlot();
		CategoryAxis axis = plot.getDomainAxis();
		axis.setLabelFont(new Font("宋体", Font.BOLD, 22)); // 设置X轴坐标上标题的文字
		axis.setTickLabelFont(new Font("宋体", Font.BOLD, 15)); // 设置X轴坐标上的文字

		// 2. 图形Y轴坐标文字的设置
		ValueAxis valueAxis = plot.getRangeAxis();
		valueAxis.setLabelFont(new Font("宋体", Font.BOLD, 15)); // 设置Y轴坐标上标题的文字
		valueAxis.setTickLabelFont(new Font("sans-serif", Font.BOLD, 12));// 设置Y轴坐标上的文字
	}
	/**
	 * 下面为生成饼图方法
	 * @param seession
	 * @return
	 */
	private PieDataset createPieDateIn(HttpSession seession) {
		DefaultPieDataset dateset = new DefaultPieDataset();
		UserLogin user = (UserLogin) seession.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> amount = countAmountServvices.countAmountIn(userID);
		List<Amount> list = getListByGroup(amount);
		double i;
		String desc;
		for (Amount amounts : list) {
			i = amounts.getAmount();
			desc = amounts.getSwName();
			// columnKeys = amounts.getSwName();
			dateset.setValue(desc, i);
			;
			System.out.println(desc + "  " + desc + "  " + i);
		}
		return dateset;
	}
	@ResponseBody
	@RequestMapping(value = "/getPieIn.action")
	public String getPieIn(HttpServletRequest request, HttpSession response, ModelMap modelMap) throws Exception {
		// 1. 获得数据集合
		// CategoryDataset dataset = createDateSetOut(response);
		PieDataset dataset = createPieDateIn(response);
		StandardChartTheme mChartTheme = new StandardChartTheme("CN");
		mChartTheme.setLargeFont(new Font("黑体", Font.BOLD, 20));
		mChartTheme.setExtraLargeFont(new Font("宋体", Font.PLAIN, 15)); // 标题
		mChartTheme.setRegularFont(new Font("宋体", Font.PLAIN, 15));
		ChartFactory.setChartTheme(mChartTheme);
		// 2. 创建饼状图
		JFreeChart chart = ChartFactory.createPieChart("收入来源分布图", dataset, true, false, false);
		// 3. 设置整个柱状图的颜色和文字（char对象的设置是针对整个图形的设置）
		chart.setBackgroundPaint(ChartColor.WHITE); // 设置总的背景颜色
		PiePlot pieplot = (PiePlot) chart.getPlot();
		pieplot.setLabelFont(new Font("宋体", 0, 12));
		pieplot.setBackgroundPaint(ChartColor.WHITE);
		pieplot.setSimpleLabels(true);
		// 标题
		TextTitle texttitle = chart.getTitle();
		texttitle.setFont(new Font("宋体", Font.BOLD, 30));
		// 图示
		LegendTitle legendtitle = chart.getLegend();
		legendtitle.setItemFont(new Font("宋体", Font.BOLD, 14));
		// 设定背景透明度（0-1.0之间）
		pieplot.setBackgroundAlpha(0.5f);
		// 设定前景透明度（0-1.0之间）
		pieplot.setForegroundAlpha(0.60f);
		// 没有数据的时候显示的内容
		pieplot.setNoDataMessage("无数据显示");
		pieplot.setCircular(false);
		pieplot.setLabelGap(0.02D);
		// 6. 将图形转换为图片，传到前台
		String fileName = ServletUtilities.saveChartAsJPEG(chart, 700, 400, null, request.getSession());
		String chartURL = request.getContextPath() + "/chart?filename=" + fileName;
		modelMap.put("chartURL", chartURL);
		return chartURL;
	}
	
	private PieDataset createPieDateOut(HttpSession seession) {
		DefaultPieDataset dateset = new DefaultPieDataset();
		UserLogin user = (UserLogin) seession.getAttribute("user");
		int userID = user.getUserID();
		List<Amount> amount = countAmountServvices.countAmountOut(userID);
		List<Amount> list = getListByGroup(amount);
		double i;
		String desc;
		for (Amount amounts : list) {
			i = amounts.getAmount();
			desc = amounts.getSwName();
			// columnKeys = amounts.getSwName();
			dateset.setValue(desc, i);
			;
			System.out.println(desc + "  " + desc + "  " + i);
		}
		return dateset;
	}
	@ResponseBody
	@RequestMapping(value = "/getPieOut.action")
	public String getPieOut(HttpServletRequest request, HttpSession response, ModelMap modelMap) throws Exception {
		// 1. 获得数据集合
		// CategoryDataset dataset = createDateSetOut(response);
		PieDataset dataset = createPieDateOut(response);
		StandardChartTheme mChartTheme = new StandardChartTheme("CN");
		mChartTheme.setLargeFont(new Font("黑体", Font.BOLD, 20));
		mChartTheme.setExtraLargeFont(new Font("宋体", Font.PLAIN, 15)); // 标题
		mChartTheme.setRegularFont(new Font("宋体", Font.PLAIN, 15));
		ChartFactory.setChartTheme(mChartTheme);
		// 2. 创建饼状图
		JFreeChart chart = ChartFactory.createPieChart("支出去向分布图", dataset, true, false, false);
		// 3. 设置整个柱状图的颜色和文字（char对象的设置是针对整个图形的设置）
		chart.setBackgroundPaint(ChartColor.WHITE); // 设置总的背景颜色
		PiePlot pieplot = (PiePlot) chart.getPlot();
		pieplot.setLabelFont(new Font("宋体", 0, 12));
		pieplot.setBackgroundPaint(ChartColor.WHITE);
		pieplot.setSimpleLabels(true);
		// 标题
		TextTitle texttitle = chart.getTitle();
		texttitle.setFont(new Font("宋体", Font.BOLD, 30));
		// 图示
		LegendTitle legendtitle = chart.getLegend();
		legendtitle.setItemFont(new Font("宋体", Font.BOLD, 14));
		// 设定背景透明度（0-1.0之间）
		pieplot.setBackgroundAlpha(0.5f);
		// 设定前景透明度（0-1.0之间）
		pieplot.setForegroundAlpha(0.60f);
		// 没有数据的时候显示的内容
		pieplot.setNoDataMessage("无数据显示");
		pieplot.setCircular(false);
		pieplot.setLabelGap(0.02D);
		// 6. 将图形转换为图片，传到前台
		String fileName = ServletUtilities.saveChartAsJPEG(chart, 700, 400, null, request.getSession());
		String chartURL = request.getContextPath() + "/chart?filename=" + fileName;
		modelMap.put("chartURL", chartURL);
		return chartURL;
	}
}

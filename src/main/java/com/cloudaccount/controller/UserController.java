package com.cloudaccount.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cloudaccount.entities.UserLogin;
import com.cloudaccount.services.IUserServices;

/**
 * 用户控制器
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {
	// @Resource
	// private UserLoginDao userDao;
	@Autowired
	private IUserServices userServices;

	@RequestMapping("/view")
	public String view() {
		return "main/login";
	}

	@RequestMapping("/indexview")
	public String index() {
		return "main/index";
	}
	/**
	 * 检查用户名是否存在及合法
	 * 用于登录，注册不同用户名
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	
	@RequestMapping(value = "/checkUser.action", method = RequestMethod.POST)
	@ResponseBody
    public int checkUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

      //  PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String regx = "^[A-Za-z0-9\\-]+";
        System.out.println(name);
        if (name.trim().equals("")) {
          //  out.print(2);// 2是不能为空
            return 2;
        } else {
            UserLogin user = userServices.findUserByName(name);
            if (user != null) {
           //     out.print(1);// 1用户名已存在F
                return 1;
            } else {
           //     out.print(3);// 用户名可以用
            	if(!name.matches(regx)){
            		return 0;
            	}
                return 3;
            }
        }
	}
	@RequestMapping(value = "/checkPwd.action", method = RequestMethod.POST)
	@ResponseBody
	public int checkPwd(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
		String password=request.getParameter("password");
		System.out.println("密码："+password);
		UserLogin user = (UserLogin) session.getAttribute("user");
		System.out.println(user.getUserName());
		if(user.getPassword().equals(password)){
			return 1;
		}else{
			return 0;
		}
	}

	/**
	 * 用户登陆
	 * 
	 * @param userName
	 * @param password
	 * @param mv
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "/login.action", method = RequestMethod.POST)
	public ModelAndView login(String userName, String password, ModelAndView mv, HttpSession session) {
		UserLogin user = userServices.check(userName, password);
		if (null != user) {
			// 登录成功，将user对象设置到HttpSession作用范围域中
			session.setAttribute("user", user);
			mv.setViewName("main");
		} else {
			mv.setViewName("error");
		}
		return mv;
	}

	/**
	 * 用户注册
	 */
	@RequestMapping(value = "/register.action", method = RequestMethod.POST)
	public String register(UserLogin user) {		
			// 添加用户
			userServices.register(user);
			return "login";
	}

	@RequestMapping(value = "/changePwd.action", method = RequestMethod.POST)
	public String changePwd(String oldPwd, String newPwd, HttpSession session) {
		UserLogin user = (UserLogin) session.getAttribute("user");
		if (user.getPassword().equals(oldPwd)) {
			System.out.println("老密码"+oldPwd);
			user.setPassword(newPwd);
			System.out.println("新密码"+newPwd);
			userServices.change(user);
			session.invalidate();;
			return "login";
		} else {
			return "error";
		}
	}
	
	@RequestMapping(value="/logout.action")
    public String execute(HttpSession session){
        session.invalidate();
        return "login";
    }

}

package com.cloudaccount.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import org.springframework.web.servlet.ModelAndView;  
import com.cloudaccount.entities.UserLogin;
/**
 * 登陆状态判断
 * @author XieJM
 *
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Override  
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)  
            throws Exception {  
        super.afterCompletion(request, response, handler, ex);  
    }  
  
    @Override  
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,  
            ModelAndView modelAndView) throws Exception {  
        super.postHandle(request, response, handler, modelAndView);  
    }  
  
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)  
            throws Exception {  
        request.setCharacterEncoding("UTF-8");  
        String url = request.getServletPath();      
        System.out.println("post URL："+url);  
        if(!url.equals("")){  
            //判斷是否已登录  
            UserLogin loginUser = (UserLogin)request.getSession().getAttribute("user");  
            if(loginUser == null){  
                //無session則是未登录狀態  
              //  System.out.println(">>>未登录，请登录<<<");  
                response.sendRedirect("../login.jsp");  
                return false;  
            }  
        }  
        return true;  
        //return super.preHandle(request, response, handler);  
    }  
}

package com.online.college.controller;

import com.online.college.core.auth.service.AuthService;
import com.online.college.core.user.service.UserFollowService;
import com.online.college.dao.TAuthUserMapper;
import com.online.college.module.TAuthUser;
import com.online.college.param.AuthRegisterParam;
import com.online.util.JsonData;
import com.online.util.SessionContext;
import com.online.util.StringUtil;
import com.online.util.exception.ParamException;
import com.online.util.page.TailPage;
import com.sun.deploy.net.HttpResponse;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1119:31
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/auth")
public class AuthController {

    @Resource
    private AuthService authService;
    @Resource
    private UserFollowService userFollowService;

    @RequestMapping("/register.page")
    public ModelAndView register(){
        return new ModelAndView("/auth/register");
    }

    @RequestMapping(value = "/doRegister.json")
    @ResponseBody
    public JsonData doRegister(AuthRegisterParam authRegisterParam,HttpServletRequest request) {
        authService.doRegister(authRegisterParam,request);
        return JsonData.success();
    }

    @RequestMapping("/login.page")
    public ModelAndView login(){
        return new ModelAndView("/auth/login");
    }

    @RequestMapping("/doLogin.json")
    @ResponseBody
    public JsonData doLogin(TAuthUser tAuthUser, String identiryCode, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws ServletException, IOException {
       authService.doLogin(tAuthUser,identiryCode,request,response,httpSession);
        return JsonData.success();
    }

    @RequestMapping("/logout.json")
    @ResponseBody
    public JsonData doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SessionContext.removeAttribute(request,"user");
        return JsonData.success();
    }

    @RequestMapping("/doFollow/{teacherId}.json")
    @ResponseBody
    public JsonData doFollow(HttpServletRequest request, HttpServletResponse response,@PathVariable Integer teacherId) throws IOException, ServletException {
        TAuthUser tAuthUser = (TAuthUser) SessionContext.getAttribute(request,"user");
        if(tAuthUser==null){
          throw new ParamException("未登录");
        }
        return userFollowService.doFollow(tAuthUser,teacherId);
    }

}

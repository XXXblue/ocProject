package com.online.college.opt;

import com.online.college.core.auth.service.AuthService;
import com.online.college.module.TAuthUser;
import com.online.util.JsonData;
import com.online.util.page.TailPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2213:50
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private AuthService authService;

    @RequestMapping("/userPageList.page")
    public ModelAndView userPageList(TAuthUser tAuthUser, TailPage<TAuthUser> page){
        ModelAndView mv = new ModelAndView("/user/userPageList");
        mv.addObject("curNav","user");
        page = authService.queryUser(tAuthUser,page);
        mv.addObject("queryEntity",tAuthUser);
        mv.addObject("page",page);
        return  mv ;
    }

    @RequestMapping("/save")
    @ResponseBody
    public JsonData save(TAuthUser tAuthUser){
        return authService.save(tAuthUser);
    }

    @RequestMapping("/getById.json")
    @ResponseBody
    public JsonData getById(Integer id){
        TAuthUser tAuthUser =authService.getById(id);
        return JsonData.success(tAuthUser);
    }
}

package com.online.college.opt;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1815:24
 * @Description:
 * @Modified By:
 */
@Controller
public class OperatorController {


    @RequestMapping(value={" ","/","/index"})
    public ModelAndView index(){
        ModelAndView mv =new ModelAndView("/cms/index");
        return mv;
    }
}

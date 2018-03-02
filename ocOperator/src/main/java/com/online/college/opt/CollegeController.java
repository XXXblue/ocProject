package com.online.college.opt;

import com.online.college.core.consts.service.TConstsCollegeService;
import com.online.college.module.TConstsCollege;
import com.online.college.param.TConstsCollegeParam;
import com.online.util.JsonData;
import com.online.util.page.TailPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1815:06
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/college")
public class CollegeController {
    @Resource
    private TConstsCollegeService tConstsCollegeService;

    @RequestMapping(value = "/queryPageList")
    public ModelAndView queryPage(TConstsCollege tConstsCollege, TailPage<TConstsCollege>page){
        ModelAndView mv = new ModelAndView("/college/collegePageList");
        tConstsCollegeService.queryPage(tConstsCollege,page);
        mv.addObject("curNav","college");
        mv.addObject("page",page);
        mv.addObject("tConstsCollege",tConstsCollege);
        return mv;
    }

    @RequestMapping(value = "/save.json")
    @ResponseBody
    public JsonData queryPage(TConstsCollegeParam tConstsCollege){
        tConstsCollegeService.save(tConstsCollege);
        return JsonData.success();
    }

    @RequestMapping(value = "/getById")
    @ResponseBody
    public JsonData getById(Integer id){
        return JsonData.success(tConstsCollegeService.getById(id));
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public JsonData delete(Integer id){
        tConstsCollegeService.delete(id);
        return JsonData.success();
    }
}

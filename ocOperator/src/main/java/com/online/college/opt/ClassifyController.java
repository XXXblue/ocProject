package com.online.college.opt;

import com.online.college.core.consts.service.TConstsClassifyService;
import com.online.college.module.TConstsClassify;
import com.online.college.param.TConstsClassifyParam;
import com.online.util.JsonData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/230:13
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/classify")
public class ClassifyController {
    @Resource
    public TConstsClassifyService tConstsClassifyService;

    @RequestMapping("/index.page")
    public ModelAndView classifyList(){
        List<TConstsClassify>classifys = tConstsClassifyService.queryAllFirst();
        List<TConstsClassify>subClassifys = tConstsClassifyService.queryAllSecond();
        ModelAndView mv = new ModelAndView("/classify/classifyPageList");
        mv.addObject("classify",classifys);
        mv.addObject("subClassifys",subClassifys);
        mv.addObject("curNav","classify");
        return mv;
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData save(TConstsClassifyParam tConstsClassifyParam){
        return tConstsClassifyService.save(tConstsClassifyParam);
    }

    @RequestMapping("/getById.json")
    @ResponseBody
    public JsonData getById(Integer id){
        return JsonData.success(tConstsClassifyService.getById(id));
    }
}

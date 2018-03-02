package com.online.college.opt;

import com.online.college.core.consts.service.TConstsClassifyService;
import com.online.college.core.course.service.TCourseService;
import com.online.college.core.course.service.TUserCourseSectionService;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TConstsClassify;
import com.online.college.module.TCourse;
import com.online.college.param.TConstsCourseParam;
import com.online.util.JsonData;
import com.online.util.page.TailPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2514:39
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/course")
public class CourseController {
    @Resource
    private TCourseService tCourseService;
    @Resource
    private TConstsClassifyService tConstsClassifyService;

    @RequestMapping("/coursePageList.page")
    public ModelAndView modelAndView(TCourse tCourse, TailPage<TCourse>page){
        //设置显示条目
        page.setPageSize(5);
        page = tCourseService.queryCourse(tCourse,page);
        ModelAndView mv =new ModelAndView("/course/coursePageList");
        mv.addObject("page",page);
        mv.addObject("curNav","course");
        mv.addObject("queryEntity",tCourse);
        return mv;
    }

    @RequestMapping("/doSale.json")
    @ResponseBody
    public JsonData doSale(Integer id,Integer onsale){
        tCourseService.doSale(id,onsale);
        return JsonData.success();
    }

    @RequestMapping("/read.page")
    public ModelAndView read(Integer id){
        ModelAndView mv =new ModelAndView("/course/read");
        TCourse course = tCourseService.getCourseById(id);
        List<TCourseSectionDto> chaptSections = tCourseService.getSelectionByCourseId(id);
        List<TConstsClassify>classifys = tConstsClassifyService.queryAllFirst();
        List<TConstsClassify>subClassifys = tConstsClassifyService.queryAllSecond();
        mv.addObject("classify",classifys);
        mv.addObject("subClassifys",subClassifys);
        mv.addObject("chaptSections",chaptSections);
        mv.addObject("course",course);
        mv.addObject("curNav","course");
        return mv;
    }

    @RequestMapping("/append.page")
    public ModelAndView append(Integer courseId){
        TCourse course = tCourseService.getCourseById(courseId);
        ModelAndView mv =new ModelAndView("/course/append");
        mv.addObject("course",course);
        mv.addObject("curNav","course");
        return mv;
    }

    @RequestMapping("/addCourse.page")
    public ModelAndView addCourse(){
        ModelAndView mv = new ModelAndView("/course/addCourse");
        List<TConstsClassify>classifys = tConstsClassifyService.queryAllFirst();
        List<TConstsClassify>subClassifys = tConstsClassifyService.queryAllSecond();
        mv.addObject("curNav","course");
        mv.addObject("classify",classifys);
        mv.addObject("subClassifys",subClassifys);
        return mv;
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData save(HttpServletResponse response,TConstsCourseParam tConstsCourseParam, @RequestParam MultipartFile pictureImg) throws IOException {
        if(pictureImg != null && pictureImg.getBytes().length > 0){
            //TODO:做图片上传
        }
       return tCourseService.save(tConstsCourseParam);
    }

    @RequestMapping("/getById.json")
    @ResponseBody
    public JsonData getById(Integer id){
        return JsonData.success(tCourseService.getCourseById(id));
    }
}

package com.online.college.controller;

import com.online.college.core.auth.service.AuthService;
import com.online.college.core.consts.service.TConstsClassifyService;
import com.online.college.core.consts.service.TConstsSiteCarouselService;
import com.online.college.core.course.service.TCourseService;
import com.online.college.dto.TConstsClassifyLevelDto;
import com.online.college.module.TAuthUser;
import com.online.college.module.TConstsSiteCarousel;
import com.online.college.module.TCourse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1312:58
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping()
public class PortalController
{
    @Resource
    private TConstsSiteCarouselService tConstsSiteCarouselService;
    @Resource
    private TConstsClassifyService tConstsClassifyService;
    @Resource
    private TCourseService tCourseService;
    @Resource
    private AuthService authService;

    @RequestMapping(value={" ","/","/index"})
    public ModelAndView index(){
        ModelAndView mv =new ModelAndView("index");
        //轮播
        List<TConstsSiteCarousel> carouselList = tConstsSiteCarouselService.queryCarousel(4);
        mv.addObject("carouselList",carouselList);

        //多级分类展示
        List<TConstsClassifyLevelDto> classifys =tConstsClassifyService.queryAllClassify(null);
        mv.addObject("classifys",classifys);

        //获取5门免费课推荐，根据权重（weight）进行排序
        List<TCourse> freeCourseList=tCourseService.freeCourseList();
        mv.addObject("freeCourseList",freeCourseList);
        //获取5门实战课推荐，根据权重（weight）进行排序
        List<TCourse> notFreeCourseList = tCourseService.noFreeCourseList();
        mv.addObject("notFreeCourseList",notFreeCourseList);
        //7门java课程，多喜欢java呀
        List<TCourse> javaCourseList = tCourseService.javaCourseList();
        mv.addObject("javaCourseList",javaCourseList);
        //获取五个教师
        List<TAuthUser> recomdTeacher= authService.queryRecomd();
        mv.addObject("recomdTeacher",recomdTeacher);
        return mv;
    }
}

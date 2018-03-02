package com.online.college.controller;

import com.online.college.core.auth.service.AuthService;
import com.online.college.core.course.service.TCourseService;
import com.online.college.core.course.service.TUserCollectionsService;
import com.online.college.core.course.service.TUserCourseSectionService;
import com.online.college.core.user.service.UserFollowService;
import com.online.college.dao.TAuthUserMapper;
import com.online.college.dao.TUserCourseSectionMapper;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TAuthUser;
import com.online.college.module.TCourse;
import com.online.college.module.TUserCollections;
import com.online.util.JsonData;
import com.online.util.SessionContext;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2021:11
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/course")
public class CourseController {

    @Resource
    private TCourseService tCourseService;

    @Resource
    private AuthService authService;

    @Resource
    private TUserCollectionsService tUserCollectionsService;

    @Resource
    private TUserCourseSectionService tUserCourseSectionService;

    @Resource
    private UserFollowService userFollowService;

    @RequestMapping("/learn/{courseId}.page")
    public ModelAndView courseDetail(@PathVariable Integer courseId, HttpServletRequest request) {
        ModelAndView mv = null;
        if (null == courseId) {
            mv = new ModelAndView("/error/404");
            return mv;
        }
        TCourse tCourse = tCourseService.selectByPrimaryKey(courseId);
        if (tCourse == null) {
            mv = new ModelAndView("/error/404");
            return mv;
        }
        mv = new ModelAndView("/course/learn");
        mv.addObject("course", tCourse);
        TAuthUser tAuthUser= (TAuthUser) SessionContext.getAttribute(request,"user");
        if(tAuthUser!=null&&(tUserCollectionsService.getCollectStatus(tAuthUser,courseId))){
            mv.addObject("ifCollect",true);
        }
        if(tAuthUser!=null&&(tUserCourseSectionService.getByAuthAndCourseId(tAuthUser,courseId))){
            mv.addObject("ifLearn",true);
        }
        List<TCourseSectionDto> list = tCourseService.getSelectionByCourseId(courseId);
        mv.addObject("chaptSections", list);
        TAuthUser teacher = authService.getByUserName(tCourse.getUsername());
        if (teacher != null) {
            mv.addObject("courseTeacher", teacher);
            if(tAuthUser!=null&&(userFollowService.getByAuthAndTeacherId(teacher.getId(),tAuthUser.getId()))){
                mv.addObject("ifFollow",true);
            }
        }
        //获取5门实战课推荐，根据权重（weight）进行排序
        List<TCourse> notFreeCourseList = tCourseService.noFreeCourseList();
        mv.addObject("recomdCourseList", notFreeCourseList);
        return mv;
    }

    @RequestMapping("/save/{courseId}.page")
    public void save(@PathVariable Integer courseId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TAuthUser tAuthUser = (TAuthUser) SessionContext.getAttribute(request,"user");
        if(tAuthUser==null){
            request.getRequestDispatcher("/auth/login.page").forward(request,response);
            return;
        }
        tUserCollectionsService.save(tAuthUser,courseId);
        response.sendRedirect(request.getContextPath()+"/course/learn/"+courseId+".page");
//        request.getRequestDispatcher("/learn/"+courseId+".page").forward(request,response);
    }
}

package com.online.college.controller;

import com.online.college.core.consts.service.TConstsClassifyService;
import com.online.college.core.course.service.TCourseService;
import com.online.college.dto.TConstsClassifyLevelDto;
import com.online.college.module.TConstsClassify;
import com.online.college.module.TCourse;
import com.online.util.page.TailPage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1414:37
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/course")
public class CourseListController {
    @Resource
    private TConstsClassifyService tConstsClassifyService;
    @Resource
    private TCourseService tCourseService;

    @RequestMapping("/list.page")
    public ModelAndView listCoursePage(String c, String sort, TailPage<TCourse> page) {
        //这里的-1和-2 暗示所有
        String curCode = "-1";//当前方向code
        String curSubCode = "-2";//当前分类code
        ModelAndView mv = new ModelAndView("/course/list");
        //先解决一级
        Map<String, List<TConstsClassifyLevelDto>> map = new HashMap<String, List<TConstsClassifyLevelDto>>();
        List<TConstsClassifyLevelDto> classifysList = tConstsClassifyService.queryAllClassify(map);
        mv.addObject("classifys", classifysList);
        TConstsClassify tConstsClassify = tConstsClassifyService.getByCode(c);
        //解决二级
        //根据code拿出所有，没有则全拿。
        List<TConstsClassifyLevelDto> subClassifys = null;
        if (c == null || c.equals("-1") || c.equals("-2")) {
            subClassifys = new ArrayList<TConstsClassifyLevelDto>();
            Iterator iterator = map.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry entry = (Map.Entry) iterator.next();
                List<TConstsClassifyLevelDto> tempList = (List<TConstsClassifyLevelDto>) entry.getValue();
                subClassifys.addAll(tempList);
            }
        } else {
            TConstsClassify tc = tConstsClassifyService.getByCode(c);
            if (tc != null) {
                if (map.containsKey(c)) {
                    //这代码就会为了防止以后有人看懂，很简单，点爹拿子，点子拿兄弟，之所以写这么复杂是因为想简化
                    subClassifys = map.get(c);
                    curCode = c;
                } else {
                    subClassifys = map.get(tc.getParentCode());
                    curSubCode = c;
                    curCode = tc.getParentCode();
                }
            } else {
                subClassifys = new ArrayList<TConstsClassifyLevelDto>();
                Iterator iterator = map.entrySet().iterator();
                while (iterator.hasNext()) {
                    Map.Entry entry = (Map.Entry) iterator.next();
                    List<TConstsClassifyLevelDto> tempList = (List<TConstsClassifyLevelDto>) entry.getValue();
                    subClassifys.addAll(tempList);
                }
            }
        }
        mv.addObject("subClassifys", subClassifys);
        mv.addObject("curCode", curCode);
        mv.addObject("curSubCode", curSubCode);
        mv.addObject("sort", sort);
        if (sort != null) {
            if (sort.equals("last")) {
                page.setSortField("id");
                page.setSortDirection("DESC");
            } else if (sort.equals("pop")) {
                page.setSortField("study_count");
                page.setSortDirection("DESC");
            }
        }
        TCourse tCourse = new TCourse();
        if (!"-1".equals(curCode)) {
            tCourse.setClassify(curCode);
        }
        if (!"-2".equals(curSubCode)) {
            tCourse.setSubClassify(curSubCode);
        }
        tCourse.setOnsale(true);
        TailPage<TCourse> resultPage = tCourseService.queryPage(tCourse, page);
        mv.addObject("page", resultPage);
        return mv;
    }
}

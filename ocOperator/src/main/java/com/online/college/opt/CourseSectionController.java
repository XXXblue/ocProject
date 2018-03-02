package com.online.college.opt;

import com.online.college.core.course.service.TCourseSectionService;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TCourse;
import com.online.college.module.TCourseSection;
import com.online.college.param.TCourseSectionParam;
import com.online.util.JsonData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2521:44
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/courseSection")
public class CourseSectionController {
    @Resource
    private TCourseSectionService tCourseSectionService;

    @RequestMapping("/batchAdd.json")
    @ResponseBody
    public JsonData batchAdd(@RequestBody List<TCourseSectionDto> batchSections){
        tCourseSectionService.batchAdd(batchSections);
        return JsonData.success();
    }

    @RequestMapping("/getById.json")
    @ResponseBody
    public JsonData getById(Integer id){
        return tCourseSectionService.getById(id);
    }

    @RequestMapping("/saveSection.json")
    @ResponseBody
    public JsonData saveSection(TCourseSectionParam tCourseSectionParam){
        return tCourseSectionService.saveSection(tCourseSectionParam);
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(Integer id){
        return tCourseSectionService.delete(id);
    }

    @RequestMapping("/sortSection.json")
    @ResponseBody
    public JsonData sortSection(Integer id,String sortType){
        return tCourseSectionService.sortSection(id,sortType);
    }

}

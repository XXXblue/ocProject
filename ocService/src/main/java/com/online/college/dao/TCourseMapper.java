package com.online.college.dao;

import com.online.college.dto.CourseQueryDto;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TCourse;
import com.online.college.module.TCourseSection;
import com.online.util.page.TailPage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TCourseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TCourse record);

    int insertSelective(TCourse record);

    TCourse selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TCourse record);

    int updateByPrimaryKeyWithBLOBs(TCourse record);

    int updateByPrimaryKey(TCourse record);

    public List<TCourse> queryList(@Param("dto") CourseQueryDto dto);

    int queryPageNum(@Param("course") TCourse tCourse, @Param("page") TailPage<TCourse> page);

    List<TCourse> queryPage(@Param("course") TCourse tCourse, @Param("page") TailPage<TCourse> page);

    Integer selectCourseClassifyId(@Param("courseId") Integer courseId);

}
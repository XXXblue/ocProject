package com.online.college.dao;

import com.online.college.module.TCourseSection;
import com.online.college.module.TUserCourseSection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TUserCourseSectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserCourseSection record);

    int insertSelective(TUserCourseSection record);

    TUserCourseSection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserCourseSection record);

    int updateByPrimaryKey(TUserCourseSection record);

    void batchInsert(@Param("list") List<TUserCourseSection> tUserCourseSections);


    List<TUserCourseSection> getByAuthAndCourseId(@Param("id") Integer id,@Param("courseId") Integer courseId);

    void deleteUserTCourseSectionByCourseIdAndSectionId(@Param("courseId") Integer courseId,@Param("subTCourseSection") List<TCourseSection> tCourseSectionSub);

    void deleteUserTCourseSectionByCourseIdAndOneSectionId(@Param("courseId") Integer courseId, @Param("sectionId") Integer id);
}
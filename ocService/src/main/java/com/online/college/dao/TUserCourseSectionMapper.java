package com.online.college.dao;

import com.online.college.module.TUserCourseSection;

public interface TUserCourseSectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserCourseSection record);

    int insertSelective(TUserCourseSection record);

    TUserCourseSection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserCourseSection record);

    int updateByPrimaryKey(TUserCourseSection record);
}
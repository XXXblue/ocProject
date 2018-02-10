package com.online.college.dao;

import com.online.college.module.TCourseSection;

public interface TCourseSectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TCourseSection record);

    int insertSelective(TCourseSection record);

    TCourseSection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TCourseSection record);

    int updateByPrimaryKey(TCourseSection record);
}
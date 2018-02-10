package com.online.college.dao;

import com.online.college.module.TCourseComment;

public interface TCourseCommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TCourseComment record);

    int insertSelective(TCourseComment record);

    TCourseComment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TCourseComment record);

    int updateByPrimaryKey(TCourseComment record);
}
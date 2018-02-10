package com.online.college.dao;

import com.online.college.module.TCourse;

public interface TCourseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TCourse record);

    int insertSelective(TCourse record);

    TCourse selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TCourse record);

    int updateByPrimaryKeyWithBLOBs(TCourse record);

    int updateByPrimaryKey(TCourse record);
}
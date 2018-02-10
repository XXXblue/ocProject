package com.online.college.dao;

import com.online.college.module.TConstsClassify;

public interface TConstsClassifyMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsClassify record);

    int insertSelective(TConstsClassify record);

    TConstsClassify selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsClassify record);

    int updateByPrimaryKey(TConstsClassify record);
}
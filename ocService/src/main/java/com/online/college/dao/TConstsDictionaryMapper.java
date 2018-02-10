package com.online.college.dao;

import com.online.college.module.TConstsDictionary;

public interface TConstsDictionaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsDictionary record);

    int insertSelective(TConstsDictionary record);

    TConstsDictionary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsDictionary record);

    int updateByPrimaryKey(TConstsDictionary record);
}
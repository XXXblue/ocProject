package com.online.college.dao;

import com.online.college.module.TUserCollections;

public interface TUserCollectionsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserCollections record);

    int insertSelective(TUserCollections record);

    TUserCollections selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserCollections record);

    int updateByPrimaryKey(TUserCollections record);
}
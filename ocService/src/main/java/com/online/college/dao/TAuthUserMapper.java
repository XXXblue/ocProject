package com.online.college.dao;


import com.online.college.module.TAuthUser;

public interface TAuthUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TAuthUser record);

    int insertSelective(TAuthUser record);

    TAuthUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TAuthUser record);

    int updateByPrimaryKey(TAuthUser record);
}
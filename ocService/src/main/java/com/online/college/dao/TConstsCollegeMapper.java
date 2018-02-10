package com.online.college.dao;


import com.online.college.module.TConstsCollege;

public interface TConstsCollegeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsCollege record);

    int insertSelective(TConstsCollege record);

    TConstsCollege selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsCollege record);

    int updateByPrimaryKey(TConstsCollege record);
}
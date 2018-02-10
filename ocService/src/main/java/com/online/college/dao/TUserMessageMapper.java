package com.online.college.dao;

import com.online.college.module.TUserMessage;

public interface TUserMessageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserMessage record);

    int insertSelective(TUserMessage record);

    TUserMessage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserMessage record);

    int updateByPrimaryKey(TUserMessage record);
}
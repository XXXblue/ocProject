package com.online.college.dao;

import com.online.college.module.TUserFollows;
import org.apache.ibatis.annotations.Param;

public interface TUserFollowsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserFollows record);

    int insertSelective(TUserFollows record);

    TUserFollows selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserFollows record);

    int updateByPrimaryKey(TUserFollows record);

    TUserFollows selByUserIdAndFollowId(@Param("userId") Integer teacherId, @Param("followId")Integer id);
}
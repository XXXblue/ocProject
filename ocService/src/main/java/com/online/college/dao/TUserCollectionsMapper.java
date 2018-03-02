package com.online.college.dao;

import com.online.college.module.TUserCollections;
import org.apache.ibatis.annotations.Param;

public interface TUserCollectionsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TUserCollections record);

    int insertSelective(TUserCollections record);

    TUserCollections selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TUserCollections record);

    int updateByPrimaryKey(TUserCollections record);

    TUserCollections selectByUserIdAndCourseId(@Param("id") Integer id, @Param("courseId") Integer courseId);
}
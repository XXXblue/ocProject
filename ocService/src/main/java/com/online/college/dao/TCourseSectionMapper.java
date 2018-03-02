package com.online.college.dao;

import com.online.college.module.TCourseSection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TCourseSectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TCourseSection record);

    int insertSelective(TCourseSection record);

    TCourseSection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TCourseSection record);

    int updateByPrimaryKey(TCourseSection record);

    List<TCourseSection> getSelectionByCourseId(@Param("courseId") Integer courseId);

    void batchAdd(@Param("list") List<TCourseSection> newList);

    Integer getMaxSortByCourseId(Integer id);

    List<TCourseSection> getTCourseSectionSubByParentId(@Param("parentId") Integer id);

    void deleteBySubList(@Param("list") List<TCourseSection> tCourseSectionSub);

    Integer getMaxSortByCourseIdAndParentId(@Param("courseId") Integer courseId,@Param("parentId") Integer parentId);

    TCourseSection getExchangeCourseSectionUp(@Param("courseId") Integer courseId, @Param("parentId") Integer parentId, @Param("sort") Integer sort);

    TCourseSection getExchangeCourseSectionDown(@Param("courseId") Integer courseId, @Param("parentId") Integer parentId, @Param("sort") Integer sort);
}
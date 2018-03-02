package com.online.college.dao;

import com.online.college.module.TConstsSiteCarousel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TConstsSiteCarouselMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsSiteCarousel record);

    int insertSelective(TConstsSiteCarousel record);

    TConstsSiteCarousel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsSiteCarousel record);

    int updateByPrimaryKey(TConstsSiteCarousel record);

    List<TConstsSiteCarousel> queryCarousel(@Param("count") Integer count);
}
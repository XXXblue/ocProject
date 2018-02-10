package com.online.college.dao;

import com.online.college.module.TConstsSiteCarousel;

public interface TConstsSiteCarouselMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsSiteCarousel record);

    int insertSelective(TConstsSiteCarousel record);

    TConstsSiteCarousel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsSiteCarousel record);

    int updateByPrimaryKey(TConstsSiteCarousel record);
}
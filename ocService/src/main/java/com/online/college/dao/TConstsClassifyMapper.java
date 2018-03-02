package com.online.college.dao;

import com.online.college.module.TConstsClassify;
import com.online.college.param.TConstsClassifyParam;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TConstsClassifyMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsClassify record);

    int insertSelective(TConstsClassify record);

    TConstsClassify selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsClassify record);

    int updateByPrimaryKey(TConstsClassify record);

    List<TConstsClassify> getAll();

    List<TConstsClassify> getByCode(@Param("code")String code);

    List<TConstsClassify> queryAllFirst();

    List<TConstsClassify> queryAllSecond();

    int ifNameExist(@Param("classify")TConstsClassifyParam tConstsClassifyParam);

    int ifCodeExist(@Param("classify")TConstsClassifyParam tConstsClassifyParam);

    String getNameByCode(@Param("code") String code);
}
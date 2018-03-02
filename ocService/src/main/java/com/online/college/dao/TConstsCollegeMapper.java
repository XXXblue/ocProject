package com.online.college.dao;


import com.online.college.module.TConstsCollege;
import com.online.college.param.TConstsCollegeParam;
import com.online.util.page.TailPage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TConstsCollegeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TConstsCollege record);

    int insertSelective(TConstsCollege record);

    TConstsCollege selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TConstsCollege record);

    int updateByPrimaryKey(TConstsCollege record);

    int queryPageNum(@Param("college")TConstsCollege tConstsCollege);

    List<TConstsCollege>queryPage(@Param("college")TConstsCollege tConstsCollege, @Param("page")TailPage<TConstsCollege>page);

    int countByName(@Param("college") TConstsCollegeParam tConstsCollegeParam);

    int countByCode(@Param("college") TConstsCollegeParam tConstsCollegeParam);
}
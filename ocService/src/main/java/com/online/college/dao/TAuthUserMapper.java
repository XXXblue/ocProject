package com.online.college.dao;

import com.online.college.module.TAuthUser;
import com.online.util.page.TailPage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TAuthUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TAuthUser record);

    int insertSelective(TAuthUser record);

    TAuthUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TAuthUser record);

    int updateByPrimaryKey(TAuthUser record);

    int countByUsername(@Param("username") String username, @Param("id") Integer id);

    List<TAuthUser> queryRecomd();

    TAuthUser findByKeyWord(@Param("username") String username);

    int countByPageAndUser(@Param("user")TAuthUser tAuthUser);

    List<TAuthUser> queryByPageAndUser(@Param("user")TAuthUser tAuthUser, @Param("page")TailPage<TAuthUser> page);
}
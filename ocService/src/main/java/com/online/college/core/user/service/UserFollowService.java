package com.online.college.core.user.service;

import com.online.college.dao.TUserFollowsMapper;
import com.online.college.module.TAuthUser;
import com.online.college.module.TUserFollows;
import com.online.util.JsonData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/220:38
 * @Description:
 * @Modified By:
 */
@Service
public class UserFollowService {
    @Resource
    private TUserFollowsMapper tUserFollowsMapper;

    public JsonData doFollow(TAuthUser tAuthUser, Integer teacherId) {
        TUserFollows tUserFollows = tUserFollowsMapper.selByUserIdAndFollowId(teacherId,tAuthUser.getId());
        if(tUserFollows!=null){
            tUserFollowsMapper.deleteByPrimaryKey(tUserFollows.getId());
            return JsonData.success(2);
        }
        TUserFollows tUserFollowsNew=TUserFollows.builder().userId(teacherId).followId(tAuthUser.getId()).createTime(new Date()).createUser(tAuthUser.getUsername())
                .updateTime(new Date()).updateUser(tAuthUser.getUsername()).del(false).build();
        tUserFollowsMapper.insertSelective(tUserFollowsNew);
        return JsonData.success(3);
    }


    public boolean getByAuthAndTeacherId(Integer userId, Integer followId) {
        return tUserFollowsMapper.selByUserIdAndFollowId(userId,followId)==null?false:true;
    }
}

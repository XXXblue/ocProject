package com.online.college.core.consts.service;

import com.google.common.base.Preconditions;
import com.online.college.dao.TConstsCollegeMapper;
import com.online.college.module.TConstsCollege;
import com.online.college.param.TConstsCollegeParam;
import com.online.util.BeanValidator;
import com.online.util.JsonData;
import com.online.util.exception.ParamException;
import com.online.util.page.TailPage;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1913:33
 * @Description:
 * @Modified By:
 */
@Service
public class TConstsCollegeService {
    @Resource
    private TConstsCollegeMapper tConstsCollegeMapper;

    public TailPage<TConstsCollege> queryPage(TConstsCollege queryEntity , TailPage<TConstsCollege> page){
        Integer itemsTotalCount = tConstsCollegeMapper.queryPageNum(queryEntity);
        List<TConstsCollege> items = tConstsCollegeMapper.queryPage(queryEntity,page);
        page.setItemsTotalCount(itemsTotalCount);
        page.setItems(items);
        return page;
    }

    public void save(TConstsCollegeParam tConstsCollegeParam){
       if(tConstsCollegeParam.getId()!=null){
           BeanValidator.check(tConstsCollegeParam);
           if(ifExistName(tConstsCollegeParam)){
               throw new ParamException("学校名重复");
           }
           if(ifExistCode(tConstsCollegeParam)){
               throw new ParamException("邮政编码重复");
           }
          TConstsCollege before= tConstsCollegeMapper.selectByPrimaryKey(tConstsCollegeParam.getId());
           Preconditions.checkNotNull(before,"要修改的学校信息不存在");
           TConstsCollege after =TConstsCollege.builder().name(tConstsCollegeParam.getName()).id(tConstsCollegeParam.getId())
                   .code(tConstsCollegeParam.getCode()).updateTime(new Date()).updateUser("system").build();
           tConstsCollegeMapper.updateByPrimaryKeySelective(after);
       }else {
           BeanValidator.check(tConstsCollegeParam);
           if(ifExistName(tConstsCollegeParam)){
               throw new ParamException("学校名重复");
           }
           if(ifExistCode(tConstsCollegeParam)){
               throw new ParamException("邮政编码重复");
           }
           TConstsCollege newCollege = TConstsCollege.builder().name(tConstsCollegeParam.getName()).code(tConstsCollegeParam.getCode())
                   .createTime(new Date()).createUser("system").updateTime(new Date()).updateUser("system").del(false).build();
           tConstsCollegeMapper.insert(newCollege);
       }
    }

    private boolean ifExistName(TConstsCollegeParam tConstsCollegeParam){
        return tConstsCollegeMapper.countByName(tConstsCollegeParam)>0;
    }

    private boolean ifExistCode(TConstsCollegeParam tConstsCollegeParam){
        return tConstsCollegeMapper.countByCode(tConstsCollegeParam)>0;
    }

    public TConstsCollege getById(Integer id) {
        return tConstsCollegeMapper.selectByPrimaryKey(id);
    }

    public void delete(Integer id) {
        TConstsCollege tConstsCollege = tConstsCollegeMapper.selectByPrimaryKey(id);
        Preconditions.checkNotNull(tConstsCollege,"要删除的角色不存在");
        tConstsCollegeMapper.deleteByPrimaryKey(id);
    }
}

package com.online.college.core.test.service;

import com.online.college.dao.TAuthUserMapper;
import com.online.college.module.TAuthUser;
import com.online.college.param.TestParam;
import com.online.util.ApplicationContextHelper;
import com.online.util.BeanValidator;
import org.springframework.stereotype.Service;


/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1020:25
 * @Description:
 * @Modified By:
 */
@Service
public class TestService {

    public TAuthUser getById(TestParam test){
        ApplicationContextHelper applicationContextHelper = new ApplicationContextHelper();
        TAuthUserMapper tAuthUserMapper=applicationContextHelper.popBean(TAuthUserMapper.class);
        BeanValidator.check(test);
        return tAuthUserMapper.selectByPrimaryKey(6);
    }
}

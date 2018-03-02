package com.online.college.core.auth.service;

import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.online.college.dao.TAuthUserMapper;
import com.online.college.module.TAuthUser;
import com.online.college.param.AuthRegisterParam;
import com.online.util.BeanValidator;
import com.online.util.JsonData;
import com.online.util.MD5Util;
import com.online.util.SessionContext;
import com.online.util.exception.ParamException;
import com.online.util.page.TailPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1121:19
 * @Description:
 * @Modified By:
 */
@Service
public class AuthService {
    @Resource
    private TAuthUserMapper tAuthUserMapper;

    public void doRegister(AuthRegisterParam authRegisterParam, HttpServletRequest httpServletRequest){
            BeanValidator.check(authRegisterParam);
            String code= (String) SessionContext.getAttribute(httpServletRequest,SessionContext.IDENTIFY_CODE_KEY);
            if(!code.equals(authRegisterParam.getIdentiryCode())){
                throw new ParamException("验证码不通过");
            }
            if(isExists(authRegisterParam,null)>0){
                throw new ParamException("重复的用户名");
            }
             TAuthUser tAuthUser=TAuthUser.builder().username(authRegisterParam.getUsername()).password(MD5Util.encrypt(authRegisterParam.getPassword())).build();
            tAuthUserMapper.insertSelective(tAuthUser);
    }

    public int isExists(AuthRegisterParam authRegisterParam,Integer id){
        return tAuthUserMapper.countByUsername(authRegisterParam.getUsername(),id);
    }

    public List<TAuthUser> queryRecomd(){
        return tAuthUserMapper.queryRecomd();
    }

    public void doLogin(TAuthUser tAuthUser, String identiryCode, HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
        if(StringUtils.isBlank(tAuthUser.getUsername()))
        {
            throw new ParamException("用户名不能为空");
        }
        if(StringUtils.isBlank(tAuthUser.getPassword()))
        {
            throw new ParamException("密码不能为空");
        }
        if(!SessionContext.getIdentifyCode(request).equals(identiryCode)){
            throw new ParamException("验证码错误");
        }
        TAuthUser tAuthUserCheck= tAuthUserMapper.findByKeyWord(tAuthUser.getUsername());
        Preconditions.checkNotNull(tAuthUserCheck,"该用户不存在");
        if(!tAuthUserCheck.getPassword().equals(MD5Util.encrypt(tAuthUser.getPassword()))){
            throw new ParamException("用户名或者密码错误");
        }
        tAuthUserCheck.setPassword("");
        SessionContext.setAttribute(request,"user",tAuthUserCheck);
    }

    public TAuthUser getByUserName(String username) {
      return  tAuthUserMapper.findByKeyWord(username);
    }

    public TailPage<TAuthUser> queryUser(TAuthUser tAuthUser, TailPage<TAuthUser> page) {
        int total = tAuthUserMapper.countByPageAndUser(tAuthUser);
        if(total>0){
            List<TAuthUser> list = tAuthUserMapper.queryByPageAndUser(tAuthUser,page);
            if(CollectionUtils.isEmpty(list)){
                throw new ParamException("查询异常");
            }
            page.setItemsTotalCount(total);
            page.setItems(list);
            return page;
        }else {
            page.setItemsTotalCount(0);
            page.setItems(Lists.<TAuthUser>newArrayList());
            return page;
        }
    }

    public TAuthUser getById(Integer id) {
        return tAuthUserMapper.selectByPrimaryKey(id);
    }

    public JsonData save(TAuthUser tAuthUser) {
        TAuthUser authUser = tAuthUserMapper.selectByPrimaryKey(tAuthUser.getId());
        Preconditions.checkNotNull(authUser,"该用户信息不存在");
        authUser =TAuthUser.builder().id(tAuthUser.getId())
                .realname(tAuthUser.getRealname()).status(tAuthUser.getStatus()).updateTime(new Date()).updateUser("system").build();
        tAuthUserMapper.updateByPrimaryKeySelective(authUser);
        return JsonData.success();
    }
}

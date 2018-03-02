package com.online.college.controller;

import com.online.college.core.course.service.TUserCollectionsService;
import com.online.college.module.TAuthUser;
import com.online.college.module.TUserCollections;
import com.online.util.JsonData;
import com.online.util.SessionContext;
import com.online.util.exception.ParamException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2116:14
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/collections")
public class CollectionController {
    @Resource
    private TUserCollectionsService tUserCollectionsService;

    @RequestMapping("/doCollection/{courseId}.json")
    @ResponseBody
    public JsonData doCollection(@PathVariable Integer courseId, HttpServletRequest request){
        TAuthUser tAuthUser = (TAuthUser) SessionContext.getAttribute(request,"user");
        if(tAuthUser==null){
            throw new ParamException("用户未登录");
        }
        return tUserCollectionsService.changeCollectStatus(tAuthUser,courseId);

    }
}

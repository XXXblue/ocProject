package com.online.college.core.course.service;

import com.online.college.dao.TUserCourseSectionMapper;
import com.online.college.module.TAuthUser;
import com.online.college.module.TUserCourseSection;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2118:51
 * @Description:
 * @Modified By:
 */
@Service
public class TUserCourseSectionService {
    @Resource
    private TUserCourseSectionMapper tUserCourseSectionMapper;

    public boolean getByAuthAndCourseId(TAuthUser tAuthUser, Integer courseId) {
        List<TUserCourseSection> list=tUserCourseSectionMapper.getByAuthAndCourseId(tAuthUser.getId(),courseId);
        if(!CollectionUtils.isEmpty(list)){
            return true;
        }
        return false;
    }
}

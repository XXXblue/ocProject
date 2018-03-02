package com.online.college.core.course.service;

import com.online.college.dao.TCourseMapper;
import com.online.college.dao.TCourseSectionMapper;
import com.online.college.dao.TUserCollectionsMapper;
import com.online.college.dao.TUserCourseSectionMapper;
import com.online.college.module.*;
import com.online.util.JsonData;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import sun.dc.pr.PRError;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2116:26
 * @Description:
 * @Modified By:
 */
@Service
public class TUserCollectionsService {
    @Resource
    private TUserCollectionsMapper tUserCollectionsMapper;
    @Resource
    private TCourseMapper tCourseMapper;
    @Resource
    private TUserCourseSectionMapper tUserCourseSectionMapper;
    @Resource
    private TCourseSectionMapper tCourseSectionMapper;

    public JsonData changeCollectStatus(TAuthUser tAuthUser, Integer courseId) {
        TUserCollections tUserCollections = tUserCollectionsMapper.selectByUserIdAndCourseId(tAuthUser.getId(), courseId);
        Integer classifyId = tCourseMapper.selectCourseClassifyId(courseId);
        if (tUserCollections == null) {
            TUserCollections tUserCollectionsNew=TUserCollections.builder().userId(tAuthUser.getId()).objectId(courseId).createTime(new Date()).createUser("system")
                    .updateTime(new Date()).updateUser("system").del(false).classify(classifyId).build();
            tUserCollectionsMapper.insertSelective(tUserCollectionsNew);
            return JsonData.success(1);
        } else {
            tUserCollectionsMapper.deleteByPrimaryKey(tUserCollections.getId());
            return JsonData.success(2);
        }
    }


    public boolean getCollectStatus(TAuthUser tAuthUser, Integer courseId) {
        if(tUserCollectionsMapper.selectByUserIdAndCourseId(tAuthUser.getId(), courseId)!=null){
            return true;
        }else {
            return false;
        }
    }

    public void save(TAuthUser tAuthUser, Integer courseId) {
        List<TCourseSection> list = tCourseSectionMapper.getSelectionByCourseId(courseId);
        if(CollectionUtils.isEmpty(list)){
            return;
        }
        List<TUserCourseSection> tUserCourseSections = new ArrayList<TUserCourseSection>();
        for(TCourseSection tCourseSection:list){
            TUserCourseSection tUserCourseSection = TUserCourseSection.builder().courseId(courseId).del(false).createTime(new Date()).createUser(tAuthUser.getUsername())
                    .updateTime(new Date()).updateUser(tAuthUser.getUsername()).sectionId(tCourseSection.getId()).rate(0).status("0").userId(tAuthUser.getId()).build();
            tUserCourseSections.add(tUserCourseSection);
        }
         tUserCourseSectionMapper.batchInsert(tUserCourseSections);
    }
}

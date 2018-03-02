package com.online.college.core.course.service;

import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.online.college.dao.TCourseMapper;
import com.online.college.dao.TCourseSectionMapper;
import com.online.college.dao.TUserCourseSectionMapper;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TCourse;
import com.online.college.module.TCourseSection;
import com.online.college.module.TUserCourseSection;
import com.online.college.param.TCourseSectionParam;
import com.online.util.BeanValidator;
import com.online.util.JsonData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2522:36
 * @Description:
 * @Modified By:
 */
@Service
@Slf4j
public class TCourseSectionService {
    @Resource
    private TCourseSectionMapper tCourseSectionMapper;
    @Resource
    private TCourseMapper tCourseMapper;
    @Resource
    private TUserCourseSectionMapper tUserCourseSectionMapper;

    @Transactional
    public void batchAdd(List<TCourseSectionDto> batchSections) {
        if (CollectionUtils.isEmpty(batchSections)) return;
        TCourse tCourse = tCourseMapper.selectByPrimaryKey(batchSections.get(0).getCourseId());
        Preconditions.checkNotNull(tCourse, "该课程不存在");
        //取出该课程序号下最大章的序号
        Integer sortCount = tCourseSectionMapper.getMaxSortByCourseId(tCourse.getId());
        sortCount = sortCount == null ? 0 : sortCount + 1;
        for (TCourseSectionDto tCourseSectionDto : batchSections) {
            TCourseSection tCourseSection = TCourseSection.builder().name(tCourseSectionDto.getName()).courseId(tCourseSectionDto.getCourseId())
                    .parentId(0).createTime(new Date()).createUser("system").updateTime(new Date()).updateUser("system")
                    .del(false).onsale(tCourse.getOnsale()).sort(sortCount++).build();
            tCourseSectionMapper.insertSelective(tCourseSection);
            if (!CollectionUtils.isEmpty(tCourseSectionDto.getSectionDtoList())) {
                List<TCourseSection> newList = Lists.newArrayList();
                int sortCountSecond = 0;
                for (TCourseSectionDto tCourseSectionDtoSub : tCourseSectionDto.getSectionDtoList()) {
                    TCourseSection temp = TCourseSection.builder().courseId(tCourse.getId()).parentId(tCourseSection.getId()).createTime(new Date()).createUser("system")
                            .updateTime(new Date()).updateUser("system").del(false).onsale(tCourse.getOnsale()).name(tCourseSectionDtoSub.getName())
                            .sort(sortCountSecond++).time(tCourseSectionDtoSub.getTime()).videoUrl(tCourseSectionDtoSub.getVideoUrl()).build();
                    newList.add(temp);
                }
                tCourseSectionMapper.batchAdd(newList);
            }
        }
    }

    public JsonData getById(Integer id) {
        return JsonData.success(tCourseSectionMapper.selectByPrimaryKey(id));
    }

    public JsonData saveSection(TCourseSectionParam tCourseSectionParam) {
        BeanValidator.check(tCourseSectionParam);
        if (tCourseSectionParam.getId() != null) {
            TCourseSection tCourseSection = tCourseSectionMapper.selectByPrimaryKey(tCourseSectionParam.getId());
            Preconditions.checkNotNull(tCourseSection);
            TCourseSection tCourseSectionNew = TCourseSection.builder().id(tCourseSectionParam.getId())
                    .videoUrl(tCourseSectionParam.getVideoUrl()).time(tCourseSectionParam.getTime())
                    .updateUser("system").updateTime(new Date()).name(tCourseSectionParam.getName()).build();
            tCourseSectionMapper.updateByPrimaryKeySelective(tCourseSectionNew);
            return JsonData.success();
        } else {
            TCourseSection tCourseSection = tCourseSectionMapper.selectByPrimaryKey(tCourseSectionParam.getParentId());
            Integer sortMax = tCourseSectionMapper.getMaxSortByCourseIdAndParentId(tCourseSection.getCourseId(), tCourseSection.getParentId());
            sortMax = sortMax == null ? 0 : ++sortMax;
            TCourseSection tCourseSectionNew = TCourseSection.builder().name(tCourseSectionParam.getName()).time(tCourseSectionParam.getTime()).videoUrl(tCourseSectionParam.getVideoUrl())
                    .parentId(tCourseSectionParam.getParentId()).courseId(tCourseSection.getCourseId()).updateTime(new Date()).updateUser("system")
                    .createUser("system").createTime(new Date()).del(false).onsale(tCourseSection.getOnsale()).sort(sortMax).build();
            tCourseSectionMapper.insertSelective(tCourseSectionNew);
            return JsonData.success(1);
        }
    }

    @Transactional
    public JsonData delete(Integer id) {
        TCourseSection tCourseSection = tCourseSectionMapper.selectByPrimaryKey(id);
        if (tCourseSection.getParentId() == 0) {
            List<TCourseSection> tCourseSectionSub = tCourseSectionMapper.getTCourseSectionSubByParentId(tCourseSection.getId());
            if (CollectionUtils.isEmpty(tCourseSectionSub)) {
                tUserCourseSectionMapper.deleteUserTCourseSectionByCourseIdAndOneSectionId(tCourseSection.getCourseId(), tCourseSection.getId());
                tCourseSectionMapper.deleteByPrimaryKey(tCourseSection.getId());
            } else {
                tUserCourseSectionMapper.deleteUserTCourseSectionByCourseIdAndOneSectionId(tCourseSection.getCourseId(), tCourseSection.getId());
                tUserCourseSectionMapper.deleteUserTCourseSectionByCourseIdAndSectionId(tCourseSection.getCourseId(), tCourseSectionSub);
                tCourseSectionMapper.deleteByPrimaryKey(tCourseSection.getId());
                tCourseSectionMapper.deleteBySubList(tCourseSectionSub);
            }
        } else {
            tUserCourseSectionMapper.deleteUserTCourseSectionByCourseIdAndOneSectionId(tCourseSection.getCourseId(), tCourseSection.getId());
            tCourseSectionMapper.deleteByPrimaryKey(tCourseSection.getId());
        }
        //最好能记录删除日志O(∩_∩)O哈哈~
        return JsonData.success();
    }

    @Transactional
    public JsonData sortSection(Integer id, String sortType) {
        TCourseSection tCourseSection = tCourseSectionMapper.selectByPrimaryKey(id);
        Preconditions.checkNotNull(tCourseSection, "修改的课程章节不存在");
        if (sortType.equals("0")) {
            //升
            //交换的
            TCourseSection tCourseSectionEc =
                    tCourseSectionMapper.getExchangeCourseSectionUp(tCourseSection.getCourseId(), tCourseSection.getParentId(), tCourseSection.getSort());
            if (tCourseSectionEc == null) {
                return JsonData.success();
            }
            Integer temp = tCourseSection.getSort();
            tCourseSection.setSort(tCourseSectionEc.getSort());
            tCourseSection.setUpdateTime(new Date());
            tCourseSection.setUpdateUser("system");
            tCourseSectionMapper.updateByPrimaryKeySelective(tCourseSection);
            tCourseSectionEc.setSort(temp);
            tCourseSectionEc.setUpdateTime(new Date());
            tCourseSectionEc.setUpdateUser("system");
            tCourseSectionMapper.updateByPrimaryKeySelective(tCourseSectionEc);
            return JsonData.success();
        } else {
            //降
            TCourseSection tCourseSectionEc =
                    tCourseSectionMapper.getExchangeCourseSectionDown(tCourseSection.getCourseId(), tCourseSection.getParentId(), tCourseSection.getSort());
            if (tCourseSectionEc == null) {
                return JsonData.success();
            }
            Integer temp = tCourseSection.getSort();
            tCourseSection.setSort(tCourseSectionEc.getSort());
            tCourseSection.setUpdateTime(new Date());
            tCourseSection.setUpdateUser("system");
            tCourseSectionMapper.updateByPrimaryKeySelective(tCourseSection);
            tCourseSectionEc.setSort(temp);
            tCourseSectionEc.setUpdateTime(new Date());
            tCourseSectionEc.setUpdateUser("system");
            tCourseSectionMapper.updateByPrimaryKeySelective(tCourseSectionEc);
            return JsonData.success();
        }
    }
}

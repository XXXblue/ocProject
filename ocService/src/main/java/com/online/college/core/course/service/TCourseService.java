package com.online.college.core.course.service;

import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.online.college.dao.TAuthUserMapper;
import com.online.college.dao.TConstsClassifyMapper;
import com.online.college.dao.TCourseMapper;
import com.online.college.dao.TCourseSectionMapper;
import com.online.college.dto.CourseQueryDto;
import com.online.college.dto.TConstsClassifyLevelDto;
import com.online.college.dto.TCourseSectionDto;
import com.online.college.module.TConstsClassify;
import com.online.college.module.TCourse;
import com.online.college.module.TCourseSection;
import com.online.college.param.TConstsCourseParam;
import com.online.util.BeanValidator;
import com.online.util.JsonData;
import com.online.util.exception.ParamException;
import com.online.util.page.TailPage;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1319:13
 * @Description:
 * @Modified By:
 */
@Service
@Slf4j
public class TCourseService {

    @Resource
    private TCourseMapper tCourseMapper;
    @Resource
    private TCourseSectionMapper tCourseSectionMapper;
    @Resource
    private TAuthUserMapper tAuthUserMapper;
    @Resource
    private TConstsClassifyMapper tConstsClassifyMapper;

    public List<TCourse> freeCourseList() {
        return courseListByFree(true);
    }

    public List<TCourse> noFreeCourseList() {
        return courseListByFree(false);
    }

    public List<TCourse> javaCourseList(){
        CourseQueryDto courseQueryDto = new CourseQueryDto();
        courseQueryDto.descSortField("study_count");
        courseQueryDto.setOnsale(true);
        courseQueryDto.setSubClassify("java");
        courseQueryDto.setCount(7);
        return tCourseMapper.queryList(courseQueryDto);
    }

    private List<TCourse> courseListByFree(Boolean free) {
        CourseQueryDto courseQueryDto = new CourseQueryDto();
        courseQueryDto.setFree(free);
        courseQueryDto.descSortField("weight");
        courseQueryDto.setOnsale(true);
        courseQueryDto.setCount(5);
        return tCourseMapper.queryList(courseQueryDto);
    }

    public TailPage<TCourse> queryPage(TCourse tCourse, TailPage<TCourse> page) {
        int count = tCourseMapper.queryPageNum(tCourse,page);
        if(count!=0){
            List<TCourse>list =tCourseMapper.queryPage(tCourse,page);
            page.setItemsTotalCount(count);
            page.setItems(list);
        }else {
            page.setItemsTotalCount(0);
            page.setItems(null);
        }
        return page;
    }

    public TCourse selectByPrimaryKey(Integer courseId) {
        return tCourseMapper.selectByPrimaryKey(courseId);
    }

    public List<TCourseSectionDto> getSelectionByCourseId(Integer courseId) {
        return turnToDto(courseId);
    }

    //转dto
    private List<TCourseSectionDto> turnToDto(Integer courseId){
        List<TCourseSectionDto> resultlist =new ArrayList<TCourseSectionDto>();
        List<TCourseSection>list=tCourseSectionMapper.getSelectionByCourseId(courseId);
        if(CollectionUtils.isEmpty(list)){
            return Lists.newArrayList();
        }
        for(TCourseSection tCourseSection:list){
           resultlist.add(TCourseSectionDto.adapt(tCourseSection));
        }
        return turnToTree(resultlist);
    }

    //第一层
    private List<TCourseSectionDto> turnToTree(List<TCourseSectionDto> list){
        List<TCourseSectionDto> resultList = new ArrayList<TCourseSectionDto>();
        Map<Integer,List<TCourseSectionDto>> map = new HashMap<Integer, List<TCourseSectionDto>>();
        for(TCourseSectionDto tCourseSectionDto:list){
            if(tCourseSectionDto.getParentId()==0){
                resultList.add(tCourseSectionDto);
            }else {
                if(map.containsKey(tCourseSectionDto.getParentId())){
                    map.get(tCourseSectionDto.getParentId()).add(tCourseSectionDto);
                }else{
                    List<TCourseSectionDto> tempList = new ArrayList<TCourseSectionDto>();
                    tempList.add(tCourseSectionDto);
                    map.put(tCourseSectionDto.getParentId(),tempList);
                }
            }
        }
        Collections.sort(resultList, new Comparator<TCourseSectionDto>() {
            public int compare(TCourseSectionDto o1, TCourseSectionDto o2) {
                return o1.getSort()-o2.getSort();
            }
        });
        recuredOtherChild(resultList,map);
        return resultList;
    }

    private void recuredOtherChild(List<TCourseSectionDto> resultList, Map<Integer, List<TCourseSectionDto>> map) {
        if(CollectionUtils.isEmpty(resultList))return;
        for(TCourseSectionDto tCourseSectionDto:resultList){
           List<TCourseSectionDto>templist=map.get(tCourseSectionDto.getId());
          if(!CollectionUtils.isEmpty(templist)){
              Collections.sort(templist, new Comparator<TCourseSectionDto>() {
                  public int compare(TCourseSectionDto o1, TCourseSectionDto o2) {
                      return o1.getSort()-o2.getSort();
                  }
              });
              recuredOtherChild(templist,map);
              tCourseSectionDto.setSectionDtoList(templist);
          }
        }
    }
    //递归N层

    public TailPage<TCourse> queryCourse(TCourse tCourse, TailPage<TCourse> page) {
        int total = tCourseMapper.queryPageNum(tCourse,page);
        if(total==0){
            page.setItemsTotalCount(0);
            page.setItems(Lists.<TCourse>newArrayList());
            return page;
        }
        List<TCourse>list=tCourseMapper.queryPage(tCourse,page);
        if(CollectionUtils.isEmpty(list)){
            log.info("获取课程数据异常");
            throw new ParamException("获取课程数据异常");
        }
        page.setItemsTotalCount(total);
        page.setItems(list);
        return page;
    }

    public void doSale(Integer id, Integer onsale) {
        TCourse tCourse = tCourseMapper.selectByPrimaryKey(id);
        Preconditions.checkNotNull(tCourse,"该课程不存在");
        if(onsale==0){
            tCourse.setOnsale(false);
        }else {
            tCourse.setOnsale(true);
        }
        tCourse.setUpdateTime(new Date());
        tCourse.setUpdateUser("system");
        tCourseMapper.updateByPrimaryKeySelective(tCourse);
    }

    public TCourse getCourseById(Integer id) {
        return tCourseMapper.selectByPrimaryKey(id);
    }

    @Transactional
    public JsonData save(TConstsCourseParam tConstsCourseParam) {
        BeanValidator.check(tConstsCourseParam);
        if(tAuthUserMapper.countByUsername(tConstsCourseParam.getUsername(),null)==0){
            throw new ParamException("教师不存在");
        }
        String classifyName = tConstsClassifyMapper.getNameByCode(tConstsCourseParam.getClassify());
        if(tConstsCourseParam.getId()!=null){
            TCourse tCourse = TCourse.builder().id(tConstsCourseParam.getId()).free(tConstsCourseParam.isFree())
                    .name(tConstsCourseParam.getName()).brief(tConstsCourseParam.getBrief()).classify(tConstsCourseParam.getClassify())
                    .subClassify(tConstsCourseParam.getSubClassify()).classifyName(classifyName).username(tConstsCourseParam.getUsername())
                    .updateTime(new Date()).updateUser("system").time(tConstsCourseParam.getTime()).build();
            tCourseMapper.updateByPrimaryKeySelective(tCourse);
            return JsonData.success(tCourse);
        }
        TCourse tCourse = TCourse.builder().name(tConstsCourseParam.getName()).brief(tConstsCourseParam.getBrief()).classify(tConstsCourseParam.getClassify())
                .subClassify(tConstsCourseParam.getSubClassify()).classifyName(classifyName).del(false).free(true).username(tConstsCourseParam.getUsername())
                .createTime(new Date()).createUser("system").updateTime(new Date()).updateUser("system").studyCount(0).recommend(false).onsale(false).build();
        tCourseMapper.insertSelective(tCourse);
        return JsonData.success(tCourse);

    }
}

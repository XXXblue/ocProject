package com.online.college.core.common.service;

import com.google.common.collect.Lists;
import com.online.college.dao.TCourseMapper;
import com.online.college.dto.CourseQueryDto;
import com.online.college.dto.TConstsClassifyLevelDto;
import com.online.college.module.TConstsClassify;
import com.online.college.module.TCourse;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1315:27
 * @Description:
 * @Modified By:
 */
@Service
public class TreeService {
    @Resource
    private TCourseMapper tCourseMapper;

    //封装介绍课程信息
    private void getCourseByClassify(List<TConstsClassifyLevelDto> list) {
        CourseQueryDto courseQueryDto = new CourseQueryDto();
        for (TConstsClassifyLevelDto tConstsClassifyLevelDto : list) {
            courseQueryDto.setClassify(tConstsClassifyLevelDto.getCode());
            courseQueryDto.setCount(5);
            courseQueryDto.descSortField("weight");
            courseQueryDto.setOnsale(true);
            List<TCourse> tempList = tCourseMapper.queryList(courseQueryDto);
            if (!CollectionUtils.isEmpty(tempList)) {
                tConstsClassifyLevelDto.setListCourse(tempList);
            }
        }
    }

    public List<TConstsClassifyLevelDto> TConstsClassifyTree(List<TConstsClassify> list,Map<String, List<TConstsClassifyLevelDto>> map) {
        if (CollectionUtils.isEmpty(list)) {
            return Lists.newArrayList();
        }
        List<TConstsClassifyLevelDto> newList = Lists.newArrayList();
        for (TConstsClassify tConstsClassify : list) {
            newList.add(TConstsClassifyLevelDto.adapt(tConstsClassify));
        }
        return TConstsClassifyListToTree(newList,map);
    }

    //第一层
    private List<TConstsClassifyLevelDto> TConstsClassifyListToTree(List<TConstsClassifyLevelDto> newList,Map<String, List<TConstsClassifyLevelDto>> map) {
        if (!CollectionUtils.isEmpty(newList)) {
            List<TConstsClassifyLevelDto> resultList = Lists.newArrayList();
            if(map==null){
                map = new HashMap<String, List<TConstsClassifyLevelDto>>();
            }
            for (TConstsClassifyLevelDto tConstsClassifyLevelDto : newList) {
                if (tConstsClassifyLevelDto.getParentCode().equals("0")) {
                    resultList.add(tConstsClassifyLevelDto);
                } else {
                    if (map.containsKey(tConstsClassifyLevelDto.getParentCode())) {
                        map.get(tConstsClassifyLevelDto.getParentCode()).add(tConstsClassifyLevelDto);
                    } else {
                        List<TConstsClassifyLevelDto> tempList = Lists.newArrayList();
                        tempList.add(tConstsClassifyLevelDto);
                        map.put(tConstsClassifyLevelDto.getParentCode(), tempList);
                    }
                }
            }
            Collections.sort(resultList, new Comparator<TConstsClassifyLevelDto>() {
                public int compare(TConstsClassifyLevelDto o1, TConstsClassifyLevelDto o2) {
                    return o1.getSort() - o2.getSort();
                }
            });
            getCourseByClassify(resultList);
            bindWithChildren(resultList, map);
            return resultList;
        } else {
            return Lists.newArrayList();
        }
    }

    //孩子
    private void bindWithChildren(List<TConstsClassifyLevelDto> resultList, Map<String, List<TConstsClassifyLevelDto>> map) {
        if (CollectionUtils.isEmpty(resultList)) {
            return;
        }
        for (TConstsClassifyLevelDto tConstsClassifyLevelDto : resultList) {
            if (map.containsKey(tConstsClassifyLevelDto.getCode())) {
                List<TConstsClassifyLevelDto> tempList = map.get(tConstsClassifyLevelDto.getCode());
                Collections.sort(tempList, new Comparator<TConstsClassifyLevelDto>() {
                    public int compare(TConstsClassifyLevelDto o1, TConstsClassifyLevelDto o2) {
                        return o1.getSort() - o2.getSort();
                    }
                });
                tConstsClassifyLevelDto.setList(tempList);
                bindWithChildren(tempList, map);
            }
        }
    }
}

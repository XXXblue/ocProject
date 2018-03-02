package com.online.college.dto;

import com.online.college.module.TCourseSection;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2114:40
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TCourseSectionDto extends TCourseSection {
    private List<TCourseSectionDto> sectionDtoList = new ArrayList<TCourseSectionDto>();

    public static TCourseSectionDto adapt(TCourseSection tCourseSection){
        TCourseSectionDto tCourseSectionDto = new TCourseSectionDto();
        BeanUtils.copyProperties(tCourseSection,tCourseSectionDto);
        return tCourseSectionDto;
    }

}

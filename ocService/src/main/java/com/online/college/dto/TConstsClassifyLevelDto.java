package com.online.college.dto;

import com.google.common.collect.Lists;
import com.online.college.module.TConstsClassify;
import com.online.college.module.TCourse;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.beans.BeanUtils;

import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1315:12
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TConstsClassifyLevelDto extends TConstsClassify {

    private List<TConstsClassifyLevelDto> list = Lists.newArrayList();

    private List<TCourse> listCourse=Lists.newArrayList();

    public static TConstsClassifyLevelDto adapt(TConstsClassify tConstsClassify){
        TConstsClassifyLevelDto dto = new TConstsClassifyLevelDto();
        BeanUtils.copyProperties(tConstsClassify,dto);
        return dto;
    }
}

package com.online.college.dto;

import com.online.college.module.TCourse;
import org.apache.commons.lang.StringUtils;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1318:55
 * @Description:
 * @Modified By:
 */
public class CourseQueryDto extends TCourse{

    private String sortField;

    private String sortDirection = "DESC";

    private Integer count;//数量

    public String getSortField() {
        return sortField;
    }

    /**
     * 按照sortField升序
     * @param sortField：指java bean中的属性
     */
    public void ascSortField(String sortField) {
        if(StringUtils.isNotEmpty(sortField)){
            //TODO:这里少一步校验，能用，这里的校验主要解决字段不存在抛出异常的。
            this.sortField = sortField;
            this.sortDirection = " ASC ";
        }
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    /**
     * 按照sortField降序
     * @param sortField ：指java bean中的属性
     */
    public void descSortField(String sortField) {
        if(StringUtils.isNotEmpty(sortField)){

            this.sortField = sortField;
            this.sortDirection = " DESC ";
        }
    }

    public String getSortDirection() {
        return sortDirection;
    }


}

package com.online.college.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2615:31
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TConstsCourseParam {
    private Integer id;

    @NotBlank(message = "课程名称不能为空")
    private String name;

    @NotBlank(message = "一级不能为空")
    private String classify;

    @NotBlank(message = "二级不能为空")
    private String subClassify;

    @NotBlank(message = "等级不能为空")
    private String level;

    @NotBlank(message = "权重不能为空")
    private String weight;

    private boolean free;

    private String price;
    @NotBlank(message = "教师名不能为空")
    private String username;

    private String brief;

    private String time;
}

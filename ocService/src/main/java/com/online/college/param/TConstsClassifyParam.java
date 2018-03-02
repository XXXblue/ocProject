package com.online.college.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2413:18
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TConstsClassifyParam {

    private Integer id;

    @NotBlank(message = "分类名称不能为空")
    @Length(min = 2, max = 10, message = "分类名称长度2-10")
    private String name;

    @NotBlank(message = "分类编码不能为空")
    @Length(min = 2, max = 10, message = "分类编码长度2-10")
    private String code;

    private String parentCode;
}

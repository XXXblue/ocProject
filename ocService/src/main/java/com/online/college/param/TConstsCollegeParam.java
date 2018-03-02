package com.online.college.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1914:48
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TConstsCollegeParam {

    private Integer id;
    @NotBlank(message = "学校名不能为空")
    @Length(min = 2, max = 10, message = "学校名长度2-10")
    private String name;

    @NotBlank(message = "邮政编码不能为空")
    @Length(min = 2, max = 10, message = "邮政编码长度2-10")
    private String code;
}

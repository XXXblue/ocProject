package com.online.college.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1021:58
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TestParam {
    @NotBlank(message = "权限名字不能为空")
    private String name;
}

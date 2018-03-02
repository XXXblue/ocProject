package com.online.college.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.annotations.Param;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1121:12
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class AuthRegisterParam {
    @NotBlank(message = "用户名不能为空")
    @Length(min = 2, max = 10, message = "用户名长度2-10")
    private String username;

    @NotBlank(message = "密码不能为空")
    @Length(min = 2, max = 10, message = "密码长度2-10")
    private String password;

    @NotBlank(message = "验证码不能为空")
    private String identiryCode;

}

package com.online.college.param;

import com.online.college.dto.TCourseSectionDto;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/2522:15
 * @Description:
 * @Modified By:
 */
@Getter
@Setter
@ToString
public class TCourseSectionParam {

    private Integer id;

    @NotNull(message = "父id不能为空")
    private Integer parentId;

    @NotBlank(message = "名称不能为空")
    private String name;

    private String videoUrl;

    private String time;

    private List<TCourseSectionDto> list =new ArrayList<TCourseSectionDto>();
}

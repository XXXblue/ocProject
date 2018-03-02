package com.online.college.controller;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1120:12
 * @Description:
 * @Modified By:
 */

import com.online.college.core.test.service.TestService;
import com.online.college.param.TestParam;
import com.online.util.JsonData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1018:27
 * @Description:
 * @Modified By:
 */
@Controller
@RequestMapping("/test")
@Slf4j
public class Test{

    @Resource
    private TestService testService;

    @RequestMapping("/aa")
    @ResponseBody
    public JsonData aa(TestParam testParam){
        log.info("jfklsd");
        return JsonData.success(testService.getById(testParam));
    }
}

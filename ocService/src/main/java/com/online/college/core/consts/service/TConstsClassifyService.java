package com.online.college.core.consts.service;

import com.google.common.base.Preconditions;
import com.online.college.core.common.service.TreeService;
import com.online.college.dao.TConstsClassifyMapper;
import com.online.college.dto.TConstsClassifyLevelDto;
import com.online.college.module.TConstsClassify;
import com.online.college.param.TConstsClassifyParam;
import com.online.util.BeanValidator;
import com.online.util.JsonData;
import com.online.util.exception.ParamException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1315:20
 * @Description:
 * @Modified By:
 */
@Service
public class TConstsClassifyService {
    @Resource
    private TConstsClassifyMapper tConstsClassifyMapper;
    @Resource
    private TreeService treeService;

    public List<TConstsClassifyLevelDto> queryAllClassify(Map<String, List<TConstsClassifyLevelDto>> map) {
        return treeService.TConstsClassifyTree(tConstsClassifyMapper.getAll(), map);
    }

    public TConstsClassify getByCode(String code) {
        List<TConstsClassify> list = tConstsClassifyMapper.getByCode(code);
        if (CollectionUtils.isEmpty(list)) {
            return null;
        }
        return list.get(0);
    }

    public List<TConstsClassify> queryAllFirst() {
        return tConstsClassifyMapper.queryAllFirst();
    }

    public List<TConstsClassify> queryAllSecond() {
        return tConstsClassifyMapper.queryAllSecond();
    }


    public JsonData save(TConstsClassifyParam tConstsClassifyParam) {
        BeanValidator.check(tConstsClassifyParam);
        if (ifNameExist(tConstsClassifyParam)) {
            throw new ParamException("分类名称重复");
        }
        if (ifCodeExist(tConstsClassifyParam)) {
            throw new ParamException("分类编号重复");
        }
        if(tConstsClassifyParam.getId()==null){
            TConstsClassify tConstsClassify = TConstsClassify.builder().name(tConstsClassifyParam.getName()).code(tConstsClassifyParam.getCode()).createTime(new Date())
                    .createUser("system").updateTime(new Date()).updateUser("system").del(false).parentCode(tConstsClassifyParam.getParentCode()).build();
            tConstsClassifyMapper.insertSelective(tConstsClassify);
            return JsonData.success();
        }else {
            TConstsClassify tConstsClassifyOld = tConstsClassifyMapper.selectByPrimaryKey(tConstsClassifyParam.getId());
            Preconditions.checkNotNull(tConstsClassifyOld,"待修改的分类信息不存在");
            TConstsClassify tConstsClassifyNew = TConstsClassify.builder().name(tConstsClassifyParam.getName()).parentCode(tConstsClassifyParam.getParentCode())
                   .id(tConstsClassifyParam.getId()).updateTime(new Date()).updateUser("system").build();
            tConstsClassifyMapper.updateByPrimaryKeySelective(tConstsClassifyNew);
            return JsonData.success();
        }
    }

    private boolean ifNameExist(TConstsClassifyParam tConstsClassifyParam) {
        return tConstsClassifyMapper.ifNameExist(tConstsClassifyParam)>0;
    }

    private boolean ifCodeExist(TConstsClassifyParam tConstsClassifyParam) {
        return tConstsClassifyMapper.ifCodeExist(tConstsClassifyParam)>0;
    }

    public TConstsClassify getById(Integer id) {
        return tConstsClassifyMapper.selectByPrimaryKey(id);
    }
}

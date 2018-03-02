package com.online.college.core.consts.service;

import com.online.college.dao.TConstsSiteCarouselMapper;
import com.online.college.module.TConstsSiteCarousel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: XBlue
 * @Date: Create in 2018/2/1313:07
 * @Description:
 * @Modified By:
 */
@Service
public class TConstsSiteCarouselService {
    @Resource
    private TConstsSiteCarouselMapper tConstsSiteCarouselMapper;

    public List<TConstsSiteCarousel> queryCarousel(Integer count){
        return tConstsSiteCarouselMapper.queryCarousel(count);
    }
}

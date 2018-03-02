<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/14
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="utf-8">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>在线网校学习平台</title>
    <%@ include file="/WEB-INF/views/common/res.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="course-nav-row clearfix" style="padding-left: 300px;padding-top: 20px">
    <span class="hd">方向：</span>
    <ul class="course-nav">
        <li class="course-nav-item <c:if test="${not empty curCode && curCode eq '-1'}">cur-course-nav</c:if> ">
            <a href="javascript:void(0)" onClick="_queryPage(1,'-1')">全部</a>
        </li>
        <c:if test="${not empty classifys && classifys.size()>0}">
            <c:forEach items="${classifys}" varStatus="status" var="item">
                <li class="course-nav-item <c:if test="${curCode eq item.code}">cur-course-nav</c:if>">
                    <a href="javascript:void(0)" onClick="_queryPage(1,'${item.code}')">${item.name}</a>
                </li>
            </c:forEach>
        </c:if>
    </ul>
</div>

<div class="course-nav-row clearfix" style="padding-left: 300px">
    <span class="hd">分类：</span>
    <ul class="course-nav">
        <li class="course-nav-item <c:if test="${curSubCode eq '-2'}">cur-course-nav</c:if>">
            <a href="javascript:void(0)" onClick="_queryPage(1,'-2')">全部</a>
        </li>
        <c:if test="${not empty subClassifys && subClassifys.size()>0}">
            <c:forEach items="${subClassifys}" var="item" varStatus="status">
                <li class="course-nav-item <c:if test="${curSubCode eq item.code}">cur-course-nav</c:if>">
                    <a href="javascript:void(0)" onClick="_queryPage(1,'${item.code}')">${item.name}</a>
                </li>
            </c:forEach>
        </c:if>
    </ul>
</div>

<div class="types-block clearfix" style="padding: 0px;margin-left: 300px">
    <h3 style="margin-bottom: 20px;">
        <span class="types-title" style="margin-right:40px;">课程列表</span>
        <a href="javascript:void(0)" style="display: inline-block;margin-right:20px;" onclick="_queryPage(1,undefined,'last')">
            <span <c:if test="${not empty sort && sort=='last'}">class="color-oc"</c:if>>最新</span>
        </a>
        <a href="javascript:void(0)" style="display: inline-block;" onclick="_queryPage(1,undefined,'pop')">
            <span <c:if test="${not empty sort && sort=='pop'}">class="color-oc"</c:if>>最热</span>
        </a>
    </h3>
    <div class="types-content clearfix" style="margin-bottom: 20px;">
        <c:if test="${not empty page.items}">
            <div>
                <c:forEach items="${page.items}" var="item" varStatus="status">
                    <a href="${baseurl}/course/learn/${item.id}.page" target="_black">
                        <div class="course-card-container" <c:if test="${(status.index+1)%5==0}">style="margin-right: 0px;" </c:if>>
                            <c:choose>
                                <c:when test="${(status.index+5)%5==0}">
                                    <div class="course-card-top green-bg"><span>${item.subClassifyName}</span></div>
                                </c:when>
                                <c:when test="${(status.index+4)%5==0}">
                                    <div class="course-card-top pink-bg"><span>${item.subClassifyName}</span></div>
                                </c:when>
                                <c:when test="${(status.index+3)%5==0}">
                                    <div class="course-card-top gray-bg"><span>${item.subClassifyName}</span></div>
                                </c:when>
                                <c:when test="${(status.index+2)%5==0}">
                                    <div class="course-card-top brown-bg"><span>${item.subClassifyName}</span></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="course-card-top purple-bg"><span>${item.subClassifyName}</span></div>
                                </c:otherwise>
                            </c:choose>
                            <div class="course-card-content">
                                <h3 class="course-card-name" title="${item.name}">${item.name}</h3>
                                <p class="course-card-brief" title="${item.brief}">${item.brief}</p>
                                <div class="course-card-bottom">
                                    <c:if test="${item.free}">
                                        <div class="course-card-info">
                                            <span>·</span>${item.studyCount}人在学
                                        </div>
                                    </c:if>
                                    <c:if test="${!item.free}">
                                        <div class="course-card-info">${item.studyCount}人在学</div>
                                        <div class="course-card-price">￥${item.price}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:if>
    </div>
<%--分页start--%>
    <div style="margin: 0px 0px 20px 0px">
    <c:if test="${not empty page.pageTotalCount && page.pageTotalCount>1}">
        <div class="page-box clearfix">
            <div class="page clearfix">
                <div style="float:left;">
                    <c:if test="${!page.firstPage}">
                        <a class="page-next" href="javascript:void(0);" onclick="_queryPage(1)">首
                            页</a>
                        <a class="page-next" href="javascript:void(0);"
                           onclick="_queryPage(${page.pageNum-1})">上一页</a>
                    </c:if>
                    <c:forEach items="${page.showNums}" var="item">
                        <c:if test="${page.showDot && item==6}">
                            <span class="page-omit">...</span>
                        </c:if>
                        <c:if test="${page.pageNum==item}">
                            <a class="page-cur" href="javascript:void(0);">${item}</a>
                        </c:if>
                        <c:if test="${page.pageNum!=item}">
                            <a class="page-num" href="javascript:void(0);"
                               onclick="_queryPage(${item});">${item}</a>
                        </c:if>
                    </c:forEach>

                    <c:if test="${!page.lastPage}">
                        <a class="page-next" href="javascript:void(0);"
                           onclick="_queryPage(${page.pageNum+1})">下一页</a>
                        <a class="page-next" href="javascript:void(0);"
                           onclick="_queryPage(${page.pageTotalCount})">尾 页</a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
    </div>
    <%--分页end--%>
</div>


<%@ include file="/WEB-INF/views/common/foot.jsp" %>
<script type="text/javascript">

    var _code = '${curCode}';
    var _subCode = '${curSubCode}';
    var _sort = '${sort}';

    function _queryPage(pageNum, code, sort) {
        var params = '?pageNum=' + pageNum;
        //分类，参数没有就用页面缓存
        if(code == undefined){//来自于分页按钮
            code = _code;
            if(_subCode != '-2'){
                code = _subCode; //优先使用 subCode
            }
        }
        if (code == '-2') {//点击分类的全部
            code = _code;
        }
        if (code != '-1' && code != '') {
            params += '&c=' + code;
        }

        //排序，函数参数没有就用页面缓存
        if(sort == undefined && _sort != ''){
           sort = _sort;
          }
            if(sort != undefined){
                params += '&sort='+sort;
            }
        window.location.href = '${baseurl}course/list.page' + params;
    }
</script>

</body>

</html>

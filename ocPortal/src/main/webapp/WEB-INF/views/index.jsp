<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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
<div class="f-main">
    <div class="clearfix">
        <div class=main-category>
            <!-- 轮播 分类-start -->
            <div class="main-bg">
                <c:if test="${not empty carouselList && carouselList.size()>0}">
                    <c:forEach items="${carouselList}" var="carouselListItem">
                        <a href="${carouselListItem.url}">
                            <div class="main-bg-item " style="background-image: url(${carouselListItem.picture}); ">
                            </div>
                        </a>
                    </c:forEach>
                </c:if>
            </div>
            <%--轮播区的小点--%>
            <div class="f-nav-box">
                <div class="bg-nav">
                    <c:if test="${not empty carouselList && carouselList.size()>0}">
                        <c:forEach items="${carouselList}" var="carouselListItem" varStatus="status">
                            <c:if test="${status.index==0}">
                                <a class="cur"></a>
                            </c:if>
                            <c:if test="${status.index!=0}">
                                <a></a>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <%--一级分类--%>
            <div class="main-category-menu">
                <c:if test="${not empty classifys && classifys.size()>0}">
                    <c:forEach items="${classifys}" var="classifysItem" varStatus="status">
                        <c:if test="${status.index<6}">
                            <div class="category" c-id="classify_${classifysItem.id}">
                                <a>
                                    <div class="group">${classifysItem.name}</div>
                                </a>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>

            <!-- 二级分类 -->
            <c:if test="${not empty classifys && classifys.size()>0}">
                <c:forEach items="${classifys}" var="classifysItem" varStatus="status">
                    <c:if test="${status.index<6}">
                        <div class="main-category-submenu-content" id="classify_${classifysItem.id}">
                            <div class="clearfix">
                                <div class="submenu-title clearfix">分类目录</div>
                                <c:if test="${not empty classifysItem.list && classifysItem.list.size()>0}">
                                    <c:forEach items="${classifysItem.list}" var="item" varStatus="status">
                                        <a class="submenu-item"
                                           href="${baseurl}course/list.page?c=${item.code}">${item.name}</a>
                                    </c:forEach>
                                </c:if>
                            </div>

                            <div class="clearfix">
                                <div class="submenu-title" style="margin-top: 30px;">课程推荐</div>
                                <c:if test="${not empty classifysItem.listCourse && classifysItem.listCourse.size()>0}">
                                    <c:forEach items="${classifysItem.listCourse}" var="item" varStatus="status">
                                        <a href="${baseurl}course/learn/${item.id}.page" class="mt-10"
                                           title="${item.name}">
                                            <li class="ellipsis oc-color-hover">➤ ${item.name}</li>
                                        </a>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <!-- 轮播 分类-end -->

    <!-- 实战推荐-start -->
    <div class="types-block clearfix">
        <h3 class="types-title">实战推荐</h3>
        <div class="types-content">
            <c:if test="${not empty notFreeCourseList && notFreeCourseList.size()>0}">
                <c:forEach items="${notFreeCourseList}" var="item" varStatus="status">
                <a href="${baseurl}course/learn/${item.id}.page" target="_black">
                <div class="course-card-container"  <c:if test="${(status.index+1)%5==0}">style="margin-right: 0px;"</c:if>>
                    <c:choose>
                        <c:when test="${(status.index+1)%5==0}">
                             <div class="course-card-top green-bg">
                        </c:when>
                        <c:when test="${(status.index+1)%5==1}">
                            <div class="course-card-top pink-bg">
                        </c:when>
                        <c:when test="${(status.index+1)%5==2}">
                            <div class="course-card-top purple-bg">
                        </c:when>
                        <c:when test="${(status.index+1)%5==3}">
                            <div class="course-card-top gray-bg">
                        </c:when>
                        <c:otherwise>
                            <div class="course-card-top green-bg">
                        </c:otherwise>
                    </c:choose>
                    <span>${item.subClassifyName}</span>
                    </div>
                 <div class="course-card-content">
                          <h3 class="course-card-name"  title="${item.name}">${item.name}</h3>
                           <p class="course-card-brief" title="${item.brief}">${item.brief}</p>
                           <div class="course-card-bottom">
                                <div class="course-card-info">${item.studyCount}人在学</div>
                                 <div class="course-card-price">￥${item.price}</div>
                           </div>
                 </div>
                 </div>
                </a>
                </c:forEach>
            </c:if>
        </div>
    </div>


    <!-- 免费好课推荐-start -->
    <div class="types-block clearfix">
        <h3 class="types-title">免费好课</h3>
        <div class="types-content">
            <c:if test="${not empty freeCourseList && freeCourseList.size()>0}">
                <c:forEach items="${freeCourseList}" var="item" varStatus="status">
                    <a href="${baseurl}course/learn/${item.id}.page" target="_black">
                        <div class="course-card-container"  <c:if test="${(status.index+1)%5==0}">style="margin-right: 0px;"</c:if>>
                            <c:choose>
                            <c:when test="${(status.index+1)%5==0}">
                            <div class="course-card-top green-bg">
                                </c:when>
                                <c:when test="${(status.index+1)%5==1}">
                                <div class="course-card-top pink-bg">
                                    </c:when>
                                    <c:when test="${(status.index+1)%5==2}">
                                    <div class="course-card-top purple-bg">
                                        </c:when>
                                        <c:when test="${(status.index+1)%5==3}">
                                        <div class="course-card-top gray-bg">
                                            </c:when>
                                            <c:otherwise>
                                            <div class="course-card-top green-bg">
                                                </c:otherwise>
                                                </c:choose>
                                                <span>${item.subClassifyName}</span>
                                            </div>
                                            <div class="course-card-content">
                                                <h3 class="course-card-name"  title="${item.name}">${item.name}</h3>
                                                <p class="course-card-brief" title="${item.brief}">${item.brief}</p>
                                                <div class="course-card-bottom">
                                                    <div class="course-card-info">${item.studyCount}人在学</div>
                                                    <div class="course-card-price">￥${item.price}</div>
                                                </div>
                                            </div>
                                        </div>
                    </a>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <!-- Java课程-start -->
    <div class="types-block clearfix">
        <h3 class="types-title">Java开发工程师</h3>
        <c:if test="${not empty javaCourseList && javaCourseList.size()>0}">
            <a href="${baseurl}course/learn/${javaCourseList[0].id}.page" target="_black">
                <div class="types-content-left "
                     style="background-image: url(http://img.mukewang.com/58ac18fd00012a4202240348.jpg);">
                    <div class="course-card-container-fix">
                        <div class="course-card-content">
                            <h3 class="course-card-name" title="${javaCourseList[0].name}">${javaCourseList[0].name}</h3>
                            <p class="color-fff" title="${javaCourseList[0].brief}">${javaCourseList[0].brief}</p>
                            <div class="course-card-bottom" style="margin-top: 50px;">
                                <div class="course-card-info color-fff">了解详情 →</div>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
            <c:if test="${not empty javaCourseList && javaCourseList.size()>2}">
                    <div class="types-content-right ">
                        <div class="types-content-banner ">
                            <a href="${baseurl}course/learn/${javaCourseList[1].id}.page" target="_black" title="${javaCourseList[1].name}">
                                <div class="types-content-banner-block green-bg"  style="margin-right:20px;" >
                                        ${javaCourseList[1].name}
                                </div>
                            </a>
                            <a href="${baseurl}course/learn/${javaCourseList[2].id}.page" target="_black"  title="${javaCourseList[1].name}">
                                <div class="types-content-banner-block gray-bg"  >
                                        ${javaCourseList[2].name}
                                </div>
                            </a>
                        </div>
                        <div class="clearfix">
                            <c:forEach items="${javaCourseList}" var="item" varStatus="status">
                                <c:if test="${status.index>2}">
                                <a href="${baseurl}course/learn/${item.id}.page" target="_black" >
                                    <div class="course-card-container"  <c:if test="${status.index==6}">style="margin-right: 0px;"</c:if>>
                                        <div class="course-card-top green-bg">
                                            <span>${item.subClassifyName}</span>
                                        </div>
                                        <div class="course-card-content">
                                            <h3 class="course-card-name" title="${item.name}">${item.name}</h3>
                                            <p  class="course-card-brief" title="${item.brief}">${item.brief}</p>
                                            <div class="course-card-bottom">
                                                    <c:if test="${item.free}">
                                                        <div class="course-card-info">
                                                            初级
                                                            <span>·</span>${item.studyCount}人在学
                                                        </div>
                                                        <div class="course-card-price">免费</div>
                                                    </c:if>
                                                    <c:if test="${!item.free}">
                                                        <div class="course-card-info">${item.studyCount}人在学</div>
                                                        <div class="course-card-price">￥${item.price}</div>
                                                   </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
            </c:if>
        </c:if>
    </div>

    <!--名校讲师-start -->
    <div class="types-block clearfix">
        <h3 class="types-title">名校讲师</h3>
        <c:if test="${not empty recomdTeacher && recomdTeacher.size()>0}">
            <c:forEach items="${recomdTeacher}" var="item" varStatus="status">
                <div class="lecturer-card-container"<c:if test="${status.index==4}"> style="margin-right: 0px;"</c:if> >
                    <div class="lecturer-item">
                        <c:if test="${item.header && item.header ne ''}">
                            <img class="lecturer-uimg" src="${item.header}">
                        </c:if>
                        <c:if test="${!(item.header && item.header ne '')}">
                            <img class="lecturer-uimg" src="http://xiaojianyu-file-server.oss-cn-shenzhen.aliyuncs.com/test/32d34384-b205-4515-9217-e74effdb7124.jpg">
                        </c:if>
                        <a><span class="lecturer-name">${item.realname}</span></a>
                        <span class="lecturer-title">${item.collegeName} · ${item.education}</span>
                        <span class="lecturer-p" >${item.title}，${item.sign}</span>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

</div>
<%@ include file="/WEB-INF/views/common/foot.jsp" %>
</body>
<script type="text/javascript">
    <c:if test="${not empty carouselList and carouselList.size()>0}">
    var size =${carouselList.size()};
    </c:if>
    <c:if test="empty carouselList">
    var size = 3;
    </c:if>
    var index = 0;
    var timer = 4000;
    $('.bg-nav a').click(function () {
        index = $('.bg-nav a').index($(this));
        rollBg(index);
    });
    $('.index-roll-item').click(function () {
        index = $('.index-roll-item').index($(this));
        rollBg(index);
    });
    var rollBg = function (i) {
        $('.main-bg-item').fadeOut(1000);
        $($('.main-bg-item')[i]).fadeIn(1000);
        $('.bg-nav a').removeClass('cur');
        $($('.bg-nav a')[i]).addClass('cur');
        $('.index-roll-item').removeClass('cur');
        $($('.index-roll-item')[i]).addClass('cur');
    }
    setInterval(function () {
        index += 1;
        index = index % size;
        rollBg(index);
    }, timer);
    //轮播效果 -end

    //一级菜单&二级菜单
    $(".category").popover({
        trigger: 'manual',
        placement: 'right',
        html: 'true',
        content: '',
        animation: false
    }).on("mouseenter", function () {
        var cid = $(this).attr('c-id');
        $('#' + cid).show();
        $('#' + cid).hover(function () {
            $('#' + cid).show();
        }, function () {
            $('#' + cid).hide();
        });
    }).on("mouseleave", function () {
        var cid = $(this).attr('c-id');
        $('#' + cid).hide();
    });
</script>
</html>


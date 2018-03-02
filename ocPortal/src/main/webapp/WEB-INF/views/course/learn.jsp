<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/20
  Time: 21:45
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
<div class="f-main clearfix">
    <div class="main-course-left">
        <!-- 基础信息 - start -->
        <div class="course-info">
            <div class="course-title">${course.name}</div>

            <div class="course-meta">
                <c:if test="${empty user}">
                    <a href="${baseurl}course/save/${course.id}.page" class="learn-btn">加入课程</a>
                </c:if>
                <c:if test="${not empty user}">
                    <c:if test="${ifLearn}">
                        <a href="${baseurl}course/video/12.page" class="learn-btn">继续学习</a>
                        <div class="static-item">
                            <div class="meta">上次学到</div>
                            <div class="meta-value" title="${curCourseSection.name}">${curCourseSection.name}</div>
                        </div>
                    </c:if>
                    <c:if test="${!ifLearn}">
                        <a href="${baseurl}course/save/${course.id}.page" class="learn-btn">加入课程</a>
                    </c:if>
                </c:if>
                <div class="static-item">
                    <div class="meta">学习人数</div>
                    <div class="meta-value">${course.studyCount}</div>
                </div>
                <div class="static-item">
                    <div class="meta">难度级别</div>
                    <div class="meta-value">
                        <c:choose>
                            <c:when test="${course.level==1}">初级</c:when>
                            <c:when test="${course.level==2}">中级</c:when>
                            <c:otherwise>高级</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="static-item" style="border:none;">
                    <div class="meta">课程时长</div>
                    <div class="meta-value">${course.time}</div>
                </div>
                <c:if test="${not empty user}">
                    <c:if test="${ifCollect}">
                        <a id="collectionSpan" onclick="doCollect(${course.id})" href="javascript:void(0)"
                           class="followed" style="float: right;margin-top:5px;">
                        </a>
                    </c:if>
                    <c:if test="${!ifCollect}">
                        <a id="collectionSpan" onclick="doCollect(${course.id})" href="javascript:void(0)"
                           class="following" style="float: right;margin-top:5px;">
                        </a>
                    </c:if>
                </c:if>
                <c:if test="${empty user}">
                    <a id="collectionSpan" onclick="doCollect(${course.id})" href="javascript:void(0)" class="following"
                       style="float: right;margin-top:5px;">
                    </a>
                </c:if>
            </div>

            <div class="course-brief">
                ${course.brief}
            </div>

            <div class="course-menu">
                <a href="javascript:void(0)">
                    <span onclick="showTab(this,'courseSection')" class="menu-item cur">章节</span>
                </a>
                <a href="javascript:void(0)">
                    <span onclick="showTab(this,'commentQA',0)" class="menu-item">评论</span>
                </a>
                <a href="javascript:void(0)">
                    <span onclick="showTab(this,'commentQA',1)" class="menu-item">问答</span>
                </a>
            </div>
        </div>
        <!-- 基础信息 - end -->

        <!-- 章节信息 - start -->
        <div id="courseSection">
            <c:if test="${not empty chaptSections}">
                <c:forEach items="${chaptSections}" var="item">
                    <div class="chapter">
                        <a href="javascript:void(0);" class="js-open">
                            <h3>
                                <strong>
                                    <div class="icon-chapter">=</div>
                                        ${item.name}</strong>
                                <span class="drop-down">▼</span>
                            </h3>
                        </a>
                        <ul class="chapter-sub">
                            <c:if test="${not empty item.sectionDtoList}">
                                <c:forEach items="${item.sectionDtoList}" var="section">
                                    <a href="${baseurl}course/video/${section.id}.html">
                                        <li class="chapter-sub-li">
                                            <i class="icon-video">▶</i>${section.name} (${section.time})
                                        </li>
                                    </a>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <!-- 章节信息 - end -->


        <!-- 评论区 start -->
        <div id="commentQA">
        </div>
        <!-- 评论区 end -->
    </div>

    <div class="main-course-right"  >
        <c:if test="${not empty courseTeacher}">
            <div class="lecturer-item" style="width: 100%;">

                <c:if test="${not empty courseTeacher.header}">
                    <img class="lecturer-uimg" src="${courseTeacher.header}">
                </c:if>
                <c:if test="${empty courseTeacher.header}">
                    <img class="lecturer-uimg" src="${baseurl}/res/i/header.jpg">
                </c:if>


            <span class="lecturer-name">${(courseTeacher.realname)}</span>
            <span class="lecturer-title">${(courseTeacher.collegeName)} · ${(courseTeacher.education)}</span>
            <span class="lecturer-p" >${(courseTeacher.title)}，${(courseTeacher.sign)}</span>
            <a href="javascript:void(0)"  onclick="doFollow('${(courseTeacher.id)}');">
            <span id="followSpan" class="follow-btn">
            <c:if test="${empty user}">
                关注
            </c:if>
            <c:if test="${not empty user}">
                <c:if test="${ifFollow}">
                    取消关注
                </c:if>
                <c:if test="${!ifFollow}">
                    关注
                </c:if>
            </c:if>
            </span>
            </a>
            </div>
        </c:if>

        <h4 class="mt-50">推荐课程</h4>
        <c:if test="${not empty recomdCourseList}">
            <c:forEach items="${recomdCourseList}" var="item">
                <a href="${baseurl}/course/learn/${item.id}.page" target="_black" class="mb-5" title="${item.name}"><li class="ellipsis oc-color-hover">${item.name}</li></a>
            </c:forEach>
        </c:if>
    </div>

</div>


<script>
    $(function () {
        //实现 章节鼠标焦点 动态效果
        $('.chapter li').hover(function () {
            $(this).find('.icon-video').css('color', '#FFF');
        }, function () {
            $(this).find('.icon-video').css('color', '#777');
        });

        $('.js-open').click(function () {
            var display = $(this).parent().find('ul').css('display');
            if (display == 'none') {
                $(this).parent().find('ul').css('display', 'block');
                $(this).find('.drop-down').html('▼');
            } else {
                $(this).parent().find('ul').css('display', 'none');
                $(this).find('.drop-down').html('▲');
            }
        });
    });

    /**
     *展示tab commentQA
     **/
    function showTab(el, divId, type) {
        $('.course-menu').find('span').each(function (i, item) {
            $(item).removeClass('cur');
        });
        $(el).addClass('cur');

        if (divId == 'courseSection') {
            $('#courseSection').show();
            $('#commentQA').hide();
        } else {
            $('#commentQA').show();
            $('#courseSection').hide();
            _queryPage(1, type);//默认加载 第 1 页
        }
    }
    
    //关注
    function doFollow(teacherId) {
        $.ajax({
            url : '${baseurl}auth/doFollow/' + teacherId+ '.json',
            type: 'POST',
            dataType: 'json',
            success: function (result) {
                if(!result.ret){
                    window.location.href = "${baseurl}/auth/login.page";
                    return;
                }
                if(result.data == 2){
                    $('#followSpan').html("关注");
                    return;
                }
                if(result.data == 3){
                    $('#followSpan').html("取消关注");
                    return;
                }
            }
        })
    }

    //收藏
    function doCollect(courseId, url) {
        if (url == undefined) {
            url = '${baseurl}collections/doCollection/' + courseId + '.json';
        }
        //处理收藏
        $.ajax({
            url: url,
            type: 'POST',
            dataType: 'json',
            data: {"courseId": courseId},
            success: function (resp) {
                if (!resp.ret) {
                    window.location.href = "${baseurl}/auth/login.page";
                }
                if (resp.data == 1) {//已收藏
                    $('#collectionSpan').attr('class', 'followed');
                }
                if (resp.data == 2){
                    $('#collectionSpan').attr('class', 'following');
                }
            }
        });
    }
</script>
<%@ include file="/WEB-INF/views/common/foot.jsp" %>
</body>
</html>

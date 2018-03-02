<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/11
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<div class="f-header">
    <div class="f-header-box clearfix">
        <a href="${baseurl}"  class="logo" title="在线网校学习平台"></a>
        <nav class="header-nav">
            <a href="${baseurl}" class="header-nav-item">首 页</a>
            <a href="${baseurl}course/list.page" class="header-nav-item">课 程</a>
            <a href="${baseurl}/user/home.html" class="header-nav-item">我的</a>
            <a href="http://opt.ioswift.org" target="_blank" class="header-nav-item" style="width:100px;">运营CMS</a>
        </nav>

        <nav class="header-nav" style="float:right">

        <c:if test="${empty user}">
            <a href="#myModal" class="header-nav-item"  data-toggle="modal" onclick="login();"  style="margin-right:0px;font-size:14px;">登录</a>
            <a href="#myModal" class="header-nav-item" data-toggle="modal" onclick="window.location.href='${baseurl}auth/register.page'"  style="margin-left:0px;font-size:14px;">注册</a>
        </c:if>

        <c:if test="${not empty user}">
            <a href="${baseurl}/user/home.html" class="header-nav-item"  style="margin-left:0px;width:40px;height:40px;" id="userdetail">
                <img id="headerUserHeader" alt="" src='http://xiaojianyu-file-server.oss-cn-shenzhen.aliyuncs.com/student/00aa0b25-1cf9-45f9-a061-3ed9b2f96fde.jpg' style="width: 35px;height: 35px;border-radius:50%;">
            </a>
            <a href="#myModal" class="header-nav-item"  data-toggle="modal" onclick="logout();"  style="margin-right:0px;font-size:14px;">注销</a>
        </c:if>

    </nav>


    <!-- 登录之后显示用户的基本信息-start -->
    <div id="userdetailHtml" style="display: none;">
        <div style="padding:10px;">
            <div style="margin-top:10px;">
                <span style="font-size: 16px;">用户名：${user.username}</span>
            </div>

            <div style="margin-top:20px;">
                <a id="curCourseA" class="link-a" target="_blank" href="">
                    <div id="curCourseSpan" class="ellipsis" style="font-size: 16px;width:220px;height:30px;overflow:hidden;font-weight:bold;" title="" ></div>
                </a>
            </div>
            <div style="margin-top:5px;" >
                <a id="curCourseSectionA"  class="link-a" target="_blank" href="">
                    <div id="curCourseSectionSpan" class="ellipsis"  style="font-size: 14px;width:220px;height:30px;overflow:hidden;" title=""></div>
                </a>
            </div>

            <div style="margin-top:20px;border-top:1px solid #eee;width:200px;padding-top:10px;">
                <a class="link-a" onclick="logout()">
                    <span>退出</span>
                </a>
            </div>
        </div>
    </div>
    <!-- 登录之后显示用户的基本信息-end -->

</div>
</div>

<script type="text/javascript">
    $(function(){
        var headPhoto = $('#headerUserHeader').attr('src');
        if(headPhoto == null || headPhoto == '' || headPhoto == 'null'){
            var headPhoto = "${baseurl}res/i/header.jpg";
            $('#headerUserHeader').attr('src',headPhoto);
        }

        if(${not empty user}){
            <%--//获取当前用户学习进度--%>
            <%--$.ajax({--%>
                <%--url:CONTEXT_PATH + '/course/getCurLeanInfo.html',--%>
                <%--type:'POST',--%>
                <%--dataType:'json',--%>
                <%--success:function(resp){--%>
                    <%--if(resp.errcode == 0 && resp.data){--%>
                        <%--var learnUrl = "${baseurl}course/learn/"+resp.data.curCourse.id+".html";--%>
                        <%--var learnTitle = resp.data.curCourse.name;--%>
                        <%--$('#curCourseA').attr('href',learnUrl)--%>
                        <%--$('#curCourseSpan').attr('title',learnTitle).html(learnTitle);--%>

                        <%--var videoUrl = CONTEXT_PATH+"/course/video/"+resp.data.curCourseSection.id+".html";--%>
                        <%--var videoTitle = resp.data.curCourseSection.name;--%>
                        <%--$('#curCourseSectionA').attr('href',videoUrl)--%>
                        <%--$('#curCourseSectionSpan').attr('title',videoTitle).html(videoTitle);--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>

            $("#userdetail").popover({
                trigger:'manual',
                placement : 'bottom',
                html: true,
                content : '<div id="userdetailContent" style="width:300px;height:200px;"></div>',
                animation: false
            }).on("mouseenter", function () {
                var _this = this;
                $(this).popover("show");
                var userdetailHtml = $('#userdetailHtml').html();
                $('#userdetailContent').html(userdetailHtml);
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            }).on("mouseleave", function () {
                var _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 500);
            });
        }
    });

    function logout() {
        $.ajax({
            url:"${baseurl}auth/logout.json"
            , datatype : 'json'
            , success : function(result) {
                location.reload();
            }
        })
    }

    function login(){
        window.location.href="${baseurl}auth/login.page";
    }

</script>


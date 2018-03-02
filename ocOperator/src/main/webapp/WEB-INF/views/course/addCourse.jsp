<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/26
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>后台管理</title>
    <meta charset="utf-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <!-- 引入资源文件 -->
    <%@ include file="/WEB-INF/views/common/res.jsp" %>
</head>

<body>
<!-- top 导航 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 菜单导航 -->
<%@ include file="/WEB-INF/views/cms/cms-nav.jsp" %>

<div class="content">
    <div class="container-fluid">
        <div class="block span6">
            <div class="block-body collapse in" style="padding-top:10px;">
                <form role="form" id="courseForm" method="post" action="${baseurl}course/save.json"  enctype="multipart/form-data">
                    <input type="hidden" id="courseId" name="id" value=""/>
                    <div class="form-group clearfix">
                        <label class="control-label" >图片 <span id="imgErrSpan" style="color:red;font-weight:normal;"></span> </label>
                        <div class="col-sm-10">
                            <input type="file" id="pictureImg" name="pictureImg" style="display: none;" onchange="photoImgChange();">
                            <div class="ui-avatar-box">
                                <img id="coursePicture" style="max-width: 250px;height:120px;">
                                <a href="javascript:void(0);" onclick="doUpload();" style="text-decoration: underline;margin-top:5px;">选择图片</a>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="name" placeholder="请输入名称">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >分类</label>
                        <div class="col-sm-4">
                            <select id="classify" name="classify" class="form-control"  type="select">
                                <c:forEach items="${classify}" var="item">
                                    <option value="${item.code}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label class="control-label" >二级分类</label>
                        <div class="col-sm-4">
                            <select id="subClassify" name="subClassify" class="form-control"  type="select">
                                <c:forEach items="${subClassifys}" var="item">
                                    <option parentCode="${item.parentCode}" value="${item.code}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >级别</label>
                        <div class="col-sm-4">
                            <select name="level" class="form-control"  type="select">
                                <option value="1">初级</option>
                                <option value="2">中级</option>
                                <option value="3">高级</option>
                            </select>
                        </div>
                        <label class="control-label" >推荐权重</label>
                        <div class="col-sm-4">
                            <input type="text" name="weight" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >是否免费</label>
                        <div class="col-sm-4">
                            <select name="free" class="form-control"  type="select">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                        <label class="control-label" >价格</label>
                        <div class="col-sm-4">
                            <input type="text" name="price" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >讲师<span style="color:red;">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control"  name="username" placeholder="请输入讲师登录名">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="control-label" >概述</label>
                        <div class="col-sm-10">
                            <textarea name="brief" rows="2" cols="60"></textarea>
                        </div>
                    </div>
                    <div class="form-group clearfix" style="height:50px;">
                        <label class="control-label" ></label>
                        <div class="col-sm-4">
                            <input type="button" class="search-btn" onclick="doSave();" value=" 保存基本信息"  style="float:left;height:40px;"/>
                            <div  id="successAlert"  class="alert alert-success" style="display:none;float:left;margin-left:50px;margin-top:0px;">
                                <span id="successAlert_msg" class="color-oc f-16">保存成功！</span>
                            </div>
                        </div>
                    </div>
                    <div style="margin-bottom:5px;"><span id="failureMsg" style="color:red;"></span></div>
                </form>
            </div>
        </div>

        <div class="row-fluid">
            <ul id="myTab" class="nav nav-tabs">
                <li class="active">
                    <a href="#section" data-toggle="tab">章节</a>
                </li>
                <li>
                    <input style="margin-top:5px;" type="button" onclick="addCourseSection();" class="search-btn" value="+ 添加章" >
                </li>
                <li>
                    <input style="margin-top:5px;" type="button" onclick="saveCourseSection();" class="search-btn" value="保存章节信息" >
                </li>
                <li>
                    <input style="margin-top:5px;" type="button" onclick="importCourseSection();" class="search-btn" value="导入章节" >
                </li>
                <li>
                    <div  id="sectionTipsAlert"  style="display:none;float:left;margin-left:50px;margin-top:10px;height:30px;color:red;">
                        <span id="sectionTipsAlert_msg" class="color-oc f-14"></span>
                    </div>
                </li>
            </ul>
            <div id="myTabContent" class="tab-content" style="padding: 10px;">

            </div>
        </div>
    </div>
</div>

<!-- 添加章节 demo div  start -->
<div id="demoSection4Clone">
    <div id="demoCourseSectionDiv" sid="demoCourseSectionDiv" style="padding:20px;border:1px solid #CCC; margin-bottom:20px;display:none;">
        <div class="form-group clearfix">
            <label class="control-label" >章名称</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" name="sectionName"  placeholder="请输入名称"  >
            </div>
            <div class="col-sm-1">
                <input type="button" onclick="deleteCourseSection(this);" class="search-btn" value="- 删除章" >
            </div>
            <div class="col-sm-1" style="padding-left:25px;">
                <input type="button" onclick="addSection(this);" class="search-btn" value="+ 添加节"  >
            </div>
        </div>

        <div id="demoSectionDiv" sid ="demoSectionDiv" class="form-group clearfix">
            <label class="control-label" style="margin-left:55px;">节信息</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="subSectionName"  placeholder="请输入节名称"  style="margin-bottom:5px;">
                <input type="text" class="form-control" name="videoUrl"  placeholder="请输入视频链接"   style="margin-bottom:5px;">
                <input type="text" class="form-control" name="time"  placeholder="请输入时长 00:00"   style="margin-bottom:5px;">
            </div>
            <div class="col-sm-1">
                <input type="button" onclick="deleteSection(this);" class="search-btn" value="- 删除节" >
            </div>
        </div>

    </div>
</div>
<!-- 添加章节 demo div  end -->



<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    //过滤二级分类
    function filterSubClassify(classify){
        var flag = false;
        $('#subClassify').find("option").each(function(i,item){
            if($(item).attr('parentCode') == classify){
                if(flag == false){
                    $('#subClassify').val($(item).attr('value'));//默认选中第一个
                    flag = true;
                }
                $(item).show();
            }else{
                $(item).hide();
            }
        });
    }
    $(function(){
        filterSubClassify($('#classify').val());//第一次加载的时候过滤
        $('#classify').change(function(){
            filterSubClassify($('#classify').val());
        });
    });

    //选择图片
    function doUpload(){
        $('#pictureImg').click();
    }
    //选择图片
    function photoImgChange(){
        var img = $('#pictureImg').val();
        if(oc.photoValid(img)){
            oc.previewUploadImg('pictureImg','coursePicture');
            $('#coursePicture').show();
            $('#imgErrSpan').html('');
            return;
        }else{
            $('#imgErrSpan').html('&nbsp;请选择png,jpeg,jpg格式图片');
            $('#coursePicture').val('');
        }
    }

    //保存
    function doSave(){
        $('#courseForm').ajaxSubmit({
            datatype:'json',
            success : function(resp) {
                resp = $.parseJSON(resp.replace(/<.*?>/ig,""));
                if (resp.ret) {
                    $("#successAlert").show().fadeOut(2500);//显示模态框
                    var id = resp.data.id;
                    $('#courseId').val(id);
                    $('#failureMsg').html('');
                } else {
                    $('#failureMsg').html(resp.msg);
                }
            }
        });
    }

    //添加章
    function addCourseSection(){
        //先克隆,拿里面的元素
        var tmpDiv = $('#demoSection4Clone').clone().html();
        //显示改为可见属性
        tmpDiv = tmpDiv.replace('display:none','display:block');
        $('#myTabContent').append(tmpDiv);
    }

    //删除章
    function deleteCourseSection(el){
        $(el).parent().parent().parent().remove();
    }

    //添加节
    function addSection(el){
        var sectionDiv = $('#demoSectionDiv').clone();
        $(el).parent().parent().parent().append(sectionDiv);
    }

    //删除节
    function deleteSection(el){
        $(el).parent().parent().remove();
    }

    //保存章节信息
    function saveCourseSection(){
        var courseId = $('#courseId').val();
        if(courseId == ''){
            $("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
            $("#sectionTipsAlert_msg").html('请先保存课程基本信息');
            return;
        }

        var sectionDivs = $('#myTabContent').find("div[sid='demoCourseSectionDiv']");
        //js中的数组
        var batchSections = [];
        //章
        $.each(sectionDivs,function(i,item){
            var sectionName = $(item).find("input[name='sectionName']").val();
            if(sectionName && $.trim(sectionName) != ''){
                //js中的对象封装
                var obj = {};
                obj.name = $.trim(sectionName);
                obj.courseId = $('#courseId').val();
                    obj.sectionDtoList = [];
                //节
                var subSectionDivs = $(item).find("div[sid='demoSectionDiv']");
                $.each(subSectionDivs,function(j,subItem){
                    var subSectionName = $(subItem).find("input[name='subSectionName']").val();
                    var videoUrl = $(subItem).find("input[name='videoUrl']").val();
                    var time = $(subItem).find("input[name='time']").val();
                    //正则表达式验证time
                    var regTime = RegExp(/^([0-5][0-9]):([0-5][0-9])$/);
                    if (!regTime.test(time)) {//如果验证不通过
                        time = "00:00";
                    }
                    if(subSectionName && $.trim(subSectionName) != ''){
                        var subObj = {};
                        subObj.name = $.trim(subSectionName);
                        subObj.videoUrl = $.trim(videoUrl);
                        subObj.time = $.trim(time);
                        obj.sectionDtoList.push(subObj);
                    }
                });
                batchSections.push(obj);
            }
        });
        if(batchSections.length == 0){
            $("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
            $("#sectionTipsAlert_msg").html('请填写章节信息');
            return;
        }
        //JSON.stringify(batchSections);
        $.ajax({
            url:'${baseurl}courseSection/batchAdd.json',
            type:'POST',
            contentType: "application/json",
            dataType:'json',
            data:JSON.stringify(batchSections),
            success:function(resp){
                if(resp.ret){
                    //保存成功，跳转到详情页
                    window.location.href='${baseurl}course/read.page?id='+$('#courseId').val();
                }
            }
        });
    }
</script>
</body>
</html>

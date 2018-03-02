<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/25
  Time: 16:36
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
            <div class="block-body collapse in">

                <!-- 课程基本信息 -->
                <table class="table list">
                    <tbody>
                    <tr>
                        <td style="width: 600px;">
                            <c:if test="${not empty course.picture && course.picture != ''}">
                                <img src="${course.picture}" style="width: 180px;height:100px;float: left;">
                            </c:if>
                            <c:if test="${!(not empty course.picture && course.picture != '')}">
                                <img src="${baseurl}res/i/course.png" style="width: 180px;height:100px;float: left;">
                            </c:if>
                            <div class="ml-15 w-350" style="float:left;">
                                <p class="ellipsis"  title="${course.name}"><strong>${course.name}</strong></p>
                                <p class="ellipsis-multi h-40" title="${course.brief}">${course.brief}</p>
                            </div>
                        </td>
                        <td>
                            <p>${course.time}</p>
                            <p style="color: red;">
                                <c:if test="${course.free}">
                                    免费
                                </c:if>
                                <c:if test="${!course.free}">
                                    ￥${course.price}
                                </c:if>
                            </p>
                            <p>
                               <c:choose>
                                   <c:when test="${course.level eq '1'}">
                                       初级
                                   </c:when>
                                   <c:when test="${course.level eq '2'}">
                                       中级
                                   </c:when>
                                   <c:otherwise>
                                       高级
                                   </c:otherwise>
                               </c:choose>
                            </p>
                        </td>
                        <td>
                            <p>${course.classifyName} / ${course.subClassifyName}</p>
                            <p>${course.studyCount}人在学</p>
                            <p>${course.username}</p>
                            <p><fmt:formatDate value="${course.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                        </td>
                        <td style="width:120px;">
                            <p>推荐权重：${course.weight}</p>
                            <p><a href="javascript:void(0)" onclick="toEdit(${course.id})">修改信息</a></p>
                            <p><a href="${baseurl}course/append.page?courseId=${course.id}" >添加章节</a></p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="row-fluid">
            <ul id="myTab" class="nav nav-tabs">
                <li class="active">
                    <a href="#section" data-toggle="tab">章节</a>
                </li>
                <li onclick="activeComment(${course.id},0);"><a href="#comment" data-toggle="tab">评论</a></li>
                <li onclick="activeComment(${course.id},1);"><a href="#qa" data-toggle="tab">问答</a></li>
                <li><a href="#studentCount" data-toggle="tab">统计</a></li>
            </ul>

            <div id="myTabContent" class="tab-content" style="padding: 10px;">
                <!-- 课程章节-start -->
                <div class="tab-pane fade in active" id="section">
                    <c:if test="${not empty chaptSections}">
                        <c:forEach items="${chaptSections}" var="item">
                            <div class="chapter" id="chapter-${item.id}" >
                                <h3>
                                    <strong id="sectionTitle_${item.id}" >${item.name}(${item.time})</strong>
                                    <a href="javascript:void(0);" class="chapter-edit" style="margin-right:20px;" onclick="doDeleteSection(${item.id},0)">删除</a>
                                    <a href="javascript:void(0);" class="chapter-edit" onclick="toEditSection(${item.id},0)">修改</a>
                                    <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${item.id},0)">↑</a>
                                    <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${item.id},1)">↓</a>
                                    <a href="javascript:void(0);" class="chapter-edit" style="margin-right:20px;" onclick="doAddSection(${item.id},${course.id})">新增节</a>
                                </h3>
                                <ul class="chapter-sub">
                                    <c:if test="${not empty item.sectionDtoList}">
                                        <c:forEach items="${item.sectionDtoList}" var="section">
                                            <li id="chapter-sub-li-${section.id}" class="chapter-sub-li">
                                                <span id="sectionSubTitle_${section.id}" >${section.name} (${section.time})</span>
                                                <a href="javascript:void(0);" class="chapter-edit" onclick="doDeleteSection(${section.id},1)">删除</a>
                                                <a href="javascript:void(0);" class="chapter-edit" onclick="toEditSection(${section.id},1)">修改</a>
                                                <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${section.id},0)">↑</a>
                                                <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${section.id},1)">↓</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <!-- 课程章节-end -->

                <!-- 评论 -start -->
                <div class="tab-pane fade" id="comment"></div>
                <!-- 评论 -end -->

                <!-- 问答 -start -->
                <div class="tab-pane fade" id="qa"></div>
                <!-- 问答 -end -->

                <!-- 报表 - start -->
                <%--<#include "./readReport.html" />--%>
                <!-- 报表 - end -->
            </div>
        </div>

    </div>
</div>

<!-- 章节弹出层 -start -->
<div class="modal" id="sectionModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal_wapper">
        <div class="modal-dialog w-8" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" >课程章节信息</h4>
                </div>

                <div class="modal-body">
                    <form role="form" id="sectionForm" method="post" action="${baseurl}courseSection/saveSection.json">
                        <input type="hidden" id="sectionHiddenId" name="id"/>
                        <input type="hidden" id="sectionHiddenParentId" name="parentId"/>
                        <div class="form-group">
                            <label>名称</label>
                            <input type="text" class="form-control" name="name" id="sectionName" placeholder="请输入名称">
                        </div>
                        <div class="form-group" id="videoUrl-group">
                            <label>视频地址</label>
                            <input type="text" class="form-control" name="videoUrl" id="videoUrl" placeholder="请输入url">
                        </div>
                        <div class="form-group" id="time-group">
                            <label>时长</label>
                            <input type="text" class="form-control" name="time" id="sectionTime" placeholder="请输入分钟数">
                        </div>
                    </form>
                    <!-- tip提示-start -->
                    <div id="_ocAlertTipCourseSection" class="alert alert-success f-16" style="display: none;"></div>
                    <!-- tip提示-end -->
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="doSaveSection();">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 章节弹出层 -end -->

<!-- 课程信息弹出层 -start -->
<div class="modal" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal_wapper">
        <div class="modal-dialog w-8" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" >课程基本信息</h4>
                </div>

                <div class="modal-body">
                    <form role="form" id="courseForm" method="post" action="${baseurl}course/save.json"  enctype="multipart/form-data">
                        <input type="hidden" name="id" value=""/>
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
                                <select id="ifFree" name="free" class="form-control"  type="select">
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
                            <label class="control-label" >讲师</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control"  name="username" >
                            </div>
                            <label class="control-label" >时长</label>
                            <div class="col-sm-4">
                                <input class="form-control"  type="text" name="time" >
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="control-label" >概述</label>
                            <div class="col-sm-10">
                                <textarea name="brief" rows="2" cols="60"></textarea>
                            </div>
                        </div>
                    </form>

                    <!-- tip提示-start -->
                    <div id="_ocAlertTip" class="alert alert-success f-16" style="display: none;"></div>
                    <!-- tip提示-end -->
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="doSave();">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 课程信息弹出层 -end -->


<!-- 弹出层 alert 信息 -->
<div class="modal" id="_ocDialogModal" tabindex="-1" aria-hidden="true">
    <div class="modal_wapper small">
        <div class="modal-dialog w-4" >
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title f-16" >提示信息</div>
                </div>
                <div class="modal-body">
                    <div><span class="color-oc f-16 oc-content"></span></div>
                </div>
                <div class="modal-footer modal-center">
                    <button type="button" class="btn btn-primary oc-ok">确 定</button>
                    <button type="button" class="btn btn-default oc-cancel">取 消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 弹出层 alert 信息 -->

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">

    function doAddSection(parentId,courseId) {
        Modal.show('sectionModal');
        $("#sectionHiddenParentId").val(parentId);
    }

    //删除章节 0-章，1-节
    function doDeleteSection(id,type){
        Modal.confirm('确定删除?',function(){
            $.ajax({
                url:'${baseurl}courseSection/delete.json',
                type:'POST',
                dataType:'json',
                data:{"id":id},
                success:function(resp){
                    if(resp.ret){
                        if(type == 0){
                            $('#chapter-'+id).remove();
                        }else{
                            $('#chapter-sub-li-'+id).remove();
                        }
                    }
                }
            });
        });
    }

    //保存章节
    function doSaveSection(){
        var id = $('#sectionHiddenId').val();
        var parentId = $('#sectionHiddenParentId').val();
        $('#sectionForm').ajaxSubmit({
            datatype : 'json',
            success : function(resp) {
                if (resp.ret) {
                    if(resp.data ==1){
                        window.location.reload();
                    }
                    if(parentId == 0){//一级标题
                        $('#sectionTitle_' + id).html($('#sectionName').val());
                    }else{//二级标题
                        $('#sectionSubTitle_' + id).html($('#sectionName').val() + "(" + $('#sectionTime').val() + ")");
                    }
                    Modal.hide('sectionModal');
                } else {
                    alert('保存失败');
                }
            }
        });
    }

    //编辑章节
    function toEditSection(id,type){
        if(type == 1){//节
            $('#videoUrl-group').show();
            $('#time-group').show();
        }else{
            $('#videoUrl-group').hide();
            $('#time-group').hide();
        }
        $.ajax({
            url:'${baseurl}courseSection/getById.json',
            type:'POST',
            dataType:'json',
            data:{"id":id},
            success:function(resp){
                if(resp.ret){
                    Modal.show('sectionModal');
                    $("#sectionForm").fill(resp.data);
                }
            }
        });
    }

    //修改课程基本信息
    function toEdit(id){
        Modal.show('myModal');
        $.ajax({
            url:'${baseurl}course/getById.json',
            type:'POST',
            dataType:'json',
            data:{"id":id},
            success:function(resp){
                if(resp.ret){
                    Modal.show('myModal');
                    $("#courseForm").fill(resp.data);
                    $('#coursePicture').attr('src',resp.data.picture)
                    if(resp.data.free){
                        $("#ifFree").html("").html(' <option value=true selected>是</option>\n' +
                            '                                    <option value=false>否</option>')
                    }else {
                        $("#ifFree").html("").html(' <option value=true>是</option>\n' +
                            '                                    <option value=false selected>否</option>')
                    }
                }
            }
        });
    }

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
                    window.location.href='${baseurl}course/read.page?id='+resp.data.id;
                } else {
                    $('#failureMsg').html(resp.msg);
                }
            }
        });
    }

    //排序
    function toSortSection(id,sortType){
        $.ajax({
            url:'${baseurl}courseSection/sortSection.json',
            type:'POST',
            dataType:'json',
            data:{"id":id,"sortType":sortType},
            success:function(resp){
                if(resp.ret){
                    window.location.reload();
                }
            }
        });
    }

</script>
</body>
</html>

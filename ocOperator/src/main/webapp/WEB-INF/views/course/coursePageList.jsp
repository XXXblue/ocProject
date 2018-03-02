<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/25
  Time: 14:38
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


        <form id="queryPageForm" class="mt-15" action="" method="POST">
            <div class="row-fluid">
                <div class="cms-search">
                    <a href="javascript:void(0)" sortField="update_time"
                       class="search-sort-block   <c:if test="${not empty page.sortField && page.sortField == 'update_time'}">search-sort-block-cur</c:if>">
                        <span>更新时间</span>
                        <c:if test="${not empty page.sortField && page.sortField eq 'update_time'}">
                            <c:if test="${page.sortDirection eq 'DESC'}"><span>▼</span></c:if>
                            <c:if test="${!page.sortDirection eq 'DESC'}"><span>▲</span></c:if>
                        </c:if>
                    </a>
                    <a href="javascript:void(0)" sortField="weight"
                       class="search-sort-block <c:if test="${not empty page.sortField && page.sortField == 'weight'}">search-sort-block-cur</c:if>">
                        <span>推荐权重</span>
                        <c:if test="${not empty page.sortField && page.sortField eq 'weight'}">
                            <c:if test="${page.sortDirection eq 'DESC'}"><span>▼</span></c:if>
                            <c:if test="${!page.sortDirection eq 'DESC'}"><span>▲</span></c:if>
                        </c:if>
                    </a>
                    <input type="hidden" id="sortField" name="sortField" value="${page.sortField}"/>
                    <input type="hidden" id="sortDirection" name="sortDirection" value="${page.sortDirection}"/>
                    <input type="text" class="search-text" name="name" value="${queryEntity.name}"
                           style="margin-top:5px;" placeholder="请输入课程名称">
                    <input type="submit" class="search-btn" value="搜索"/>
                    <input type="button" class="search-btn" onclick="window.location.href='${baseurl}course/addCourse.page'"
                           value=" + 添加课程 "/>
                </div>
            </div>

            <div class="row-fluid">
                <div class="block span6">
                    <div id="widget2container" class="block-body">
                        <table class="table list">
                            <tbody>
                                <c:if test="${not empty page.items}">
                                <c:forEach items="${page.items}" var="item">

                                <tr id="tr-${item.id}">
                                    <td style="width:600px;">
                                        <p>
                                            <a href="${baseurl}course/read.page?id=${item.id}">
                                                <c:if test="${not empty item.picture}">
                                                    <img src="${item.picture}"
                                                         style="width: 180px;height:100px;float: left;">
                                                </c:if>
                                                <c:if test="${empty item.picture}">
                                                    <img src="${baseurl}res/i/course.png"
                                                         style="width: 180px;height:100px;float: left;">
                                                </c:if>
                                            </a>
                                            <div class="ml-15 w-350" style="float:left;">
                                                <a href="${baseurl}course/read.page?id=${item.id}">
                                                <p class="ellipsis" title="${item.name}"><strong>${item.name}</strong></p>
                                                </a>
                                                <p class="ellipsis-multi h-40" title="${item.brief}">${item.brief}</p>
                                            </div>
                                         </p>
                                     </td>
                                    <td>
                                        <p>${item.time}</p>
                                        <p style="color: red;">
                                            <c:if test="${item.free}">￥${item.price}</c:if>
                                            <c:if test="${!item.free}">免费</c:if>
                                        </p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${item.level eq '1'}">
                                                    初级
                                                </c:when>
                                                <c:when test="${item.level eq '2'}">
                                                    中级
                                                </c:when>
                                                <c:otherwise>
                                                    高级
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </td>
                                    <td>
                                        <p>${item.classifyName} / ${item.subClassifyName}</p>
                                        <p>${item.studyCount}人在学</p>
                                        <p> <fmt:formatDate value="${item.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                    </td>
                                    <td style="width:120px;">
                                        <p>推荐权重：${item.weight}</p>
                                        <p><a href="javascript:void(0)" onclick="doSale(${item.id},${item.onsale});">
                                            <c:if test="${!item.onsale}">课程上架</c:if>
                                            <c:if test="${item.onsale}">课程下架</c:if>
                                        </a></p>
                                        <p><a href="javascript:void(0)" onclick="doDelete(${item.id});">删除</a></p>
                                    </td>
                                </tr>
                                </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                        <p>
                            <%@ include file="/WEB-INF/views/common/page.jsp" %>
                        </p>
                </div>
            </div>
    </div>
    </form>


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
                                        <%--<#list classifys as item>--%>
                                            <%--<option value="${baseurl}">${item.name}</option>--%>
                                        <%--</#list>--%>
                                    </select>
                                </div>
                                <label class="control-label" >二级分类</label>
                                <div class="col-sm-4">
                                    <select id="subClassify" name="subClassify" class="form-control"  type="select">
                                        <%--<#list subClassifys as item>--%>
                                            <%--<option parentCode="${item.parentCode}" value="${item.code}">${item.name}</option>--%>
                                        <%--</#list>--%>
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
                                <label class="control-label" >讲师</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control"  name="username" >
                                </div>
                                <label class="control-label" >时长</label>
                                <div class="col-sm-4">
                                    <input class="form-control"  type="text" name="time" readonly="readonly">
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



</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    var pageNum = '${page.pageNum}';
    var name = '${queryEntity.name}';
    function _queryPage(pageNum) {
        document.write("<form action='${baseurl}course/coursePageList.page' method=post name=form1 style='display:none'>");
        <c:if test="${not empty queryEntity.name}">
        document.write("<input type=hidden name=name value='"+name+"'/>");
        </c:if>
        document.write("<input type=hidden name=pageNum value='"+pageNum+"'/>");
        document.write("</form>");
        document.form1.submit();
    }

    //课程上下架
    function doSale(id,sale){
        if(sale == 0){
            sale = 1;
        }else{
            sale = 0;
        }
        $.ajax({
            url:'${baseurl}course/doSale.json',
            type:'POST',
            dataType:'json',
            data:{"id":id,onsale:sale},
            success:function(resp){
                if(resp.ret){
                    _queryPage(pageNum);
                }
            }
        });
    }

    //课程删除
    function doDelete(id){
        Modal.confirm('课程章节将一并删除，确定删除?',function(){

        });
    }
</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/18
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="sidebar-nav">
    <a href="#dashboard-menu" class="nav-header" data-toggle="collapse">
        <span style="font-weight: bold;font-size: 16px;">工作区</span>
    </a>
    <ul id="dashboard-menu" class="nav nav-list collapse in">
        <li>
            <a href="${baseurl}index.html">主 页</a>
        </li>
        <li <c:if test="${not empty curNav && curNav == 'course'}">class="active"</c:if>>
            <a href="${baseurl}course/coursePageList.page">课程管理</a>
        </li>
        <li>
            <a href="${baseurl}carousel/queryPage.html">轮播配置</a>
        </li>
        <li <c:if test="${not empty curNav && curNav == 'classify'}">class="active"</c:if>>
            <a href="${baseurl}classify/index.page">课程分类管理</a>
        </li>
        <li <c:if test="${not empty curNav && curNav == 'user'}">class="active"</c:if>>
            <a href="${baseurl}user/userPageList.page">用户管理</a>
        </li>
        <li <c:if test="${not empty curNav && curNav == 'college'}">class="active"</c:if>>
            <a href="${baseurl}college/queryPageList.page">网校管理</a>
        </li>
    </ul>

    <a href="#accounts-menu" class="nav-header" data-toggle="collapse">
        <span style="font-weight: bold;font-size: 16px;">我的账号</span>
    </a>
    <ul id="accounts-menu" class="nav nav-list collapse in">
        <li><a href="${baseurl}auth/logout.html">退出</a></li>
    </ul>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</div>

<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/22
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

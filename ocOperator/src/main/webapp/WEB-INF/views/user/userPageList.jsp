<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/22
  Time: 13:43
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
        <form id="queryPageForm" class="mt-15" >
            <div class="block span6">
                <a class="block-heading f-14" data-toggle="collapse">用户管理</a>
                <div class="block-body collapse in">
                    <p>
                        <select  name="status" class="search-select">
                            <option value="-1"<c:if test="${not empty queryEntity.status && queryEntity.status=='-1'}">selected="selected"</c:if> >全部</option>
                            <option value="2" <c:if test="${not empty queryEntity.status && queryEntity.status=='2'}">selected="selected"</c:if> >可用</option>
                            <option value="0" <c:if test="${not empty queryEntity.status && queryEntity.status=='0'}">selected="selected"</c:if>>禁用</option>
                        </select>
                    </p>
                    <p>
                        <input name="username" type="text" value="${(queryEntity.username)}" class="search-text" placeholder="请输入登录名">
                    </p>
                    <p>
                        <input type="submit" class="search-btn" value="搜索">
                    </p>
                </div>
            </div>

            <div class="row-fluid">
                <div class="block span6">
                    <div id="tablewidget" class="block-body collapse in">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>姓名</th>
                                <th>登录名</th>
                                <th>学历</th>
                                <th>学校</th>
                                <th>手机</th>
                                <th>状态</th>
                                <th>性别</th>
                                <th>权重</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty page.items}">
                                <c:forEach items="${page.items}" var="item">
                                    <tr>
                                        <td>${item.realname}</td>
                                        <td>${item.username}</td>
                                        <td>${item.education}</td>
                                        <td>${item.collegeName}</td>
                                        <td>${item.mobile}</td>
                                        <td>
                                            <c:if test="${item.status == '2'}">
                                                可用
                                            </c:if>
                                            <c:if test="${item.status == '0'}">
                                                禁用
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${item.gender}">
                                                女
                                            </c:if>
                                            <c:if test="${!item.gender}">
                                                男
                                            </c:if>
                                        </td>
                                        <td>${item.weight}</td>
                                        <td>
                                            <a href="javascript:void(0)" onclick="toEdit(${item.id});">修改</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <p><%@ include file="/WEB-INF/views/common/page.jsp" %></p>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<!-- 弹出层 -start -->
<div class="modal fade " id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal_wapper">
        <div class="modal-dialog " >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" >修改教师信息</h4>
                </div>

                <div class="modal-body">
                    <form id="myForm" role="form" id="ff" action="${baseurl}/user/save">
                        <input type="hidden"  name="id" />
                        <div class="form-group">
                            <label>名称</label>
                            <input type="text" class="form-control"  name="realname" placeholder="请输入名称">
                        </div>
                        <div class="form-group">
                            <label>登录名</label>
                            <input type="text" class="form-control" readonly="readonly"  name="username"  placeholder="请输入名称">
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select id="status" name="status" class="form-control"  type="select">
                                <option value="2">可用</option>
                                <option value="0">禁用</option>
                            </select>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="doSave();">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 弹出层 -end -->


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    var pageNum = '${page.pageNum}';
    var username = '${queryEntity.username}';
    var status = '${queryEntity.status}';
    //分页
    function _queryPage(pageNum) {
        document.write("<form action='${baseurl}user/userPageList.page' method=post name=form1 style='display:none'>");
        <c:if test="${not empty queryEntity.username}">
        document.write("<input type=hidden name=username value='"+username+"'/>");
        </c:if>
        <c:if test="${not empty queryEntity.status}">
        document.write("<input type=hidden name=status value='"+status+"'/>");
        </c:if>
        document.write("<input type=hidden name=pageNum value='"+pageNum+"'/>");
        document.write("</form>");
        document.form1.submit();
    }

    function doSave(){
        $('#myForm').ajaxSubmit({
            datatype : 'json',
            type:'POST',
            success : function(resp) {
                if (resp.ret) {
                    $('#myModal').modal('hide');
                    _queryPage(pageNum);
                } else {
                    Modal.tipFailure(resp.message);//失败提示
                }
            }
        });
    }

    function toEdit(id){
        $.ajax({
            url:'${baseurl}user/getById.json',
            type:'POST',
            dataType:'json',
            data:{"id":id},
            success:function(resp){
                if(resp.ret){
                    $("#myForm").fill(resp.data);
                    $('#myModal').modal('show');
                }
            }
        });
    }
</script>
</body>
</html>

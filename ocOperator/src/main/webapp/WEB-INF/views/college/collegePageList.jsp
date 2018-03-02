<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/18
  Time: 17:09
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

        <form id="queryPageForm" class="mt-15" method="POST" action="">
            <div class="block span6">
                <a class="block-heading f-14" data-toggle="collapse">网校管理</a>
                <div class="block-body collapse in">
                    <p>
                        <input name="name" type="text" value="${tConstsCollege.name}" class="search-text"
                               placeholder="请输入名称"/>
                    </p>
                    <p>
                        <input type="submit" class="search-btn" value="搜索"/>
                        <input type="button" class="search-btn" onclick="toEdit();" value=" + 添加"/>
                    </p>
                </div>
            </div>

            <div class="row-fluid">
                <div class="block span6">
                    <div id="tablewidget" class="block-body collapse in">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>名称</th>
                                <th>编码</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty page.items}">
                                <c:forEach items="${page.items}" varStatus="status" var="item">
                                    <tr>
                                        <td>${item.name}</td>
                                        <td>${item.code}</td>
                                        <td>
                                            <a class="link-a" href="javascript:void(0)"
                                               onclick="toEdit(${item.id})">修改</a>
                                            <a class="link-a" href="javascript:void(0)" onclick="doDelete(${item.id})">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <%@ include file="/WEB-INF/views/common/page.jsp" %>
        </form>
    </div>
</div>

<!-- 弹出层 -start -->
<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal_wapper">
        <div class="modal-dialog w-8">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">网校信息</h4>
                </div>

                <div class="modal-body">
                    <form role="form" id="myForm" method="post" action="${baseurl}college/save.json">
                        <input type="hidden" name="id" value=""/>
                        <div class="form-group">
                            <label for="name">名称</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="请输入名称">
                        </div>
                        <div class="form-group">
                            <label for="name">编码</label>
                            <input type="text" class="form-control" name="code" id="code" placeholder="请输入编码">
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
<!-- 弹出层 -end -->


<script type="text/javascript">
    //TODO:这个新增的刷新还没有弄
    function _queryPage(pageNum, code, sort) {
        document.write("<form action='${baseurl}college/queryPageList' method=post name=form1 style='display:none'>");
        <c:if test="${not empty tConstsCollege.name}">
        document.write("<input type=hidden name=name value='"+"${tConstsCollege.name}"+"'/>");
        </c:if>
        document.write("<input type=hidden name=pageNum value='"+pageNum+"'/>");
        document.write("</form>");
        document.form1.submit();
    }


    function toEdit(id) {
        if (id == undefined) {//添加
            Modal.show('myModal');
            $('#code').removeAttr('disabled');
        } else {
            Modal.show('myModal');
            $('#code').attr('disabled', 'disabled');
            $.ajax({
                url: '${baseurl}college/getById',
                type: 'POST',
                dataType: 'json',
                data: {"id": id},
                success: function (result) {
                    if (result.ret) {
                        Modal.show('myModal');
                        //数据的重新填充
                        $("#myForm").fill(result.data);
                    }
                }
            });
        }
    }

    //保存
    function doSave() {
        $('#code').removeAttr('disabled');
        $('#myForm').ajaxSubmit({
            datatype: 'json',
            success: function (result) {
                if (result.ret) {
                    $('#myModal').modal('hide');
//                    _queryPage();//当前分页刷新

                } else {
                    Modal.tipFailure(result.msg);//失败提示
                }
            },
            error: function () {
                Modal.tipFailure('保存失败');
                //alert(arguments[0].responseText);
            }
        });
    }

    //删除
    function doDelete(id) {
        Ewin.confirm({ message: "确认要删除选择的数据吗？" }).on(function (e) {
            if (!e) {
                return;
            }
            $.ajax({
                url: '${baseurl}college/delete',
                type: 'POST',
                dataType: 'json',
                data: {"id": id},
                success: function (result) {
                    if (result.ret) {
                        window.location.reload();//刷新
                    }
                }
            });
        });
    }
</script>
</body>
</html>

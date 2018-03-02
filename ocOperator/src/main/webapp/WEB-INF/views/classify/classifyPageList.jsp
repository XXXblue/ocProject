<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/23
  Time: 0:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <input type="button" class="search-btn mt-10" style="margin-left: 15px;" onclick="toEdit();" value=" 添加分类"/>
    <div class="container-fluid pt-10">
        <div class="panel panel-5">
            <a class="block-heading f-14" data-toggle="collapse">一级分类</a>
            <div class="block-body collapse in">
                <table class="table">
                    <thead>
                    <tr>
                        <th>名称</th>
                        <th>编码</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty classify}">
                        <c:forEach items="${classify}" var="item">
                            <tr class="tr-bg-gray" code="${item.code}">
                                <td>${item.name}</td>
                                <td>${item.code}</td>
                                <td>
                                    <a class="link-a" href="javascript:void(0)" onclick="toEdit(${item.id})">修改</a>
                                    <a class="link-a" href="javascript:void(0)" onclick="doDelete(${item.id})">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-5">
            <a class="block-heading f-14" data-toggle="collapse">二级分类</a>
            <div class="block-body collapse in">
                <table id="subClassifysTable" class="table">
                    <thead>
                    <tr name="th">
                        <th>名称</th>
                        <th>编码</th>
                        <th>一级分类编码</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty subClassifys}">
                        <c:forEach items="${subClassifys}" var="item">
                            <tr code="${item.code}" parentCode="${item.parentCode}">
                                <td>${item.name}</td>
                                <td>${item.code}</td>
                                <td>${item.parentCode}</td>
                                <td>
                                    <a class="link-a" href="javascript:void(0)" onclick="toEdit(${item.id})">修改</a>
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
</div>


<!-- 弹出层 -start -->
<div class="modal" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal_wapper">
        <div class="modal-dialog w-8" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" >课程分类</h4>
                </div>
                <div class="modal-body">
                    <form role="form" id="myForm" method="post" action="${baseurl}classify/save.json">
                        <input type="hidden" name="id" value=""/>
                        <div class="form-group">
                            <label for="name">一级分类</label>
                            <select name="parentCode" class="form-control"  type="select">
                                <option value="0">总分类</option>
                                <c:if test="${not empty classify}">
                                    <c:forEach items="${classify}" var="item">
                                        <option value="${item.code}">${item.name}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
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


    //TODO:解决修改事件和弹窗事件
    $(function(){
        $('.tr-bg-gray').click(function(){
            var code = $(this).attr('code');
            $("#subClassifysTable tbody tr").each(function(){
                if(code == $(this).attr('parentCode')){
                    $(this).show();
                }else {
                    $(this).hide();
                }
            });
        });
    })

    function toEdit(id){
        if(id == undefined){//添加
            Modal.show('myModal');
            $('#code').removeAttr('disabled');
        }else{
            $('#code').attr('disabled','disabled');
            $.ajax({
                url:'${baseurl}classify/getById.json',
                type:'POST',
                dataType:'json',
                data:{"id":id},
                success:function(resp){
                    if(resp.ret){
                        Modal.show('myModal');
                        $("#myForm").fill(resp.data);
                    }
                }
            });
        }
    }

    //保存
    function doSave(){
        $('#code').removeAttr('disabled');
        $('#myForm').ajaxSubmit({
            datatype : 'json',
            success : function(resp) {
                if (resp.ret) {
                    $('#myModal').modal('hide');
                    window.location.reload();//刷新
                } else {
                    Modal.tipFailure(resp.msg);//失败提示
                }
            }
        });
    }

    //删除
    function doDelete(id){
        Modal.confirm('确定删除?',function(){
            $.ajax({
                url:'${baseurl}classify/delete.json',
                type:'POST',
                dataType:'json',
                data:{"id":id},
                success:function(resp){
                    if(resp.ret){
                        window.location.reload();//刷新
                    }
                }
            });
        });
    }
</script>
</body>
</html>

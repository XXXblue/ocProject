<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<fmt:setBundle basename="resources.messages" var="messagesBundle"/>
<c:set var="baseurl" value="${pageContext.request.contextPath}/"></c:set>
<link href="${baseurl}res/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${baseurl}res/css/reset.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${baseurl}res/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${baseurl}res/js/jquery.form.js"></script>
<script type="text/javascript" src="${baseurl}res/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${baseurl}res/js/oc.min.js"></script>
<script type="text/javascript" src="${baseurl}res/js/bootstrap-paginator.js"></script>

<!--[if lt IE 9]>
<script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<link rel="icon" type="image/png" href="${baseurl}res/i/ico.png" sizes="16x16">

<script type="text/javascript">
    function reloadIndityImg(eleId){
        document.getElementById(eleId).src = ${baseurl} + "/tools/identiry/code.json?ticket=" + Math.random();
    }

    $(function(){
        // 设置jQuery Ajax全局的参数
        $.ajaxSetup({
            type: "POST",
            complete:function(xhr,status){
//                if(xhr.responseJSON.errcode == 1001){//登录超时
//                    window.location.href=CONTEXT_PATH+"/auth/login.html";
//                }
            }
        });
    });
</script>

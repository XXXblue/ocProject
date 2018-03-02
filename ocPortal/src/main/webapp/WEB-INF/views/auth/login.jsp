<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/20
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="utf-8">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>在线网校学习平台</title>
    <%@ include file="/WEB-INF/views/common/res.jsp"%>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="f-main">
    <div class="types-block clearfix" style="text-align: center;">
        <h3 class="types-title">登录</h3>
        <form class="oc-form" id="infoForm" style="text-align: center;border: 1px solid #CCC;width: 600px;margin:0 auto;padding:20px;" method="post" action="${baseurl}auth/doLogin.json">
            <li><label>用户名</label>
                <input name="username"  value="" type="text"  class="input-text"  placeholder="请输入用户名" >
            </li>
            <li><label>密码</label>
                <input id="password" name="password" type="password" class="input-text" placeholder="请输入密码" autocomplete="off" />
            </li>
            <li><label>验证码</label>
                <input id="identiryCode" name="identiryCode" maxlength="6" class="input-text" type="text" style="width: 150px;" placeholder="请输入验证码"/>
                <a class="vali-base"><img  onclick="reloadIndityImg('indeityImgLogin');" id="indeityImgLogin"  src="${baseurl}tools/identiry/code.json" style="width:80px;height:40px;float:left;margin-left:10px;"/></a>
            </li>
            <li>
                <label style="background-color:#FFF;"></label>
                <input type="checkbox" value="1" id="checkbox1" name="rememberMe" style="float: left;">
                <span class="text"  style="float: left;margin-left:2px;">下次自动登录</span>
            </li>
            <li id="errorMsg" class="clearfix" style="display: none;color:red;">用户名密码不能为空</li>
            <li class="clearfix" style="margin-top: 20px;">
                <input type="button" value="登录" class="btn"style="margin-right:20px;" onclick="doSubmit();">
                <div class="btn" onclick="window.location.href='${baseurl}/auth/register.page'">注册</div>
            </li>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/foot.jsp" %>
<script>
    function doSubmit(){
        //提交登录
        $('#infoForm').ajaxSubmit({
            datatype : 'json',
            success : function(result) {
                if(!result.ret){
                    $('#errorMsg').show();
                    $('#errorMsg').html(result.msg);
                }else{
                    window.location.href="${baseurl}";
                    return;
                }
            },
            error : function(xhr) {

            }
        });
    }
</script>
</body>
</html>

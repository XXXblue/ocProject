<%--
  Created by IntelliJ IDEA.
  User: xiaojianyu
  Date: 2018/2/11
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
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
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div class="f-main">
        <div class="types-block clearfix" style="text-align: center;">
            <h3 class="types-title">注册</h3>
            <form id="registerForm" method="post" action="${baseurl}/auth/doRegister.json" class="oc-form"  style="text-align: center;border: 1px solid #CCC;width: 600px;margin:0 auto;padding:20px;" >
                <li><label>用户名</label>
                    <input maxlength="20" id="username" name="username"  type="text"  class="input-text"  placeholder="请输入用户名（英文数字）" >
                </li>
                <li><label>密码</label>
                    <input maxlength="20" id="password" name="password" type="password" class="input-text" placeholder="请输入密码" autocomplete="off" />
                </li>
                <li><label>验证码</label>
                    <input id="identiryCode" name="identiryCode" maxlength="6" class="input-text" type="text" style="width: 150px;" placeholder="请输入验证码"/>
                    <a class="vali-base"><img  onclick="reloadIndityImg('indeityImgRegister');" id="indeityImgRegister"  src="${baseurl}/tools/identiry/code.json" style="width:80px;height:40px;float:left;margin-left:10px;"/></a>
                </li>
                <li id="errorMsg" class="clearfix" style="display: none;color:red;">用户名密码不能为空</li>
                <li class="clearfix" style="margin-top: 30px;">
                    <input type="button" value="注册保存" class="btn" onclick="doSubmit();">
                </li>
                <li>
                    <a style="float: left;" href="${baseurl}/auth/login.page">已有账号，去登录</a>
                </li>
            </form>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/common/foot.jsp"%>
</body>
<script type="text/javascript">

    function doSubmit(){
        var username = $('#username').val();
        var password = $('#password').val();

        //下面这部分是前端校验
        //验证用户名
        if(!oc.enNumValid(username)){
            $('#errorMsg').show();
            $('#errorMsg').html("用户名只能为英文或数字");
            return;
        }

        //验证密码
        if(oc.isEmpty(password) || password.length < 6){
            $('#errorMsg').show();
            $('#errorMsg').html("密码至少6位");
            return;
        }

        //验证码不能为空
        var code = $('#identiryCode').val();
        if(oc.isEmpty(code)){
            $('#errorMsg').show();
            $('#errorMsg').html("请输入验证码");
            return;
        }

        //后面这部分是后端校验
        //提交注册
        $('#registerForm').ajaxSubmit({
            datatype : 'json',
            success : function(result) {
                if(!result.ret){
                    $('#errorMsg').show();
                    $('#errorMsg').html(result.msg);
                }else{
                    $('#errorMsg').show();
                    $('#errorMsg').html("注册成功！3s后跳转到登陆页！");
                    setTimeout(function(){
                        window.location.href="${baseurl}/auth/login.page";
                    },3000)
                }
            },
            error : function(xhr) {

            }
        });

    }


</script>
</html>


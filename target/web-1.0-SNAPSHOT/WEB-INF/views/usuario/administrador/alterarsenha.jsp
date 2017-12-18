<%-- 
    Document   : alterarsenha1
    Created on : 07/09/2016, 13:46:47
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Alterar Senha</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">    
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/ghpages-materialize.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/alterar-senha-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->        

        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>

        <script src="<c:url value="/resources/js/validate-senha.js"/>"></script>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-administrador.jsp"/>

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m6 l6 links">
                    <a href="<c:url value="/administrador/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="#!" class="breadcrumb link-ativo">Alterar Senha</a>
                </div>       
            </div>
            <div class="linha"></div>

            <div class="row container">
                <form class="col s12 formulario" method="post">
                    <div class="card-title">                        
                        <h5 class="titulo">Altere a sua senha</h5>
                        <div class="form divider"></div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <input id="senhaatual" name="senhaatual" type="password" class="" required=""/>
                            <label for="senhaatual">Senha Atual</label>
                        </div>
                        <div class="col s12 m6 l6" style="margin-top: 15px;">
                            <c:if test="${not empty validSenha.senha}">
                                <h6 class="red-text" style="margin-top: 15px;"><strong>${validSenha.senha}</strong></h6>
                                    </c:if>                                
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <input id="novasenha" name="novasenha" type="password" class="" required=""/>
                            <label for="novasenha">Nova Senha</label>
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <input id="confirmarSenha" name="confirmarSenha" type="password" class="" required="" onblur="validarSenha()"/>
                            <label for="confirmarSenha">Confirmar Nova Senha</label>
                        </div>
                    </div>
                    <div class="row">
                        <!--<input type="submit" class="waves-effect waves-light btn right col s12 m4 l2" value="Salvar" />&nbsp;-->
                        <a class="waves-effect waves-light btn grey darken-3 btn-cancelar btn-large right col s12 m4 l2" href="<c:url value="/anunciante/home"/>">Cancelar</a>
                        <button id="btn-salvar" class="waves-effect waves-light btn blue right btn-large col s12 m4 l2" style="margin-right: 0.6rem;">Salvar</button>
                    </div>
                </form>
            </div>

        </header>
    </body>
</html>

<%-- 
    Document   : novo-anunciante
    Created on : 20/05/2016, 14:24:13
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="anuncianteApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Novo Cadastro de Anunciante</title>

        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/anunciante/cadastro-anunciante.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/loginMobile-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <script src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script src="<c:url value="/resources/js/jquery.maskedinput.min.js"/>"></script>
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>      

    </head>

    <body>
        <!-- NAVBAR -->
        <div class="navbar-fixed">
            <nav class="grey darken-3" id="navbarTop">
                <div class="nav-wrapper container">                   
                </div>
            </nav>
        </div>
        <!-- FIM NAVBAR-->    

        <div class="row container logiMobile">            
            <div class="card-title center">
                <h5>LOGIN</h5>
                <div class="form divider"></div>
            </div>
            <form style="overflow-x: hidden;" method="post" id="formLogin" name="formLogin">
                <div class="row">
                    <div class="input-field col s12 m12 l12">
                        <i class="material-icons prefix">email</i>
                        <input id="email" type="email" class="validate" name="email" id="email">
                        <label for="email">E-mail</label>
                    </div>
                    <div class="input-field col s12 m12 l12">
                        <i class="material-icons prefix">vpn_key</i>
                        <input id="senha" type="password" class="validate" name="senha" id="senha">
                        <label for="senha">Senha</label>
                    </div>

                    <div class="input-field col s5">
                        <script>
                            var variaveis = location.search.split("?");
                            var quebra = variaveis[1].split("=");
                            if (quebra[1] == "1") {
                                document.writeln("<b style='color:red'>Usuário ou senha inválidos.</b>");
                            } else if (quebra[1] == "2") {
                                document.writeln("<b style='color:red'>Sua sessão expirou.</b>");
                            }
                        </script>
                    </div>
                </div>
                <div class="row center">                                
                    <button class="btn blue col s12 m6 push-l3 waves-effect waves-light" style="margin-right: 0.6rem; margin-bottom: 0.6rem;">Entrar</button>                                
                    <!--<input type="button" class="btn brown col s12 m6 push-l3 waves-effect waves-light modal-close" value="Voltar">-->
                    <a class="btn brown col s12 m6 push-l3 waves-effect waves-light" href="<c:url value="/"/>">Voltar</a>
                </div>
                <div class="row center">
                    <a href="<c:url value="/anunciantes/novo"/>">Registrar</a>
                    <span>||</span>
                    <a href="<c:url value="#modalRecuperarSenha"></c:url>" class="modal-trigger">Esqueceu a senha?</a>
                    </div>
                </form>               
            </div>


            <!--Import jQuery before materialize.js-->
            <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>                
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>
    </body>
</html>

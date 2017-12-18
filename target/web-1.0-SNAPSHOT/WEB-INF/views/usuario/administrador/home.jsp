<%-- 
    Document   : menu
    Created on : 20/05/2016, 14:24:13
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Home</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/ghpages-materialize.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">
        
        <link href="<c:url value="/resources/css/modulo-administrador/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <link href="<c:url value="/resources/css/modulo-administrador/home-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>
    </head>

    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-administrador.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/administrador/home"/>" class="breadcrumb link-ativo">Home</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>


            <h5 class="title-info container">Algumas informações do sistema</h5>
            <div class="row">
                <div class="card-content">
                    <table class="striped tabela">                                            
                        <tr>
                            <td><b>Itens publicados: </b>${itemPublicado}</td>                                                    
                        </tr> 
                        <tr>
                            <td><b>Itens aguardando avaliação: </b><c:if test="${not empty itemAvaliacao}">${itemAvaliacao}</c:if><c:if test="${empty itemAvaliacao}">Nenhum no momento</c:if></td>
                        </tr>
                        <tr>
                            <td><b>Quantidade de administradores: </b>${countAdmin}</td>
                        </tr> 
                        <tr>
                            <td><b>Veja mais estatísticas clicando <a href="<c:url value="/administrador/estatisticas-sistema"/>">aqui!</b></a></td>
                        </tr>
                        <tr>
                            <td><b>Tenha um bom trabalho!</b></td>
                        </tr>
                    </table>
                </div>
            </div>                  
        </header>
    </body>
</html>
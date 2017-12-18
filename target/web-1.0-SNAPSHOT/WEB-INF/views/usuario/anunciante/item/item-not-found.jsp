<%-- 
    Document   : item-not-found
    Created on : 23/09/2016, 10:33:23
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Ops!</title>
       <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/item-not-found-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
    </head>
    <body>        
        <header>            
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                                                  
                    <a href="#!" class="breadcrumb link-ativo">Erro!</a>
                </div>                                        
            </div>
            <div class="linha"></div>
            
            <div class="container">
                <h5>Algo de errado aconteceu!</h5>
                
                <h6>Possíveis motivos:</h6>
                <ul>
                    <li style="list-style: disc">O item que você está procurando não está cadastrado no sistema.</li>
                    <li style="list-style: disc">Você não tem permissão para acessar esta área.</li>
                </ul>
                
                <h6>Pedimos desculpas pelo acontecido!</h6>
            </div>
        </header>
    </body>
</html>

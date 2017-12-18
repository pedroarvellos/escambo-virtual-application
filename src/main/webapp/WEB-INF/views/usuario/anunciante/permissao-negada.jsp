<%-- 
    Document   : permissao-negada
    Created on : 20/09/2016, 11:32:11
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Permissão Negada</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l12 m12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                          
                    <a href="#!" class="breadcrumb link-ativo">Erro</a>
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container row">
                <div class="card-panel">
                    <div class="card-content">
                        <div class="card-title center" style="text-transform: uppercase;"><strong>Você não possui permissão para acessar esta área!</strong></div>
                        <div class="divider"></div>
                        <br/>
                        <div class="card-image responsive-img center"><img src="<c:url value="/resources/img/erros-e-descricoes1.png"/>"></div>
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>

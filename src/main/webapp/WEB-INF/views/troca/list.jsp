<%-- 
    Document   : list
    Created on : 14/10/2016, 11:19:34
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Trocas</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">

        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/ghpages-materialize.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/list-troca-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>        
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.maskedinput.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l12 m12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-ativo">Trocas Realizadas</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container ">  
                <c:if test="${empty trocaList}">
                    <div lista row>
                        <h5>Você ainda não realizou nenhuma troca!</h5>
                        <h6>Continue cadastrando itens e realizando oferta à outros itens que logo você verá resultados =)</h6>
                    </div>
                </c:if>
                <c:if test="${not empty trocaList}">
                    <c:forEach items="${trocaList}" var="troca">
                        <div class="lista row">                            
                            <c:if test="${troca.usuario1.id != anunciante.id}"><h5>Troca Realizada entre você e o anunciante <span>${troca.usuario1.nome}</span></h5></c:if>                            
                            <c:if test="${troca.usuario2.id != anunciante.id}"><h5>Troca Realizada entre você e o anunciante <span>${troca.usuario2.nome}</span></h5></c:if>                            
                            <h6>No dia ${troca.data_hora}</h6>
                            <div class="row">
                                <a class="btn btn-large blue right" href="<c:url value="/anunciante/troca/${troca.oferta.id}"/>">+ detalhes</a>
                            </div>
                        </div>
                    </c:forEach>                    
                </c:if>
            </div>
        </header>      
    </body>
</html>

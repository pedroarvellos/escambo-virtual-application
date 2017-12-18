<%-- 
    Document   : list
    Created on : 14/10/2016, 09:28:59
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Conversas</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/mensagem-list-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
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
                    <a href="#!" class="breadcrumb link-ativo">Conversas</a>
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container"> 
                <c:if test="${empty mensagemList}">
                    <h5 class="card-title center" style="font-weight: 700;">Você ainda não possui nenhum chat iniciado.</h5>
                </c:if>
                <c:if test="${not empty mensagemList}">
                    <ul>
                        <c:forEach items="${mensagemList}" var="mensagem">
                            <a href="<c:url value="/anunciante/mensagem/${mensagem.id}"/>"  class="black-text hoverable painelAnuncios">
                                <li>
                                    <div class="col s12 m12 z-depth-1 painelAnuncios hoverable" style="margin-bottom: 2%;">
                                        <!--<div class="card small">-->                                       
                                        <div class="row">                                               
                                            <div class="card-image col s12 m4 l4">
                                                <c:if test="${empty mensagem.item.itemImagemList}">
                                                    <img src="<c:url value="/resources/img/sem-imagem.jpg"></c:url>" class="responsive-img" style="padding-top: 8%;">                                                        
                                                </c:if>
                                                <c:if test="${not empty mensagem.item.itemImagemList}">                                                            
                                                    <c:forEach items="${mensagem.item.itemImagemList}" var="itemImagem">                                                            
                                                        <img class="responsive-img" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" height="200" width="200" style="padding-top: 9%;">                                                                                                   
                                                    </c:forEach>                                                            
                                                </c:if>
                                            </div>
                                            <div class="card-content">
                                                <h5>Item: ${mensagem.item.nome}</h5>
                                                <h6>${mensagem.remetente.nome}: ${mensagem.texto}</h6>                                            
                                            </div> 
                                        </div>
                                        <!--</div>-->
                                    </div>
                                </li>
                            </a>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </header>
    </body>
</html>

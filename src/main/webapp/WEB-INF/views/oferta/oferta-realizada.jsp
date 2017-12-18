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
        <title>Ver Oferta Realizada</title>
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
                    <a href="<c:url value="/anunciante/pesquisar/item"/>" class="breadcrumb link-anterior">Pesquisa</a>
                    <a href="<c:url value="#!"/>" class="breadcrumb link-anterior">Ver Item</a>        
                    <a href="#!" class="breadcrumb link-ativo">Ver Oferta Sobre Item</a>
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container">
                <div class="card-content">
                    <div class="card-title white-text"><strong style="text-transform: uppercase;">Número de ofertas realizadas sobre este item: ${count}</strong></div>                        
                    <c:forEach items="${ofertaList}" var="oferta">
                        <div class="card-panel">
                            <div class="card-panel">
                                <div class="card-title center"><strong style="text-transform: uppercase;">Oferta realizada sobre o item "${oferta.item.nome}", do anunciante "${oferta.item.anunciante.nome}"</strong></div>
                            </div>
                            <!--<div class="card-panel">-->
                            <!--<div class="card-content">-->
                            <div class="row">
                                <br/>
                                <div class="card-title center"><strong style="text-transform: uppercase; text-decoration: underline;">Os itens que você incluiu nesta oferta foram:</strong></div>   
                                <br/>
                                <c:forEach items="${oferta.ofertaItem.itemList}" var="item">
                                    <div class="card small col s12 m6 l6">
                                        <div class="card-image waves-effect waves-block waves-light">
                                            <img class="activator" src="<c:url value="/resources/img/background3.jpg"/>">
                                        </div>
                                        <div class="card-content">
                                            <span class="card-title activator grey-text text-darken-4">${item.nome}</span>
                                            <br/>
                                            <span class="center-align">Clique sobre a imagem para ver informações</span>
                                        </div>
                                        <div class="card-reveal">
                                            <span class="card-title grey-text text-darken-4">Informações<i class="material-icons right">close</i></span>
                                            <p>${item.descricao}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!--</div>-->
                            <!--</div>-->
                        </div>
                    </c:forEach>
                </div>
            </div>
        </header>
    </body>
</html>

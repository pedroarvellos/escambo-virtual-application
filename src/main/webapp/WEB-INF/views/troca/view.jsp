<%-- 
    Document   : view
    Created on : 16/10/2016, 17:52:21
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Detalhes da troca</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/troca-view-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

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
                    <a href="<c:url value="/anunciante/troca/list"/>" class="breadcrumb link-anterior">Trocas</a>                                              
                    <a href="<c:url value="#!"/>" class="breadcrumb link-ativo">Detalhes</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container">
                <div class="conteudo">
                    <div class="titulo center">
                        <c:if test="${troca.usuario1.id != anunciante.id}"><h5>Troca realizada com <span>${troca.usuario1.nome}</span></h5></c:if>                            
                        <c:if test="${troca.usuario2.id != anunciante.id}"><h5>Troca realizada com <span>${troca.usuario2.nome}</span></h5></c:if>                            
                            <div class="divider"></div>
                        </div>
                        <div class="row">
                            <h5 class="data">Data de realização: ${troca.data_hora}</h5>

                        <c:if test="${troca.oferta.item.anunciante.id eq anunciante.id}">
                            <h5 class="tituloLista">Você trocou os seu item</h5>
                            <ul>
                                <li style="list-style: disc; margin-left: 3%;"><h5 class="itemOferta">${troca.oferta.item.nome}</h5></li>
                            </ul>
                            <h5 class="tituloLista">Pelos itens</h5>
                            <ul>
                                <c:forEach items="${troca.oferta.ofertaItem.itemList}" var="item">
                                    <li style="list-style: disc; margin-left: 3%;"><h5 class="itemOferta">${item.nome}</h5></li>
                                    </c:forEach>
                            </ul>
                        </c:if>

                        <c:if test="${troca.oferta.item.anunciante.id != anunciante.id}">
                            <h5 class="tituloLista">Você trocou os seus itens</h5>
                            <ul>
                                <c:forEach items="${troca.oferta.ofertaItem.itemList}" var="item">
                                    <li style="list-style: disc; margin-left: 3%;"><h5 class="itemOferta"><a href="/anunciante/troca/${troca.id}/view/item/${item.id}">${item.nome}</a></h5></li>
                                        </c:forEach>
                            </ul>
                            <h5 class="tituloLista">Pelo item </h5>
                            <ul>
                                <li style="list-style: disc; margin-left: 3%;"><h5 class="itemOferta"><a href="/anunciante/troca/${troca.id}/view/item/${troca.oferta.item.id}">${troca.oferta.item.nome}</a></h5></li>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>

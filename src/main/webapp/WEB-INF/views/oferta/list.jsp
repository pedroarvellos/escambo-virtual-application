<%-- 
    Document   : list
    Created on : 21/09/2016, 14:47:17
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Ofertas Recebidas</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/oferta-list-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m12 l12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="#!" class="breadcrumb link-ativo">Ofertas Recebidas</a>
                </div>       
            </div>
            <div class="linha"></div>               

            <div class="container ofertas">            
                <c:if test="${empty ofertaList}">
                    <div class="card-title center"><strong style="text-transform: uppercase;">Não existem ofertas encaminhadas para seus itens! =(</strong></div>                        
                </c:if>
                <c:if test="${not empty ofertaList}">                                            
                    <h5>Você recebeu as seguintes ofertas:</h5>                    
                    <br/>
                    <c:forEach items="${ofertaList}" var="oferta"> 
                        <div class="oferta">
                            <a href="<c:url value="/anunciante/oferta/${oferta.id}/view"></c:url>" class="black-text hoverable">
                                    <div class="row">                                               
                                        <div class="col s12 m12 z-depth-1 hoverable">                                                                   
                                            <div class="card-image col s12 m4 l4">

                                            <c:if test="${empty oferta.item.itemImagemList}">
                                                <img src="<c:url value="/resources/img/sem-imagem.jpg"></c:url>" class="responsive-img" style="padding-top: 8%;">                                                        
                                            </c:if>
                                            <c:if test="${not empty oferta.item.itemImagemList}">                                                            
                                                <c:forEach items="${oferta.item.itemImagemList}" var="itemImagem">                                                            
                                                    <img class="responsive-img" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" height="200" width="200" style="padding-top: 7%;padding-bottom: 5%;">                                                                                                   
                                                </c:forEach>                                                            
                                            </c:if>
                                        </div>
                                        <div class="card-content">
                                            <br/>
                                            <span id="teste" style="padding-top: 5%;" class="nome">Para o item ${oferta.item.nome}</span>                                                                                                
                                            <div class="divider"></div>                                            
                                            <br/>
                                            <span class="">Clique para ver mais detalhes</span>                                            
                                        </div> 
                                    </div>                                
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
            </div>                                                        
        </header>        
    </body>
</html>

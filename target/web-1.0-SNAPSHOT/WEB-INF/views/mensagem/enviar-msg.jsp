<%-- 
Document   : enviar-msg
Created on : 15/09/2016, 13:55:08
Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Enviar Mensagem</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/mensagem-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js--><!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>                       

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l12 m12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="/anunciante/pesquisar/item"/>" class="breadcrumb link-anterior">Pesquisar</a>                                              
                    <a href="<c:url value="/anunciante/pesquisar/item/${item.id}/view"/>" class="breadcrumb link-anterior">Ver Item</a>
                    <a href="#!" class="breadcrumb link-ativo">Enviar Mensagem</a>
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container envio">
                <div class="card-content">
                    <div class="card-content">
                        <div class="card-panel">
                            <div class="card-content">
                                <div class="card-title"><h6 class="center-align"><strong>Enviar mensagem ao anunciante deste item</strong></h6></div>
                            </div>
                        </div>
                        <div class="row">
                            <br/>
                            <h6 class="left-align" style="text-transform: uppercase;"><strong>Item:</strong> ${item.nome}</h6>
                            <h6 class="left-align" style="text-transform: uppercase;"><strong>Anunciante:</strong> ${item.anunciante.nome}</h6>
                            <br/>                            
                            <div class="row">
                                <form class="col s12" method="post">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <textarea id="texto" name="texto" class="materialize-textarea texto" placeholder="Digite a mensagem aqui"></textarea>                                            
                                        </div>
                                    </div>
                                    <!--<div class="row">-->
                                    <a class="waves-effect waves-light btn grey darken-3 right btn-large" href="<c:url value="/anunciante/pesquisar/item/${item.id}/view"/>">Cancelar</a>
                                    <button type="submit" class="waves-effect waves-light btn-large btn blue right" style="margin-right: 0.6rem;">Enviar</button>

                                    <!--</div>-->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>

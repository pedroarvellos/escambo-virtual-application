<%-- 
    Document   : form-oferta
    Created on : 16/09/2016, 09:44:43
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="ofertaApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Realizar Oferta</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>
        
        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/form-oferta-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>

        <script src="<c:url value="/resources/js/angular.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/oferta/app/oferta-app.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/oferta/controllers/oferta-controller.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/oferta/services/oferta-service.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/oferta/values/oferta-value.js"/>"></script>

        <script>
            $(document).ready(function () {
                $('.carousel').carousel();
            });

            $(document).ready(function () {
                // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
                $('.modal-trigger').leanModal();
            });
        </script>        
    </head>
    <body ng-controller="OfertaController" ng-init="itens(${anunciante.id})">
        <header>

            <!--MODAL OFERTA-->
            <div id="modalOferta" class="modal">
                <div class="modal-content">
                    <h4>Enviar Oferta</h4>
                    <p><strong>Você confirma o envio de uma oferta para o item em questão?</strong></p>
                    <p>Após o envio desta oferta, o anunciante responsável por este item poderá aceitar a sua oferta e assim realizar a troca dos itens.</p>
                    <p>Obs.: esta ação não poderá ser desfeita</p>
                    <button class="btn blue waves-effect modal-close btn-large" ng-click="createOferta(${itemReceptor.id})">Confirmar</button>
                    <a class="btn grey darken-3 waves-effect modal-close btn-large">Cancelar</a>
                </div>
            </div>
            <!--FIM MODAL-->
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>               

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m12 l12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="<c:url value="/anunciante/pesquisar/item"/>" class="breadcrumb link-anterior">Pesquisar</a>
                    <a href="<c:url value="/anunciante/pesquisar/item/${itemReceptor.id}/view"/>" class="breadcrumb link-anterior">Ver Item</a>
                    <a href="#!" class="breadcrumb link-ativo">Fazer Oferta</a>
                </div>       
            </div>
            <div class="linha"></div>



            <div class="container">
                <div class="info-title">
                    <h6 class="">Fazer oferta ao item: <span>${itemReceptor.nome}</span></h6>
                    <h6 class="" >Pertencente ao anunciante: <span>${itemReceptor.anunciante.nome}</span></h6>
                </div>

                <div class="row">
                    <form name="formOferta" class=" formulario">
                        <h6>Selecione os seus itens que deseja ofertar</h6>
                        <br/>
                        <select class="browser-default" style="border-color: grey;" ng-model="item.id" ng-change="addItem(item)">
                            <option value="">Selecione</option>
                            <option ng-repeat="item in itens" value="{{item.id}}">{{item.nome}}</option>
                        </select>

                        <div class="row">
                            <div ng-repeat="item in itensOferta" ng-model="ofertaItem.itemList">                                                
                                <!--aqui vai aparecer os itens selecionados-->
                                <div class="card small col s12 m4 l4">                                                
                                    <i class="material-icons" ng-click="removeItemOferta(item.id)">close</i>
                                    <div class="card-image waves-effect waves-block waves-light">                                                    
                                        <img ng-repeat="itemImagem in item.itemImagemList" class="activator" src="<c:url value="/anunciante/item/img/{{itemImagem.hash}}"/>">                                                    
                                    </div>                                                
                                    <div class="card-content">
                                        <span class="card-title activator grey-text text-darken-4">{{item.nome}}</span>
                                        <br/>
                                        <span class="center-align" style="margin-bottom: 5%;">Clique para ver informações</span>
                                    </div>
                                    <div class="card-reveal">
                                        <span class="card-title grey-text text-darken-4">Informações<i class="material-icons right">close</i></span>
                                        <p>{{item.descricao}}</p>
                                    </div>
                                </div>
                            </div>
                        </div>                                   
                        <a class="btn blue modal-trigger btn-large waves-effect" href="#modalOferta">Enviar oferta</a>
                        <a class="btn grey darken-3 btn-large waves-effect" href="<c:url value="/anunciante/pesquisar/item/${itemReceptor.id}/view"/>">cancelar</a>
                    </form>
                </div>
            </div>
        </header>
    </body>
</html>

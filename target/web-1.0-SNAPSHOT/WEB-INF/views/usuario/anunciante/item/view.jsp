<%-- 
    Document   : view
    Created on : 07/09/2016, 18:25:53
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Visualização de Item</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>
        
        <link href="<c:url value="/resources/slider/css/style-slider.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/item-view-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>

        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.mini.js"/>"></script>
        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.min.js"/>"></script>

        <script src="<c:url value="/resources/slider/js/js-slider.js"/>"></script>

        <script>
            $(document).ready(function () {
                $('.carousel').carousel();
            });
        </script>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="/anunciante/pesquisar/item"/>" class="breadcrumb link-anterior">Pesquisar</a>                                              
                    <a href="#!" class="breadcrumb link-ativo">Ver Item</a>
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="container item">
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <div class="col s12 m12 l12" style="margin-top: -2%;">

                                    <table class="bordered">
                                        <tr>                                               
                                            <td colspan="2">
                                                <div class="card-title">                        
                                                    <h5>${item.nome}</h5>                                                
                                                </div>
                                            </td>                                        
                                        </tr>                                    
                                        <tr>                                        
                                            <td colspan="4">                                            
                                                <c:if test="${empty item.itemImagemList}">
                                                    <img class="card-panel z-depth-2" src="<c:url value="/resources/img/sem-imagem.jpg"/>" height="200" width="200">
                                                </c:if>

                                                <c:if test="${not empty item.itemImagemList}">
                                                    <!--SLIDER-->
                                                    <div id="jssor_1" style="position: relative; margin: 0 auto; top: 0px; left: 0px; width: 600px; height: 400px; overflow: hidden; visibility: hidden;">
                                                        <!-- Loading Screen -->
                                                        <div data-u="loading" style="position: absolute; top: 0px; left: 0px;">
                                                            <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;"></div>
                                                            <div style="position:absolute;display:block;background:url('<c:url value="/resources/img/loading.gif"/>') no-repeat center center;top:0px;left:0px;width:100%;height:100%;"></div>
                                                        </div>
                                                        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 600px; height: 400px; overflow: hidden;">

                                                            <c:forEach items="${item.itemImagemList}" var="itemImagem">
                                                                <div data-p="112.50" style="display: none;">
                                                                    <img data-u="image" class="responsive-img" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" />
                                                                    <img data-u="thumb" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" />
                                                                </div>
                                                            </c:forEach>

                                                            <!-- Thumbnail Navigator -->
                                                            <div u="thumbnavigator" class="jssort03" style="position:absolute;left:0px;bottom:0px;width:600px;height:60px;" data-autocenter="1">
                                                                <div style="position: absolute; top: 0; left: 0; width: 100%; height:100%; background-color: #000; filter:alpha(opacity=30.0); opacity:0.3;"></div>
                                                                <!-- Thumbnail Item Skin Begin -->
                                                                <div u="slides" style="cursor: default;">
                                                                    <div u="prototype" class="p">
                                                                        <div class="w">
                                                                            <div u="thumbnailtemplate" class="t"></div>
                                                                        </div>
                                                                        <div class="c"></div>
                                                                    </div>
                                                                </div>
                                                                <!-- Thumbnail Item Skin End -->
                                                            </div>
                                                            <!-- Arrow Navigator -->
                                                            <span data-u="arrowleft" class="jssora02l" style="top:150px;left:8px;width:55px;height:55px;" data-autocenter="2"></span>
                                                            <span data-u="arrowright" class="jssora02r" style="top:150px;right:8px;width:55px;height:55px;" data-autocenter="2"></span>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>                                            
                                            <td><b>Anunciante: &nbsp;</b>${item.anunciante.nome}</td>
                                            <td><b>Interesse 1: &nbsp;</b>${item.interesse1}</td>
                                        </tr>
                                        <tr>
                                            <td><b>Data de Aquisição: &nbsp;</b>${item.dataAquisicao}</td>
                                            <td><b>Interesse 2: &nbsp;</b>${item.interesse2}</td>
                                        </tr>
                                        <tr>
                                            <td><b>Data de Publicação: &nbsp;</b>${item.dataCadastro}</td>
                                            <td><b>Interesse 3: &nbsp;</b>${item.interesse3}</td>
                                        </tr>
                                        <tr>
                                            <td><b>Telefone do Anunciante: </b>${item.anunciante.telefone}</td>
                                            <td><b>Localização do Item: </b>${item.cidade.nome} - ${item.cidade.estado.uf}</td>
                                        </tr>
                                        <tr>
                                            <td><b>Descrição: </b><p>${item.descricao}</p></td>
                                            <!--<td>${item.descricao}</td>--> 
                                        </tr>
                                        <c:if test="${fezOferta == true}">
                                            <tr>
                                                <td><strong>*Você realizou ofertas neste item!</strong><a href="<c:url value="/anunciante/view/oferta/item/${item.id}"/>"> Clique aqui para ver</a></td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td class="right-align" colspan="4">
                                                <a class="waves-effect waves-light btn blue col s12 m5 l5 btn-large" href="<c:url value="/anunciante/mensagem/item/${item.id}"/>">Enviar mensagem ao anunciante</a>                                        
                                                <a class="waves-effect waves-light btn grey darken-3 col s12 m5 l5 btn-large" href="<c:url value="/anunciante/item/${item.id}/ofertar"/>" style="margin-left: 0.6rem;">Fazer oferta por este item</a>
                                            </td>                                            
                                        </tr>                                        
                                    </table>

                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>  
            </div>
        </header>

    </body>
</html>

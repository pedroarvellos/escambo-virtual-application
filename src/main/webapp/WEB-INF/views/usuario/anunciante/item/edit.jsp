<%-- 
    Document   : edit
    Created on : 07/09/2016, 14:12:58
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/item-edit-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/slider/css/style-slider.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>


        <script src="<c:url value="/resources/js/jquery.maskedinput.min.js"/>"></script>
        <script src="<c:url value="/resources/js/mask-cadastro.js"/>"></script>

        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.mini.js"/>"></script>
        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.min.js"/>"></script>

        <script src="<c:url value="/resources/slider/js/js-slider.js"/>"></script>

        <!--SCRIPTS-->
        <script>
            $(document).ready(function () {
                $('.carousel').carousel();
            });
        </script>

    </head>
    <body class="body">
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m12 l12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="<c:url value="/anunciante/item"/>" class="breadcrumb link-anterior">Meus Itens</a>
                    <a href="#!" class="breadcrumb link-ativo">Editar</a>
                </div>       
            </div>
            <div class="linha"></div>

            <div class="row container">
                <div class="card-title">                        
                    <h5>Edição de Item</h5>                        
                </div>
                <c:if test="${item.status != 'Trocado'}">
                    <form method="post" class=" col s12 m12 l12">
                        <div class="item">
                            <div class="imagens">
                                <c:if test="${empty item.itemImagemList}">
                                    <img class="card-panel center" src="<c:url value="/resources/img/sem-imagem.jpg"/>" height="200" width="200">
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
                                                    <img data-u="image" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" />
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
                            </div>
                            <div class="row">
                                <div class="input-field col s8">
                                    <input id="nome" name="nome" type="text" class="validate" value="${item.nome}"/>
                                    <label for="nome">Nome</label>
                                </div>
                                <div class="input-field col s4">
                                    <input id="dataAquisicao" name="dataAquisicao" type="text" class="validate" value="${item.dataAquisicao}" onkeypress="mascaraData(this, '##/##/####')" maxlength="10"/>
                                    <label for="dataAquisicao">Data de aquisição</label>
                                </div>                          
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <textarea id="textarea1" class="materialize-textarea" name="descricao" length="1400">${item.descricao}</textarea>
                                    <label for="textarea1">Descrição</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s4">
                                    <input id="interesse1" name="interesse1" type="text" value="${item.interesse1}" class="validate"/>
                                    <label for="interesse1">Interesse 1</label>
                                </div>    
                                <div class="input-field col s4">
                                    <input id="interesse2" name="interesse2" type="text" value="${item.interesse2}" class="validate" />
                                    <label for="interesse2">Interesse 2</label>
                                </div>
                                <div class="input-field col s4">
                                    <input id="interesse3" name="interesse3" type="text" value="${item.interesse3}" class="validate"/>
                                    <label for="interesse3">Interesse 3</label>
                                </div>                         
                            </div>
                            <div class="linha"></div>
                            <h5 style="font-weight: 700;">Substitua as imagens se necessário</h5>
                            <table>
                                <tr>
                                    <th class="center-align green lighten-3 z-depth-2">Principal</th>
                                    <th class="center-align green lighten-5">imagem 1</th>
                                    <th class="center-align green lighten-5">imagem 2</th>
                                    <th class="center-align green lighten-5">imagem 3</th>
                                    <th class="center-align green lighten-5">imagem 4</th>
                                </tr>
                                <tr>                            
                                    <td>
                                        <img class="card-panel col s12 z-depth-2 responsive-img" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                    </td>
                                    <td>
                                        <img class="card-panel col s12 responsive-img" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                    </td>
                                    <td>
                                        <img class="card-panel col s12 responsive-img" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                    </td>
                                    <td>
                                        <img class="card-panel col s12 responsive-img" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                    </td>
                                    <td>
                                        <img class="card-panel col s12 responsive-img" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                    </td>
                                </tr>
                            </table>
                            <div class="row">
                                <!--                        <div class="file-field input-field">
                                                            <div class="btn">
                                                                <span>Adicionar imagens</span>
                                                                <input type="file" multiple>
                                                            </div>
                                                            <div class="file-path-wrapper">
                                                                <input class="file-path validate" type="text" placeholder="Upload one or more files">
                                                            </div>
                                                        </div>-->
                            </div>

                            <div class="row">            
                                <a class="waves-effect waves-light btn right grey darken-3 btn-large" href="<c:url value="/anunciante/item"/>">Cancelar</a>
                                <button class="waves-effect waves-light btn blue right btn-large" style="margin-right: 0.6rem;">Salvar</button>
                            </div> 
                        </div>
                    </form>
                </c:if>
                <c:if test="${item.status == 'Trocado'}">
                    <h5>Desculpe, mas este item já foi trocado, por este motivo não é possível realizar modificações.</h5>
                </c:if>
            </div>
        </header>
    </body>
</html>

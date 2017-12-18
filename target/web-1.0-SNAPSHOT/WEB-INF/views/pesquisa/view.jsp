<%-- 
    Document   : view
    Created on : 09/09/2016, 17:28:46
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Escambo Virtual</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/styleIndex.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/slider/css/style-slider.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>

        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.mini.js"/>"></script>
        <script src="<c:url value="/resources/js/jssor.slider-21.1.6.min.js"/>"></script>

        <script src="<c:url value="/resources/slider/js/js-slider.js"/>"></script>

        <script>
            $(document).ready(function () {
                // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
                $('.modal-trigger').leanModal();
            });
        </script>
        <script>
            $(document).ready(function () {
                $('.carousel').carousel();
            });
        </script>

    </head>
    <body class="bodyBackground">
        <jsp:include page="../usuario/login.jsp"></jsp:include>
            <!-- NAVBAR -->
            <div class="navbar-fixed">
                <nav id="navbarTop">
                    <div class="nav-wrapper">
                        <a href="<c:url value="/"/>" class="brand-logo"><img src="<c:url value="/resources/img/logo_escambovirtual.png"/>" height="50" width="150" style="margin-top: 7px; margin-left: 200px;"></a>
                    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons white-text">menu</i></a>
                    <ul class="right hide-on-med-and-down">                                                
                        <!--<li><i class="material-icons">perm_identity</i></li>-->
                        <li><img class="img-login" src="<c:url value="/resources/img/login.png"/>"></li>
                        <li><a class='modal-trigger btn btn-entrar white-text' href='#modalLogin' style="margin-right: 30px;">Entrar</a></li>                               
                    </ul>                                                
                    <ul class="side-nav" id="mobile-demo">
                        <li><a href="<c:url value="/usuario/login/mobile"/>">Entrar</a></li>                        
                    </ul>
                </div>
            </nav>
        </div>
        <!-- FIM NAVBAR-->

        <div class="container">
            <div class="card-panel">
                <div class="card-content">
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="card-panel col s12 m12 l12 z-depth-2">

                                        <table class="bordered">
                                            <tr>                                               
                                                <td colspan="2">
                                                    <div class="card-title">                        
                                                        <h5 class="black-text">${item.nome}</h5>                                                
                                                    </div>
                                                </td>                                        
                                            </tr>                                    
                                            <tr>
                                                <!--<td rowspan="4"><img class="card-panel z-depth-2" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200"></td>-->
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
                                                <td><b>Descrição: </b><p>${item.descricao}</p></td>
                                                <td></td>
                                            </tr>                                            
                                            <tr>
                                                <td>
                                                    <h6><strong>*Faça login no sistema para utilizar todas as funcionalidades.</strong></h6>
                                                </td>  
                                                <td></td>
                                            </tr>                                        
                                        </table>

                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>

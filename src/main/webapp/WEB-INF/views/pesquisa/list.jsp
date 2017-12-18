<%-- 
    Document   : list
    Created on : 30/08/2016, 14:41:05
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
        <link href="<c:url value="/resources/css/pesquisaOff.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/pesquisa-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>

        <script>
            $(document).ready(function () {
                // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
                $('.modal-trigger').leanModal();
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
            <div class="titulo">Procurando algo?</div>
            <div class="card-content">
                <form>                            
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input id="pesquisar" class="form-pesquisa col s6 m6 l6" name="nomeCriterium" type="text" value="${nomeCriterium}" placeholder="Pesquise"/>                            
                            <button type="submit" class="btn blue btn-large col s3 m3 l3" style="margin-top: 20px;">Pesquisar</button>
                        </div>   
                    </div>
                </form>
            </div>                

            <c:if test="${empty itemList}">                   
                <div class="card-title" style="padding-top: 15px;">
                    <span style="font-size: 16pt;"><i class="material-icons small">thumb_down</i>
                        <strong>Nenhum resultado encontrado para esta pesquisa!</strong></span>
                </div>                        
            </c:if>
            <div class="resultados">
                <h6><strong>Resultados encontrados:</strong> ${count}</h6>
                <ul>
                    <c:forEach var="item" items="${itemList}">
                        <a href="<c:url value="/item/${item.id}/view"></c:url>" class="black-text hoverable">
                                <li>
                                    <div class="col s12 m12 z-depth-1 painelAnuncios hoverable" style="margin-bottom: 2%;">
                                        <!--<div class="card small">-->                                       
                                        <div class="row">                                               
                                            <div class="card-image col s12 m4 l4">
                                            <c:if test="${empty item.itemImagemList}">
                                                <img src="<c:url value="/resources/img/sem-imagem.jpg"></c:url>" class="responsive-img" style="padding-top: 8%;">                                                        
                                            </c:if>
                                            <c:if test="${not empty item.itemImagemList}">                                                            
                                                <c:forEach items="${item.itemImagemList}" var="itemImagem">                                                            
                                                    <img class="responsive-img" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" height="200" width="200" style="padding-top: 9%;">                                                                                                   
                                                </c:forEach>                                                            
                                            </c:if>
                                        </div>
                                        <div class="card-content">
                                            <!--<span style="font-size: 15pt;"><strong>${item.nome}</strong></span>--> 
                                            <h5 class="item-nome" style="padding-top: 2%;">${item.nome}</h5>
                                            <span class="right item-cadastro">${item.dataCadastro}</span>
                                            <br/>
                                            <div class="divider" style="width: 500px;"></div>
                                            <br/>
                                            <span class="descricao"><strong>Descrição:</strong></span>
                                            <p class="descricao">${item.descricao}</p>
                                        </div> 
                                    </div>
                                    <!--</div>-->
                                </div>
                            </li>
                        </a>
                    </c:forEach>
                </ul>
                <c:if test="${count > 0}">
                    <ul class="pagination center">
                        <c:if test="${offset > 0}">
                            <li class="waves-effect"><a href="<c:url value="/item/search?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset - limit}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                            </c:if>

                        <c:if test="${offset <= 0}">
                            <li class="waves-effect"><a href="<c:url value="/item/search?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                            </c:if>


                        <c:if test="${(offset + limit) < count}">
                            <li class="waves-effect"><a href="<c:url value="/item/search?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset + limit}"/>"><i class="material-icons">chevron_right</i></a></li>
                            </c:if>

                        <c:if test="${(offset + limit) >= count}">
                            <li class="waves-effect"><a href="<c:url value="/item/search?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_right</i></a></li>
                            </c:if>
                    </ul>
                </c:if>
            </div>  
        </div>


    </body>
</html>

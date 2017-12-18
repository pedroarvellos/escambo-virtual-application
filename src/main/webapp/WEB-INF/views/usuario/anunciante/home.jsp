<%-- 
    Document   : menu
    Created on : 20/05/2016, 14:24:13
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Home</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/home-anunciante.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.maskedinput.min.js"/>"></script>
        
    </head>

    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-ativo">Home</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>

            <c:if test="${countItem > 0}">
            <h5 class="title-info">Algumas informações da sua conta</h5>
                <div class="row" style="margin-top: -2%;">
                    <div class="informacoes">
                        <div class="card-content">
                            <table class="striped">                                 
                                <!--<tr><td></td></tr>-->
                                <tr>
                                    <td><b>Itens cadastrados: </b>${countItem}</td>                                                    
                                </tr> 
                                <tr>
                                    <td><b>Ofertas recebidas: </b><c:if test="${not empty countOferta}">${countOferta}</c:if><c:if test="${empty countOferta}">Nenhuma até o momento</c:if></td>
                                    </tr>
                                    <tr>
                                        <td><b>Trocas realizadas: </b><c:if test="${not empty countTrocas}">${countTrocas}</c:if><c:if test="${empty countTrocas}">Nenhuma até o momento</c:if></td>
                                    </tr>                                
                                </table>
                            </div>
                        </div>
                    </div>  
            </c:if>
            <c:if test="${countItem == 0}">
                <div class="row" style="margin-top: -2%;">
                    <div class="container welcome">
                        <div class="card-content">
                            <table class="bordered">
                                <tr>                                               
                                    <td colspan="2">
                                        <div class="card-title">                        
                                            <h5>Seja bem vindo(a)!</h5>                                                            
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td rowspan="4" class="img"><img class="img responsive-img" src="<c:url value="/resources/img/cadastrar.png"/>" height="250" width="250"></td>
                                </tr>
                                <tr>
                                    <td><b>Você ainda não possui itens cadastrados</b></td>                                                    
                                </tr> 
                                <tr>
                                    <td><b>Cadastre itens para utilizar nossas funcionalidades</b></td>
                                </tr>
                                <tr>
                                    <td><a href="<c:url value="/anunciante/item/new"/>" class="btn blue center btn-large">Cadastrar Item</a></td>
                                </tr>                                
                            </table>
                        </div>
                    </div>
                </div>  
            </c:if>

        </header>
    </body>
</html>



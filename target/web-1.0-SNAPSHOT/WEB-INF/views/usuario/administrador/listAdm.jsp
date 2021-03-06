<%-- 
    Document   : list
    Created on : 20/09/2016, 10:45:53
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Lista de Administradores</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">    
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/ghpages-materialize.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/css/modulo-administrador/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <link href="<c:url value="/resources/css/modulo-administrador/list-adm-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-administrador.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/administrador/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="#!" class="breadcrumb link-ativo">Administradores</a>                                              
                </div>                                        
                <a class="btn blue right btn-cadastrar btn-large" href="<c:url value="/administrador/new"/>" style="margin-bottom: 1%;">Cadastrar Administrador</a>
            </div>
            <div class="linha"></div>

            <div class="container tabela">                
                    <h5 class="center titulo">ADMINISTRADORES CADASTRADOS</h5>
                    <div class="divider"></div>
                    <table class="bordered responsive-table striped">
                        <thead>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>CPF</th>
                        <th>Telefone</th>
                        <th></th>
                        </thead>
                        <tbody>
                            <c:forEach items="${admList}" var="adm">
                                <tr>
                                    <td>${adm.nome}</td>
                                    <td>${adm.email}</td>
                                    <td>${adm.cpf}</td>
                                    <td>${adm.telefone}</td>                                        
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <ul class="pagination center">
                        <c:if test="${offset > 0}">
                            <li class="waves-effect"><a href="<c:url value="/administrador/list?limit=${limit}&offset=${offset - limit}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                            </c:if>

                        <c:if test="${offset <= 0}">
                            <li class="waves-effect"><a href="<c:url value="/administrador/list?limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                            </c:if>


                        <c:if test="${(offset + limit) < count}">
                            <li class="waves-effect"><a href="<c:url value="/administrador/list?limit=${limit}&offset=${offset + limit}"/>"><i class="material-icons">chevron_right</i></a></li>
                            </c:if>

                        <c:if test="${(offset + limit) >= count}">
                            <li class="waves-effect"><a href="<c:url value="/administrador/list?limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_right</i></a></li>
                            </c:if>
                    </ul>                
            </div>           
        </header>
    </body>
</html>

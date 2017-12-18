<%-- 
    Document   : recuperar-senha
    Created on : 18/10/2016, 13:47:11
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

        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/anunciante/cadastro-anunciante.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>    

        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>   
    </head>
    <body>
        <form method="post">
            <div class="row">
                <input name="senha" id="senha" type="password">
                <label for="senha">Digite a nova senha</label>
            </div>
            <div class="row">
                <input name="novaSenha" id="novaSenha" type="password">
                <label for="novaSenha">Digite a nova senha</label>
            </div>
            <button type="submit" class="btn btn-large blue">Enviar</button>
        </form>
    </body>
</html>

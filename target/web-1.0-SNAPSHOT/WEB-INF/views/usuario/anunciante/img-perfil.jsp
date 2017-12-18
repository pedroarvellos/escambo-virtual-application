<%-- 
    Document   : img-perfil
    Created on : 22/09/2016, 09:54:09
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Perfil</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <link href="<c:url value="/resources/css/modulo-anunciante/img-perfil-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       

        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>

        <script>
            function carregaImagem(input, id) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#' + id).attr('src', e.target.result);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }
            ;
        </script>
    </head>
    <body>   
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="/anunciante/perfil"/>" class="breadcrumb link-anterior">Perfil</a>                                              
                    <a href="<c:url value="#!"/>" class="breadcrumb link-ativo">Alterar imagem de perfil</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>


            <div class="container formulario">
                <div class="card-content">                       
                    <div class="card-title center">Imagem de Perfil</div>
                    <div class="card-panel" style="margin-left: 33%; margin-right: 33%;">
                        <c:if test="${not empty anunciante.imagem}">                
                            <img class="center" id="imagem" src="<c:url value="/usuario/${anunciante.id}/img.jpg"/>" height="200" width="200">
                        </c:if>
                        <c:if test="${empty anunciante.imagem}">
                            <c:if test="${anunciante.sexo == 'Masculino'}">                                                                                                               
                                <img class="center responsive-img" id="imagem" src="<c:url value="/resources/img/default-avatar_man.png"/>" height="200" width="200">
                            </c:if>
                            <c:if test="${anunciante.sexo == 'Feminino'}">                                                                                                            
                                <img class="center" id="imagem" src="<c:url value="/resources/img/default-avatar_women.png"/>" height="200" width="200">
                            </c:if>
                        </c:if>
                    </div>
                    <div calss="row">
                        <form method="post" enctype="multipart/form-data">
                            <div class="file-field input-field row">
                                <div class="btn blue">
                                    <span>Adicionar imagem de perfil</span>
                                    <input type="file" name="file" id="file" value="<c:url value="/usuario/${anunciante.id}/img.jpg"/>" onchange="carregaImagem(this, 'imagem')">                                
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate col s12 m6 l6" type="text">
                                </div>                                        
                            </div>  
                            <!--<hr style="border: 1px dashed;">-->
                            <br/>
                            <div class="row">
                                <a class="btn grey darken-3 right btn-large" href="<c:url value="/anunciante/perfil"/>">Cancelar</a>
                                <button type="submit" class="btn blue btn-large right" style="margin-right: 0.6rem;">Salvar</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </header>
    </body>
</html>

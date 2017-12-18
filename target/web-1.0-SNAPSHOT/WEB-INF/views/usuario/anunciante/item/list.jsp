<%-- 
    Document   : list
    Created on : 07/09/2016, 14:10:38
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Meus Itens</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/meus-itens-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--SCRIPTS-->
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>

        <script>
            $(document).ready(function () {
                // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
                $('.modal-trigger').leanModal();
            });

            function setId(id) {
                document.getElementById('delete-item').value = id;
            }
            ;
        </script>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>

            <!--MODAL EXCLUIR ITEM-->                                    
            <div id="modal-excluir" class="modal">
                <div class="modal-content">
                    <h4>Exclusão de Item</h4>
                    <p>Você tem certeza que deseja excluir este item? Esta exclusão não poderá ser desfeita posteriormente e, todos os dados referentes a este item serão excluídos do sistema.</p>
                    <form action="/web/anunciante/item/del" method="post">
                        <input type="hidden" name="idItem" value="" id="delete-item">
                        </div>
                        <div class="modal-footer">
                            <a href="#!" class=" modal-action modal-close waves-effect waves-green btn blue">Cancelar</a>
                            <!--<a href="/anunciante/item//del" id="delete-item" class=" modal-action modal-close waves-effect waves-green btn blue" style="margin-right: 0.6rem;">Excluir</a>-->
                            <button type="submit" class="btn red modal-close" style="margin-right: 0.6rem;">Confirmar</button>
                    </form>
                </div>
            </div>
            <!--FIM MODAL-->

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m6 l6 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="#!" class="breadcrumb link-ativo">Meus Itens</a>
                </div>
                <a class="waves-effect waves-light btn blue btn-large btn-cadastrar right" href="<c:url value="/anunciante/item/new"/>" style="margin-top: 1%;">Cadastrar item</a>
            </div>
            <div class="linha"></div>                       

            <div class="container col s12 m12 l12">

                <c:if test="${empty itemList}">
                    <div class="card-panel">
                        <div class="card-title center" style="text-transform: uppercase;"><strong>Você ainda não possui itens cadastrados!</strong></div>
                    </div>
                </c:if>
                <div class="list-itens">
                    <c:if test="${count > 0}">
                        <h6 class=""><strong>Você possui ${count} itens cadastrados</strong></h6>
                    </c:if>                                        
                    <c:forEach items="${itemList}" var="item">                                                        
                        <div class="item col s12 m12 l12">

                            <table class="bordered">
                                <tr>                                               
                                    <td colspan="2">
                                        <div class="card-title">                        
                                            <h5>${item.nome}</h5>                                                
                                        </div>
                                    </td>                                        
                                </tr>                                    
                                <tr>
                                    <td rowspan="4">
                                        <c:if test="${empty item.itemImagemList}">
                                            <img class="responsive-img" src="<c:url value="/resources/img/sem-imagem.jpg"/>" height="200" width="200">
                                        </c:if>
                                        <c:if test="${not empty item.itemImagemList}">                                                            
                                            <c:forEach items="${item.itemImagemList}" var="itemImagem">
                                                <a class="carousel-item" href="#one!">
                                                    <img class="materialboxed responsive-img" src="<c:url value="/anunciante/item/img/${itemImagem.hash}"/>" height="200" width="200">
                                                </a>                                        
                                            </c:forEach>                                                            
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Data de Publicação: &nbsp;</b>${item.dataCadastro}</td>
                                    <td><b>Interesse 1: &nbsp;</b>${item.interesse1}</td>
                                </tr>
                                <tr>
                                    <td><b>Data de Aquisição: &nbsp;</b>${item.dataAquisicao}</td>
                                    <td><b>Interesse 2: &nbsp;</b>${item.interesse2}</td>
                                </tr>
                                <tr>
                                    <td><b>Status: &nbsp;</b>${item.status}</td>
                                    <td><b>Interesse 3: &nbsp;</b>${item.interesse3}</td>
                                </tr>
                                <tr>
                                    <td><b>Descrição: </b></td>
                                    <td>${item.descricao}</td> 
                                </tr>
                                <tr>
                                    <td class="right-align" colspan="4">
                                        <a class="waves-effect waves-light btn blue btn-large" href="<c:url value="/anunciante/item/${item.id}/edit"/>" style="margin-left: 0.6rem;">Editar</a>
                                        <a class="waves-effect waves-light btn red modal-trigger btn-large" href="<c:url value="#modal-excluir"/>" onclick="setId(${item.id})">Excluir</a>                                        
                                    </td>
                                </tr>
                            </table>
                        </div>                                    
                    </c:forEach>                                        
                </div>
            </div>         
        </header>        
    </body>
</html>

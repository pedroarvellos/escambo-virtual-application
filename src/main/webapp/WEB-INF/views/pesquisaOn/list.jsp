<%-- 
    Document   : list
    Created on : 07/09/2016, 13:28:02
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Pesquisar</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/pesquisa-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>

        <!--SCRIPTS-->
        <script>
            $(document).ready(function () {
                $('.modal-trigger').leanModal();
            });
        </script>
        <script>
            function buscar_cidades() {
                var estado = $('#estado').val();
                if (estado) {
                    var url = '/web/usuario/cidades/' + estado;
                    $.get(url, function (dataReturn) {
                        var cidades = jQuery.parseJSON(dataReturn);

                        var select = $('#cidade');
                        select.find('option').remove();
                        $('<option>').val('').text('Selecione a Cidade').appendTo(select);

                        var i = 0;
                        while (i < cidades.length) {
                            $('<option>').val(cidades[i].id).text(cidades[i].nome).appendTo(select);
                            i++;
                        }
                    });
                }
            }
        </script>
        <!--JS BASE-->
        <jsp:include page="/resources/css/bases/js/base-script.jsp"/>
    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"></jsp:include>

                <div class="row container nav-breadcrumb">                             
                    <div class="col s12 l6 m6 links">
                        <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="#!"/>" class="breadcrumb link-ativo">Pesquisar</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>

            <div class="col s12 m12 l12 container">                
                <form class="formulario"> 
                    <div class="row">
                        <h5>Selecione um local e digite algo para pesquisar</h5>
                        <!--<div class="form divider grey"></div>-->
                        <div class="input-field col s12 m6 l6">
                            <select name="estado" id="estado" class="browser-default" style="border-color: grey;" onchange="buscar_cidades()">
                                <option value="" disabled="" selected="">Selecione o Estado</option>                                              
                                <c:if test="${not empty estadoBuscado}">
                                    <option value="${estadoBuscado.id}" disabled="" selected="">${estadoBuscado.nome}</option>
                                </c:if>
                                <c:forEach items="${estados}" var="estado">
                                    <option value="${estado.id}">${estado.nome}</option>
                                </c:forEach>
                            </select>                            
                        </div>
                        <div id="load_cidades" class="input-field col s12 m6 l6">
                            <select name="cidadeID" id="cidade" class="browser-default" style="border-color: grey;">                                
                                <option value="" disabled="" selected="">Selecione a Cidade</option>  
                                <c:if test="${not empty cidade}">
                                    <option value="${cidade.id}" disabled="" selected="">${cidade.nome}</option>
                                </c:if>
                            </select>                            
                        </div>
                    </div>
                    <div class="row ">
                        <div class="input-field col s12 m6">
                            <input id="pesquisar" name="nomeCriterium" type="text" value="${nomeCriterium}" placeholder="Digite algo para pesquisar"/>
                            <!--<label for="pesquisar">Pesquise por itens</label>-->
                        </div>   
                        <button type="submit" class="btn blue btn-pesquisar">Pesquisar</button>
                    </div>
                </form>                

                <div class="resultados">
                    <c:if test="${empty itemList}">
                        <div class="row">
                            <div class="card-panel">
                                <div class="card-content">
                                    <i class="material-icons">thumb_down</i>
                                    <span class="card-title" style="font-weight: 500; font-size: 16pt;">Não foram encontrados resultados para esta busca.</span>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${count > 0}">                    
                        <h5><strong>Resultados encontrados: ${count}</strong></h5>
                        <br/>
                    </c:if>
                    <ul>
                        <c:forEach var="item" items="${itemList}">
                            <a href="<c:url value="/anunciante/pesquisar/item/${item.id}/view"></c:url>" class="black-text painelAnuncios hoverable">
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
                                <li class="waves-effect"><a href="<c:url value="/anunciante/pesquisar/item?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset - limit}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                                </c:if>

                            <c:if test="${offset <= 0}">
                                <li class="waves-effect"><a href="<c:url value="/anunciante/pesquisar/item?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_left</i></a></li>                            
                                </c:if>


                            <c:if test="${(offset + limit) < count}">
                                <li class="waves-effect"><a href="<c:url value="/anunciante/pesquisar/item?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset + limit}"/>"><i class="material-icons">chevron_right</i></a></li>
                                </c:if>

                            <c:if test="${(offset + limit) >= count}">
                                <li class="waves-effect"><a href="<c:url value="/anunciante/pesquisar/item?nomeCriterium=${nomeCriterium}&limit=${limit}&offset=${offset}"/>"><i class="material-icons">chevron_right</i></a></li>
                                </c:if>
                        </ul>
                    </c:if>

                </div>  
            </div>            
        </header>
    </body>
</html>

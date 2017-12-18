<%-- 
    Document   : new
    Created on : 07/09/2016, 14:15:20
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Cadastrar Novo Item</title>
        <!--CSS BASE-->
        <jsp:include page="/resources/css/bases/css/base-style.jsp"/>

        <link href="<c:url value="/resources/css/modulo-anunciante/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/modulo-anunciante/item-new-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <!--SCRIPTS-->
        <script>
//            document.getElementById("file").onchange = function () {
//                var reader = new FileReader();
//                reader.onload = function (e) {
//                    document.getElementById("image").src = e.target.result;
//                };
//                reader.readAsDataURL(this.files[0]);
//            };

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

        <script src="<c:url value="/resources/js/jquery.maskedinput.min.js"/>"></script>
        <script src="<c:url value="/resources/js/mask-cadastro.js"/>"></script>
    </head>
    <body class="body">
        <header>
            <jsp:include page="/resources/templates/menu-lateral-anunciante.jsp"/>            

            <div class="row container nav-breadcrumb">                                    
                <div class="col s12 m12 l12 links">
                    <a href="<c:url value="/anunciante/home"/>" class="breadcrumb link-anterior">Home</a>
                    <a href="<c:url value="/anunciante/item"/>" class="breadcrumb link-anterior">Meus Itens</a>
                    <a href="#!" class="breadcrumb link-ativo">Cadastrar Item</a>
                </div>       
            </div>
            <div class="linha"></div>

            <div class="row container">                
                <h6 id="campos">Campos com * são obrigatórios</h6>
                <form method="post" enctype="multipart/form-data">                    
                    <div class="card-content" style="padding-top: 1%;">                        
                        <div class="panel1">                            
                            <div class="card-title">                        
                                <h5>Informações do seu item</h5>
                                <div class="form divider grey"></div>
                                <br/>
                            </div>
                            <div class="row">
                                <c:if test="${not empty errors.nome}">
                                    <div class="red-text col s12 m6 l6">${errors.nome}</div>
                                </c:if>  
                                <c:if test="${not empty errors.data}">
                                    <div class="red-text col s12 m6 l6">${errors.data}</div>
                                </c:if>  
                            </div>
                            <div class="row">
                                <div class="input-field col s12 m6 l6">
                                    <input id="nome" name="nome" type="text" class="validate" placeholder="Ex.: bola" required="" value="${fields.nome}"/>
                                    <label for="nome">Nome*</label>
                                </div>
                                <div class="input-field col s12 m6 l6">
                                    <input id="dataAquisicao" name="dataAquisicao" type="text" class="validate" placeholder="Ex.: 31/02/2014" required="" value="${fields.data_aquisicao}"/>
                                    <label for="dataAquisicao">Data de aquisição*</label>
                                </div>                          
                            </div>
                            <c:if test="${not empty errors.descricao}">
                                <div class="row red-text">${errors.descricao}</div>
                            </c:if>  
                            <div class="row">
                                <!--<span><strong>Insira uma breve descrição sobre ele:</strong></span>-->
                                <div class="input-field col s12">
                                    <textarea id="textarea1" class="materialize-textarea" name="descricao" length="1400" placeholder="Faça uma breve descrição do seu item" required="">${fields.descricao}</textarea>
                                    <label for="textarea1">Descrição*</label>
                                </div>
                            </div>

                        </div>
                        <div class="panel2">                            
                            <div class="row">
                                <div class="card-title">                        
                                    <h5>Lista de interesses</h5>
                                    <div class="form divider grey"></div>
                                    <br/>
                                </div>
                                <div class="input-field col s12 m4 l4">
                                    <input id="interesse1" name="interesse1" type="text" class="validate" placeholder="Ex.: Celular"/>
                                    <label for="interesse1">Interesse 1</label>
                                </div>    
                                <div class="input-field col s12 m4 l4">
                                    <input id="interesse2" name="interesse2" type="text" class="validate" placeholder="Ex.: Livro" />
                                    <label for="interesse2">Interesse 2</label>
                                </div>
                                <div class="input-field col s12 m4 l4">
                                    <input id="interesse3" name="interesse3" type="text" class="validate" placeholder="Ex.: Notebook"/>
                                    <label for="interesse3">Interesse 3</label>
                                </div>                         
                            </div>
                        </div>
                        <div class="panel4">                            
                            <div class="card-title">                        
                                <h5>Adicione uma localização para este item*</h5>
                                <div class="form divider grey"></div>
                                <br/>
                            </div>
                            <c:if test="${not empty errors.cidade}">
                                <div class="row red-text">${errors.cidade}</div>
                            </c:if>  
                            <div class="row">
                                <div class="input-field col s12 m6 l6">
                                    <select name="estado" id="estado" class="browser-default" style="border-color: grey;" onchange="buscar_cidades()">
                                        <option value="" disabled="" selected="">Selecione o Estado</option>
                                        <c:if test="${not empty local}"><option value="${local.estado.id}" disabled="" selected="">${local.estado.nome}</option></c:if>
                                        <c:forEach items="${estados}" var="estado">
                                            <option value="${estado.id}">${estado.nome}</option>
                                        </c:forEach>
                                    </select>                            
                                </div>
                                <div id="load_cidades" class="input-field col s12 m6 l6">
                                    <select name="cidadeID" id="cidade" class="browser-default" style="border-color: grey;">                                
                                        <c:if test="${not empty local}"><option value="${local.id}" disabled="" selected="">${local.nome}</option></c:if>
                                        <c:if test="${empty local}">
                                            <option value="" disabled="" selected="">Selecione a Cidade</option>                                                
                                        </c:if>
                                    </select>                            
                                </div>
                            </div>

                        </div>
                        <div class="panel3">                            
                            <div class="row">
                                <div class="card-title">                        
                                    <h5>Adicione imagens do seu item</h5>
                                    <div class="form divider grey"></div>
                                    <br/>
                                </div>
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
                                            <img class="card-panel col s12 z-depth-2 responsive-img" id="imagem1" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                        </td>
                                        <td>
                                            <img class="card-panel col s12 responsive-img" id="imagem2" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                        </td>
                                        <td>
                                            <img class="card-panel col s12 responsive-img" id="imagem3" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                        </td>
                                        <td>
                                            <img class="card-panel col s12 responsive-img" id="imagem4" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                        </td>
                                        <td>
                                            <img class="card-panel col s12 responsive-img" id="imagem5" style="margin: 1%;" src="<c:url value="/resources/img/sample-1.jpg"/>" height="200" width="200">    
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row">
                                <!--<img class="responsive-img" id="image" name="image" src="">-->
                                <div class="file-field input-field">
                                    <div class="btn blue col s12 m2 l2">
                                        <span>+ imagem</span>
                                        <input type="file" name="file1" id="file1" onchange="carregaImagem(this, 'imagem1')">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>  
                                </div>
                                <div class="file-field input-field">
                                    <div class="btn blue col s12 m2 l2">
                                        <span>+ imagem</span>
                                        <input type="file" name="file2"  id="file2" onchange="carregaImagem(this, 'imagem2')">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>  
                                </div>
                                <div class="file-field input-field">
                                    <div class="btn blue col s12 m2 l2">
                                        <span>+ imagem</span>
                                        <input type="file" name="file3"  id="file3" onchange="carregaImagem(this, 'imagem3')">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>  
                                </div>
                                <div class="file-field input-field">
                                    <div class="btn blue col s12 m2 l2">
                                        <span>+ imagem</span>
                                        <input type="file" name="file4"  id="fil4" onchange="carregaImagem(this, 'imagem4')">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>  
                                </div>
                                <div class="file-field input-field">
                                    <div class="btn blue col s12 m2 l2">
                                        <span>+ imagem</span>
                                        <input type="file" name="file5"  id="file5" onchange="carregaImagem(this, 'imagem5')">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text">
                                    </div>  
                                </div>                                       
                            </div>                                                                            
                        </div>

                        <a class="waves-effect waves-light btn right grey darken-3 btn-large col s12 m4 l2" href="<c:url value="/anunciante/item"/>">Cancelar</a>                                
                        <button type="submit" class="waves-effect waves-light btn blue right btn-large col s12 m4 l2" style="margin-right: 0.6rem;">Salvar</button>                                                
                </form>
            </div>
        </div>                    
    </header>
</body>
</html>

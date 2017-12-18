<%-- 
    Document   : estatistica
    Created on : 06/10/2016, 12:54:48
    Author     : Joao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Estatísticas</title>
        <!--Import Google Icon Font-->
        <link href="<c:url value="/resources/css/icon.css"/>" rel="stylesheet">    
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/materialize.min.css"/>"  media="screen,projection"/>
        <link href="<c:url value="/resources/css/style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="<c:url value="/resources/css/ghpages-materialize.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link rel="shortcut icon" href="<c:url value="/resources/img/favicon.ico"/>" type="image/x-icon">

        <link href="<c:url value="/resources/css/modulo-administrador/base-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <link href="<c:url value="/resources/css/modulo-administrador/estatistica-style.css"/>" type="text/css" rel="stylesheet" media="screen,projection"/>       
        <!--SCRIPTS-->
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>

        <script type="text/javascript" src="<c:url value="/resources/js/loader.js"/>"></script>         
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfCTZesUuIlMSSbwJv35cUDcq9eeu5xF4" type="text/javascript"></script>
        <!--<script src="<c:url value="/resources/js/key-google.js"/>" type="text/javascript"></script>-->

    </head>
    <body>
        <header>
            <jsp:include page="/resources/templates/menu-lateral-administrador.jsp"/>

            <div class="row container nav-breadcrumb">                             
                <div class="col s12 l6 m6 links">
                    <a href="<c:url value="/administrador/home"/>" class="breadcrumb link-anterior">Home</a>                                              
                    <a href="<c:url value="#!"/>" class="breadcrumb link-ativo">Estatísticas</a>                                              
                </div>                                        
            </div>
            <div class="linha"></div>

                <div class="container graficos">
                    <div class="card-content">
                        <div class="row">
                            <div class="card-panel">
                                <div class="card-title center">                                    
                                    <span><i class="material-icons">assessment</i><strong>Estatísticas do Sistema</strong></span></div>
                            </div>
                            <div class="row">
                                <form>
                                    <select name="opcao" class="browser-default select col s12 m6 l6 push-l1" style="border-color: grey">
                                        <option value="" selected="" disabled="">Selecione um tipo de dado</option>
                                        <option value="1">Sobre os Itens</option>
                                        <option value="2">Sobre os Usuários</option>
                                        <option value="3">Sobre os Estados </option>
                                    </select>                                    
                                    <button type="submit" class="btn blue waves-effect col s12 m3 l3 push-l1 btn-gerar" style="margin-left: 0.6rem;margin-top: 0.2rem;">Gerar Dados</button>
                                </form>
                            </div>
                        </div>
                        <c:if test="${opcao == 1}">
                            <div class="row">    
                                <h5><strong>Informações sobre os Itens</strong></h5>
                                <script type="text/javascript">
                                    google.charts.load("current", {packages: ["corechart"]});
                                    google.charts.setOnLoadCallback(drawChart);
                                    function drawChart() {
                                        var data = google.visualization.arrayToDataTable([
                                            ['Itens', 'Quantidade pelo total'],
                                            ['Publicados', ${estatistica.itemPublicado}],
                                            ['Não Publicados', ${estatistica.itemNaoPublicado}],
                                            ['Trocado', ${estatistica.itemTrocado}],
                                            ['Em Avaliação', ${estatistica.itemEmAvaliacao}]
                                        ]);

                                        var options = {
                                            title: 'Itens do Sistema - Total = ' +${estatistica.itemTotal},
                                            is3D: true,
                                            widht: 500,
                                            height: 400
                                        };

                                        var chart = new google.visualization.PieChart(document.getElementById('chart'));
                                        chart.draw(data, options);
                                    }
                                </script>                                
                            </div>
                        </c:if>
                        <c:if test="${opcao == 2}">
                            <div class="row">     
                                <h5><strong>Informações sobre os Usuários</strong></h5>
                                <script type="text/javascript">
                                    google.charts.load("current", {packages: ["corechart"]});
                                    google.charts.setOnLoadCallback(drawChart);
                                    function drawChart() {
                                        var data = google.visualization.arrayToDataTable([
                                            ['Usuarios', 'Quantidade pelo total'],
                                            ['Administradores', ${estatistica.usuarioAdm}],
                                            ['Anunciantes', ${estatistica.usuarioAnunciante}]
                                        ]);

                                        var options = {
                                            title: 'Usuários do Sistema - Total = ' +${estatistica.usuarioTotal},
                                            is3D: true,
                                            widht: 500,
                                            height: 400
                                        };

                                        var chart = new google.visualization.PieChart(document.getElementById('chart'));
                                        chart.draw(data, options);
                                    }
                                </script>
                            </div>
                        </c:if>
                        <c:if test="${opcao == 3}">
                            <div class="row">
                                <h5><strong>Itens por regiões do Brasil</strong></h5>
                                <script type='text/javascript'>
                                    google.charts.load('upcoming', {'packages': ['geochart']});
                                    google.charts.setOnLoadCallback(drawMarkersMap);

                                    function drawMarkersMap() {
                                        var data = google.visualization.arrayToDataTable([
                                            ['Estate', 'Qtde Itens'],
                                    <c:forEach items="${infoEstado}" var="estado">
                                            ['${estado.estado.nome}', ${estado.qtdeItem}],
                                    </c:forEach>
                                        ]);
                                        var options = {
                                            region: 'BR',
                                            displayMode: 'markers',
                                            colorAxis: {colors: ['red', 'green']},
                                            backgroundColor: '#bdbdbd',
                                            datalessRegionColor: '#29b6f6'
                                        };

                                        var chart = new google.visualization.GeoChart(document.getElementById('chart'));
                                        chart.draw(data, options);
                                    }
                                    ;
                                </script>                                                                
                            </div>
                        </c:if>
                        <table>
                            <tr>
                                <td><div id="chart" style="border: 1px solid #ccc;"></div></td>
                            </tr>
                        </table>
                    </div>
                </div>            
        </header>
    </body>
</html>

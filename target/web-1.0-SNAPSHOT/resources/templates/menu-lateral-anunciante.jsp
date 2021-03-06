<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navTop">
    <div class="container">
        <div class="nav-wrapper center-align tituloPage"><a class="page-title">Escambo Virtual</a></div>                
    </div>
</nav>
<div class="container">
    <a href="#" data-activates="nav-mobile" class="button-collapse top-nav hide-on-large-only ">
        <i class="material-icons">menu</i>
    </a>
</div> 
<ul id="nav-mobile" class="side-nav fixed collapsible grey lighten-4" style="transform: translateX(0%);">
    <div style="margin-top: 15%;">
        <center>
            <c:if test="${not empty anunciante.imagem}">                
                <a href="<c:url value="/anunciante/home"/>"><img class="img circle" src="<c:url value="/usuario/${anunciante.id}/img.jpg"/>" height="100" width="100"></a>                        
            </c:if>
            <c:if test="${empty anunciante.imagem}">
                <c:if test="${anunciante.sexo == 'Masculino'}">                
                    <a href="<c:url value="/anunciante/home"/>"><img class="img circle" src="<c:url value="/resources/img/default-avatar_man.png"/>" height="100" width="100"></a>                        
                </c:if>
                <c:if test="${anunciante.sexo == 'Feminino'}">                
                    <a href="<c:url value="/anunciante/home"/>"><img class="img circle" src="<c:url value="/resources/img/default-avatar_women.png"/>" height="100" width="100"></a>                        
                </c:if>
            </c:if>
            <br/>
            <br/>
            <strong>Ol�, ${anunciante.apelido}!</strong>
        </center>
    </div>
    <br/>                
    <div class="divider center-align" style="width: 80%;"></div>
    <li class="no-padding">
        <ul class="collapsible">                       
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/alterarsenha" />"><i class="material-icons">vpn_key</i>Alterar Senha</a>
            </li>
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/perfil"/>"><i class="material-icons">perm_identity</i>Perfil</a>
            </li>            
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/item"/>"><i class="material-icons">perm_media</i>Meus Itens</a>
            </li>
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/pesquisar/item"/>"><i class="material-icons">search</i>Pesquisar</a>
            </li>
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/mensagem/list"/>"><i class="material-icons">chat</i>Conversas<span id="menuConversa" class="alert"></span></a>
            </li>  
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/oferta/list"/>"><i class="material-icons">call_received</i>Ofertas Recebidas</a>
            </li>                                   
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/anunciante/troca/list"/>"><i class="material-icons">import_export</i>Trocas Realizadas</a>
            </li>
            <li>
                <a class="collapsible-header black-text waves-effect waves-color-demo" href="<c:url value="/sair"/>"><i class="material-icons">settings_power</i>Sair</a>
            </li>
        </ul>
    </li>
</ul>



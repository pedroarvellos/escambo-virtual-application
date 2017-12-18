<%-- 
    Document   : index
    Created on : 18/05/2016, 19:03:58
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

    <body class="bodyFont">
        <jsp:include page="usuario/login.jsp"></jsp:include>
            <!-- NAVBAR -->
            <div class="navbar-fixed">
                <nav id="navbarTop">
                    <div class="nav-wrapper">
                        <a href="#!" class="brand-logo"></a>
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

            <!-- PARALLAX -->
            <div class="parallax-container">
                <div class="parallax"><img src="resources/img/bgtopo.jpg"></div>
                <div class="caption center-align">
                    <div class="row">

                        <div class="row">
                            <!--<h2 class="white-text">Escambo Virtual</h2>-->
                            <!--<h5 class="light white-text text-lighten-4">ENCONTRE ITENS PARA <strong>TROCA</strong>.</h5>--> 
                            <img class="img-logo" src="<c:url value="resources/img/logo_escambovirtual.png"/>">
                            <form class="col s12" action="item/search">
                                <div id="formPesquisa" class="input-field col s6 black-text"> <!--Consertar -->
                                    <input id="icon_prefix" type="text" name="nomeCriterium" class="validate" placeholder="Pesquise por itens"> 
                                    <!--<a href="<c:url value="/escamboVirtual"/>" class="btn">Search</button></a>-->
                                <button class="btn btn-pesquisar waves-effect waves-green" type="submit">Pesquisar</button>
                            </div>
                        </form>
                    </div>                 
                    <div class="row caption center-align" id="txt-cadastrese">
                        <h6>Ainda não possui conta? <a href="<c:url value="/anunciantes/novo"/>"><strong>Cadastre-se!</strong></a></h6>
                    </div>

                </div>
            </div>            
        </div>
        <!-- FIM PARALLAX -->


        <div class="row titulo1">
            <div class="container">
                <h3 class="titulo">Conheça mais sobre <br/>o Escambo Virtual</h3>
                <hr id="linha">
            </div>
        </div>
        <div class="sobre">
            <div id="listAnuncios" class="container col s12 m6 painelAnuncios">
                <div class="center-align">                    
                    <div class="row">
                        <div class="col s12 l4 m4 box1">
                            <img class="img responsive-img circle" src="<c:url value="/resources/img/icone01.png"/>">
                            <!--<i class="material-icons large">perm_identity</i>-->
                            <!--<h4 class="center">Comece se cadastrando</h4>-->
                            <p class="light">O primeiro passo é se cadastrar, é partir daí que você poderá utilizar os serviços que o Escambo Virtual lhe oferece. <a href="<c:url value="/anunciantes/novo"/>">Comece já!</a></p>
                            <br>
                        </div>
                        <div class="col s12 l4 m4 box2">
                            <img class="img responsive-img circle" src="<c:url value="/resources/img/icone02.png"/>">
                            <!--<i class="material-icons large">business</i>-->
                            <!--<h4 class="center">Anuncie seus itens</h4>-->
                            <p class="light">Com o cadastro já realizado e o acesso à área do sistema disponível, você pode começar a anunciar os itens que você deseja trocar, podendo indicar até mesmo alguns interesses que você tem para realizar uma troca!</p>
                            <br>
                        </div>
                        <div class="col s12 l4 m4 box3">
                            <img class="img responsive-img circle" src="<c:url value="/resources/img/icone03.png"/>">
                            <!--<i class="material-icons large">trending_up</i>-->                            
                            <!--<h4 class="center">Receba ofertas pelos seus itens</h4>-->
                            <p class="light">Com o item anunciado é provável que ele chame a atenção de algum anunciante que poderá fazer ofertas pelo seu item. Logo, você receberá essas ofertas, podendo aceitar uma delas e firmar uma troca!</p>
                            <br>
                        </div>
                    </div>                    
                </div>
            </div>
        </div>

        <div class="developers">
            <div class="row titulo1">
                <div class="container">
                    <h3 class="titulo">Os desenvolvedores</h3>
                    <hr id="linha">
                </div>
            </div>

            <div class="container" style="margin-top: -4%;">
                <div class="row">
                    <div class="box4 col s12 m2 l2">
                        <img class="img" src="<c:url value="/resources/img/joao.jpg"/>">
                    </div>
                    <div class="box5 col s12 m2 l2">
                        <h5 class="nomes">Joao Pedro</h5>
                        <!--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>-->
                    </div>
                    <div class="box6 col s12 m2 l2">
                        <img class="img" src="<c:url value="/resources/img/mauricio.jpg"/>">
                    </div>
                    <div class="box7 col s12 m2 l2">
                        <h5 class="nomes">José Mauricio</h5>
                        <!--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>-->
                    </div>
                    <div class="box8 col s12 m2 l2">
                        <img class="img" src="<c:url value="/resources/img/pedro.jpg"/>">
                    </div>
                    <div class="box9 col s12 m2 l2">
                        <h5 class="nomes">Pedro Arvellos</h5>
                        <!--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>-->
                    </div>
                </div>
            </div>
        </div>


        <!-- RODAPÉ -->
        <footer class="footer" style="margin-top: -5%;">
            <div class="container">
                <div class="row">
                    <div class="col l12 s12">
                        <h5 class="white-text">Fale conosco</h5>
                        <p class="grey-text text-lighten-4">Entre em contato conosco através do email <strong>escambov@gmail.com</strong>, estamos à disposição para lhe atender!</p>                                        
                    </div>                      
                </div>
            </div>
            <div class="footer-copyright">
                <div class="container">
                    © 2016 Escambo Virtual. Todos os direitos reservados.                    
                </div>
            </div>
        </footer>
        <!-- FIM RODAPE -->


        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/materialize.min.js"/>"></script>
        <script src="<c:url value="/resources/js/init.js"/>"></script>

        <script>
            $(document).ready(function () {
                $('.slider').slider({full_width: true});
            });
        </script>

        <script>
            $(document).ready(function () {
                // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
                $('.modal-trigger').leanModal();
            });

            $('.modal-trigger').leanModal({
                dismissible: false, // Modal can be dismissed by clicking outside of the modal
                opacity: .5, // Opacity of modal background
                in_duration: 300, // Transition in duration
                out_duration: 200, // Transition out duration
                starting_top: '4%', // Starting top style attribute
                ending_top: '10%', // Ending top style attribute            
            }
            );

            $('.dropdown-button').dropdown({
                inDuration: 500,
                outDuration: 300,
                constrain_width: false, // Does not change width of dropdown to that of the activator
                hover: true, // Activate on hover
                gutter: 15, // Spacing from edge
                belowOrigin: false, // Displays dropdown below the button
                alignment: 'left' // Displays dropdown with edge aligned to the left of button           
            }
            );

        </script>
    </body>
</html>

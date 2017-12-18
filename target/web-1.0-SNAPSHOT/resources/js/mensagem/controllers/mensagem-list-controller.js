angular.module('mensagemApp').controller('MensagemController', function ($scope, MensagemService) {

    this.MESSAGE_GET_EMPREENDIMENTOS_ERROR = "Erro ao tentar receber empreendimentos.";
    this.MESSAGE_GET_AVALIADORES_ERROR = "Erro ao tentar receber avaliadores.";
    this.MESSAGE_GET_EMPREENDEDORES_ERROR = "Erro ao tentar receber empreendedores.";
    this.MESSAGE_GET_SERVER_BAD_CONNECTION = "Erro ao tentar comunicar com o servidor.";

    var app = this;


    $scope.mensagemList = [];
    $scope.mensagem = {};

//    $(document).ready(function () {
//        mensagem.verificaMensagem();
//    });
//    
//    mensagem = {
//        
//    };


    function _getMensagens() {
        try {
            MensagemService.getMensagens().success(function (data) {
                $scope.mensagemList = data;
                console.log($scope.mensagemList);
            }).error(function () {
                Materialize.toast(app.MESSAGE_GET_EMPREENDIMENTOS_ERROR, 4000, 'orange rounded');
            });
        } catch (e) {
            Materialize.toast(app.MESSAGE_GET_EMPREENDIMENTOS_ERROR, 4000, 'orange rounded');
            console.log(e);
        }

    }
    _getMensagens();

    setInterval(function () {
        _getMensagens();
    }, 4000);


    $scope.enviarMensagem = function (mensagem) {
        try {
            MensagemService.enviarMensagem(mensagem).success(function () {
                $("#texto").val("");                
                _getMensagens();                
                Materialize.toast('Enviada!', 4000, 'green rounded');
//                window.location.href = '/gerenciador/empreendedor/empreendimentos';
            }).error(function () {
                Materialize.toast('Erro ao tentar enviar!', 4000, 'orange rounded');
            });
        } catch (e) {
            console.log(e);
            Materialize.toast(app.MESSAGE_GET_SERVER_BAD_CONNECTION, 4000, 'red rounded');
        }

    };

});
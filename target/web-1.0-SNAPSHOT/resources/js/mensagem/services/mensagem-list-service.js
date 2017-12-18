(function () {
    angular.module('mensagemApp')
            .factory('MensagemService', function ($http, MensagemValue) {

                var HEADERS = {headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        "Accept": "application/json;charset=utf-8"
                    },
                    dataType: "json"};


                var _getMensagens = function () {
                    return $http.get('/web/anunciante/mensagens', HEADERS);
                };

                var _enviarMensagem = function (mensagem) {
                    return $http.post('/web/anunciante/enviar/mensagem', mensagem, HEADERS);
                };


                return {
                    getMensagens: _getMensagens,
                    enviarMensagem: _enviarMensagem
                };

            });
})();

package escambovirtual.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import escambovirtual.constraints.AppConstraints;
import escambovirtual.model.criteria.ItemCriteria;
import escambovirtual.model.criteria.LocalizacaoCriteria;
import escambovirtual.model.entity.Administrador;
import escambovirtual.model.entity.Cidade;
import escambovirtual.model.entity.Estado;
import escambovirtual.model.entity.Imagem;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.Localizacao;
import escambovirtual.model.entity.Log;
import escambovirtual.model.entity.Usuario;
import escambovirtual.model.service.AdministradorService;
import escambovirtual.model.service.CidadeService;
import escambovirtual.model.service.EmailService;
import escambovirtual.model.service.EstadoService;
import escambovirtual.model.service.ItemService;
import escambovirtual.model.service.LocalizacaoService;
import escambovirtual.model.service.LogService;
import escambovirtual.model.service.SenhaService;
import escambovirtual.model.service.UsuarioService;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdministradorController {

    @RequestMapping(value = "/administrador/list", method = RequestMethod.GET)
    public ModelAndView admList(HttpSession session, Long limit, Long offset) {
        ModelAndView mv = null;
        try {
            if (limit != null && offset != null) {
                Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
                AdministradorService s = new AdministradorService();
                List<Administrador> admList = s.readByCriteria(null, limit, offset);
                Long count = s.countByCriteria(null, limit, offset);
                mv = new ModelAndView("usuario/administrador/listAdm");
                mv.addObject("admList", admList);
                mv.addObject("administrador", adm);
                mv.addObject("count", count);
                mv.addObject("limit", limit);
                mv.addObject("offset", offset);
            } else {
                String redirect = "redirect:/administrador/list?";

                if (limit == null) {
                    redirect += "limit=" + AppConstraints.LIMIT_LIST_ADM + "&offset=0";
                }
                mv = new ModelAndView(redirect);
            }

        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/home", method = RequestMethod.GET)
    public ModelAndView homeAdministrador(HttpSession session) {
        ModelAndView mv = null;
        try {
            Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(ItemCriteria.STATUS_EQ, "Publicar");
            ItemService s = new ItemService();
            Long itemPublicado = s.countByCriteria(criteria, null, null);
            criteria = new HashMap<>();
            criteria.put(ItemCriteria.STATUS_EQ, "Em Avaliação");
            Long itemAvaliacao = s.countByCriteria(criteria, null, null);
            AdministradorService ad = new AdministradorService();
            Long countAdm = ad.countByCriteria(null, null, null);
            mv = new ModelAndView("usuario/administrador/home");
            mv.addObject("administrador", adm);
            mv.addObject("itemPublicado", itemPublicado);
            mv.addObject("itemAvaliacao", itemAvaliacao);
            mv.addObject("countAdmin", countAdm);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }

        return mv;
    }

    @RequestMapping(value = "/administrador/new", method = RequestMethod.GET)
    public ModelAndView getAdministradorNew(HttpSession session) {
        Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
        ModelAndView mv = new ModelAndView("usuario/administrador/new");
        mv.addObject("administrador", adm);
        return mv;
    }

    @RequestMapping(value = "/administrador/new", method = RequestMethod.POST)
    public ModelAndView postAdministradorNew(String nome, String email, String apelido, String senha, String cpf, String nascimento, String telefone, String sexo, HttpServletResponse response, HttpSession session) {
        ModelAndView mv;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");

            AdministradorService s = new AdministradorService();
            Administrador adm = new Administrador();
            adm.setNome(nome);
            adm.setEmail(email);
            SenhaService ss = new SenhaService();
            adm.setSenha(ss.convertPasswordToMD5(senha));
            adm.setNascimento(nascimento);
            adm.setTelefone(telefone);
            adm.setPerfil(1L);
            adm.setCpf(cpf);
            adm.setSexo(sexo);
            adm.setApelido(apelido);
            s.create(adm);

            Log log = new Log();
//            log.setDataHora(new java.sql.Date(new java.util.Date().getTime()));
            log.setEvento("Cadastro de administrador");
            log.setIdEvento(adm.getId());
            log.setIdUsuario(administrador.getId());
            LogService sl = new LogService();
            sl.create(log);

            mv = new ModelAndView("redirect:/administrador/home");
            response.setStatus(200);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
            response.setStatus(500);
        }

        return mv;
    }

    @RequestMapping(value = "/administrador/alterar-senha", method = RequestMethod.GET)
    public ModelAndView getAlterarSenha(HttpSession session) {
        Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
        ModelAndView mv = new ModelAndView("usuario/administrador/alterarsenha");
        mv.addObject("administrador", adm);
        return mv;
    }

    @RequestMapping(value = "/administrador/alterar-senha", method = RequestMethod.POST)
    public ModelAndView postAlterarSenha(String novasenha, String senhaatual, HttpSession session) throws Exception {
        ModelAndView mv;
        SenhaService ss = new SenhaService();
        Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
        AdministradorService s = new AdministradorService();
        UsuarioService us = new UsuarioService();
        Map<String, String> errors = us.validarSenha(senhaatual, administrador);
        if (errors.isEmpty()) {
            administrador.setSenha(ss.convertPasswordToMD5(novasenha));
            s.update(administrador);

            Log log = new Log();
//            log.setDataHora(new java.sql.Date(new java.util.Date().getTime()));
            log.setEvento("Alteração de senha administrador");
            log.setIdEvento(administrador.getId());
            log.setIdUsuario(administrador.getId());
            LogService sls = new LogService();
            sls.create(log);

            mv = new ModelAndView("redirect:/administrador/home");
        } else {
            mv = new ModelAndView("usuario/administrador/alterarsenha");
            mv.addObject("validSenha", errors);
            mv.addObject("administrador", administrador);
        }

        return mv;
    }

    @RequestMapping(value = "/administrador/list/itens", method = RequestMethod.GET)
    public ModelAndView getAvaliarItem(HttpSession session, Long limit, Long offset) throws Exception {
        ModelAndView mv = null;
        try {
            if (limit != null && offset != null) {
                Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
                mv = new ModelAndView("usuario/administrador/item/list");
                mv.addObject("administrador", adm);
                ItemService s = new ItemService();

                Map<Long, Object> criteria = new HashMap<>();
                String status = "Em Avaliação";
                criteria.put(ItemCriteria.STATUS_EQ, status);
                List<Item> itemList = s.readByCriteria(criteria, limit, offset);
                Long count = s.countByCriteria(criteria, limit, offset);
                mv.addObject("itemList", itemList);
                mv.addObject("count", count);
                mv.addObject("limit", limit);
                mv.addObject("offset", offset);
            } else {
                String redirect = "redirect:/administrador/list/itens?";

                if (limit == null) {
                    redirect += "limit=" + AppConstraints.LIMIT_LIST_AVALIACAO_ITENS + "&offset=0";
                }
                mv = new ModelAndView(redirect);
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }

        return mv;
    }

    @RequestMapping(value = "/administrador/item/{id}/publicar", method = RequestMethod.GET)
    public ModelAndView publicarItem(@PathVariable Long id, HttpSession session) throws Exception {
        ModelAndView mv;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
            if (administrador.getPerfil().equals(Usuario.USUARIO_TIPO_ADMINISTRADOR)) {
                ItemService s = new ItemService();
                Item item = s.readById(id);
                String status = "Publicar";
                item.setStatus(status);
                s.update(item);
                EmailService es = new EmailService();
                 String texto = "Olá, " + item.getAnunciante().getNome() + ". Viemos por meio deste, notificar que "
                        + "seu item acaba de ser publicado no sistema Escambo Virtual. A partir de agora ele pode"
                         + " ser pesquisado e encontrado por pessoas interessadas!";
                es.sendEmail(item.getAnunciante().getEmail(), "Item publicado!", texto);
                mv = new ModelAndView("redirect:/administrador/list/itens");

                Log log = new Log();
//                log.setDataHora(new java.sql.Date(new java.util.Date().getTime()));
                log.setEvento("Edição de status de item");
                log.setDescricao("Item Publicado");
                log.setIdEvento(item.getId());
                log.setIdUsuario(administrador.getId());
                LogService sls = new LogService();
                sls.create(log);
            } else {
                mv = new ModelAndView("error");
                mv.addObject("error", "Você não possui permissão para realizar tal ação.");
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/item/nao-publicar", method = RequestMethod.POST)
    public ModelAndView naoPublicarItem(Long idItem, HttpSession session, String motivo) {
        ModelAndView mv;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
            if (administrador.getPerfil().equals(Usuario.USUARIO_TIPO_ADMINISTRADOR)) {
                ItemService s = new ItemService();
                Item item = s.readById(idItem);
                String status = "Não Publicar";
                item.setStatus(status);
                s.update(item);
                EmailService es = new EmailService();
                String texto = "Olá, " + item.getAnunciante().getNome() + ". Viemos por meio deste, notificar que "
                        + "seu item infelizmente não foi aprovado durante a avaliação para ser publicado no "
                        + "sistema Escambo Virtual. Certamente isto ocorreu pois o administrador do sistema "
                        + "encontrou alguma incoerência com nossos termos. Logo a frente encontra-se a "
                        + "descrição da não publicação de seu item. Descrição: " + motivo;
                es.sendEmail(item.getAnunciante().getEmail(), "Item não publicado =(", texto);
                mv = new ModelAndView("redirect:/administrador/list/itens");

                Log log = new Log();
                Date date = new Date();
//                log.setDataHora(date);
                log.setEvento("Edição de status de item");
                log.setDescricao("Item não publicado. Motivo:" + motivo);
                log.setIdEvento(item.getId());
                log.setIdUsuario(administrador.getId());
                LogService sls = new LogService();
                sls.create(log);
            } else {
                mv = new ModelAndView("error");
                mv.addObject("error", "Você não possui permissão para realizar tal ação.");
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/perfil", method = RequestMethod.GET)
    public ModelAndView getAdmPerfil(HttpSession session) {
        ModelAndView mv;
        try {
            Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
            EstadoService es = new EstadoService();
            List<Estado> estados = es.readByCriteria(null, null, null);
            Localizacao localizacao = null;
            LocalizacaoService localizacaoService = new LocalizacaoService();
            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(LocalizacaoCriteria.USUARIO_EQ, adm.getId());
            List<Localizacao> localizacaoList = localizacaoService.readByCriteria(criteria, null, null);
            if (localizacaoList != null && localizacaoList.size() == 1) {
                localizacao = localizacaoList.get(0);
            }
            mv = new ModelAndView("usuario/administrador/perfil");
            mv.addObject("administrador", adm);
            mv.addObject("localizacao", localizacao);
            mv.addObject("estados", estados);
        } catch (Exception e) {
            mv = new ModelAndView("usuario/administrador/perfil");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/perfil", method = RequestMethod.POST)
    public ModelAndView postAdmPerfil(HttpSession session, String nome, String apelido, String senha, String email, String sexo, String nascimento, Long perfil, String telefone,
            Long estado, Long cidade, String bairro, String rua, String numero, String imagem) {

        ModelAndView mv;
        try {
            Administrador adm = (Administrador) session.getAttribute("usuarioSessao");

            adm.setNome(nome);
            adm.setApelido(apelido);
            adm.setEmail(email);
            adm.setSexo(sexo);
            adm.setNascimento(nascimento);
            adm.setPerfil(perfil);
            adm.setTelefone(telefone);
            AdministradorService s = new AdministradorService();
            s.update(adm);

            //TRATANDO A LOCALIZACAO DO ADMIN
            LocalizacaoService sl = new LocalizacaoService();
            Localizacao localizacao = new Localizacao();
            EstadoService es = new EstadoService();
            Estado estadoEntity = es.readById(estado);
            localizacao.setEstado(estadoEntity);
            CidadeService cs = new CidadeService();
            Cidade cidadeEntity = cs.readById(cidade);
            localizacao.setCidade(cidadeEntity);
            localizacao.setBairro(bairro);
            localizacao.setRua(rua);
            localizacao.setNumero(numero);
            localizacao.setUsuario(adm);

            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(LocalizacaoCriteria.USUARIO_EQ, adm.getId());
            List<Localizacao> localizacaoList = new ArrayList<>();
            localizacaoList = sl.readByCriteria(criteria, null, null);
            if (localizacaoList != null && localizacaoList.size() == 1) {
                Localizacao aux = localizacaoList.get(0);
                localizacao.setId(aux.getId());
                sl.update(localizacao);
            } else {
                sl.create(localizacao);
            }

            session.setAttribute("usuarioSessao", adm);
            adm = (Administrador) session.getAttribute("usuarioSessao");
            mv = new ModelAndView("redirect:/administrador/perfil");
            mv.addObject("administrador", adm);

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Edicao de perfil administrador");
            log.setIdEvento(adm.getId());
            log.setIdUsuario(adm.getId());
            LogService sls = new LogService();
            sls.create(log);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/create/api", method = RequestMethod.POST)
    @ResponseBody
    public void create(@RequestBody String administrador, HttpServletResponse response, HttpSession session) {
        try {
//            Type type = new TypeToken<Anunciante>(){                
//            }.getType();
//            Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
            Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
            Administrador adm = (Administrador) session.getAttribute("usuarioSessao");

            Administrador admNew = g.fromJson(administrador, Administrador.class);
            Map<String, Object> fields = new HashMap<>();
            if (admNew != null) {
                AdministradorService s = new AdministradorService();
                admNew.setPerfil(1L);
                SenhaService ss = new SenhaService();
                admNew.setSenha(ss.convertPasswordToMD5(admNew.getSenha()));
                s.create(admNew);

                Log log = new Log();
                Date date = new Date();
//                log.setDataHora(date);
                log.setEvento("Cadastro de administrador");
                log.setIdEvento(admNew.getId());
                log.setIdUsuario(adm.getId());
                LogService sl = new LogService();
                sl.create(log);
                response.setStatus(200);
            }
        } catch (Exception e) {
            response.setStatus(500);
        }
    }

    @RequestMapping(value = "/administrador/imagem-perfil/alterar", method = RequestMethod.GET)
    public ModelAndView getAlterarImagem(HttpSession session) {
        ModelAndView mv = null;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
            mv = new ModelAndView("usuario/administrador/img-perfil");
            mv.addObject("administrador", administrador);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/imagem-perfil/alterar", method = RequestMethod.POST)
    public ModelAndView postAlterarImagem(MultipartFile file, HttpSession session) {
        ModelAndView mv = null;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
            //IMAGEM DO USUARIO
            Imagem imagem = new Imagem();
            imagem.setConteudo(file.getBytes());
            UsuarioService us = new UsuarioService();
            us.setImagem(administrador.getId(), imagem);
            administrador.setImagem(imagem);
            session.setAttribute("administrador", administrador);
            mv = new ModelAndView("redirect:/administrador/perfil");

            Log log = new Log();
                        Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Alteração de imagem administrador");
            log.setIdUsuario(administrador.getId());
            LogService sls = new LogService();
            sls.create(log);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/administrador/list/logs", method = RequestMethod.GET)
    public ModelAndView logList(HttpSession session, Long limit, Long offset) {
        ModelAndView mv = null;
        try {

            if (limit != null && offset != null) {
                Administrador adm = (Administrador) session.getAttribute("usuarioSessao");
                LogService s = new LogService();
                List<Log> logList = s.readByCriteria(null, limit, offset);
                Long count = s.countByCriteria(null, limit, offset);
                mv = new ModelAndView("usuario/administrador/listLog");
                mv.addObject("logList", logList);
                mv.addObject("administrador", adm);
                mv.addObject("count", count);
                mv.addObject("limit", limit);
                mv.addObject("offset", offset);
            } else {
                String redirect = "redirect:/administrador/list/logs?";

                if (limit == null) {
                    redirect += "limit=" + AppConstraints.LIMIT_LIST_LOG + "&offset=0";
                }
                mv = new ModelAndView(redirect);
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

}

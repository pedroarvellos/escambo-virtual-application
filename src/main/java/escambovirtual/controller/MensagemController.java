package escambovirtual.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import escambovirtual.model.criteria.MensagemCriteria;
import escambovirtual.model.entity.Anunciante;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.ItemImagem;
import escambovirtual.model.entity.Mensagem;
import escambovirtual.model.entity.Usuario;
import escambovirtual.model.service.AnuncianteService;
import escambovirtual.model.service.ItemService;
import escambovirtual.model.service.MensagemService;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Joao
 */
@Controller
public class MensagemController {

    @RequestMapping(value = "/anunciante/mensagem/item/{idItem}", method = RequestMethod.GET)
    public ModelAndView getMensagenAnunciante(@PathVariable Long idItem, HttpSession session) {
        ModelAndView mv;
        try {
            Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");
            if (idItem != null) {
                ItemService s = new ItemService();
                Item item = s.readById(idItem);

                if (item != null) {
                    mv = new ModelAndView("mensagem/enviar-msg");
                    mv.addObject("anunciante", anunciante);
                    mv.addObject("item", item);
                } else {
                    mv = new ModelAndView("usuario/anunciante/item/item-not-found");
                    mv.addObject("anunciante", anunciante);
                }
            } else {
                mv = new ModelAndView("usuario/anunciante/item/item-not-found");
                mv.addObject("anunciante", anunciante);
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/mensagem/item/{idItem}", method = RequestMethod.POST)
    public ModelAndView postMensagenAnunciante(@PathVariable Long idItem, HttpSession session, String texto) {
        ModelAndView mv;

        try {
            Mensagem mensagem = new Mensagem();
            ItemService s = new ItemService();
            Item item = s.readById(idItem);
            mensagem.setItem(item);
            mensagem.setDestinatario(item.getAnunciante());
            mensagem.setTexto(texto);
            Anunciante remetente = (Anunciante) session.getAttribute("usuarioSessao");
            mensagem.setRemetente(remetente);

            Date date = new Date();
            mensagem.setData_hora_envio(date);

            MensagemService msgS = new MensagemService();

            msgS.create(mensagem);

            mv = new ModelAndView("redirect:/anunciante/mensagem/list");
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/mensagem/list", method = RequestMethod.GET)
    public ModelAndView getMensagemList(HttpSession session) {
        ModelAndView mv;
        try {
            Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");
            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(MensagemCriteria.USUARIO_SESSAO_ID, anunciante.getId());

            MensagemService s = new MensagemService();
            List<Mensagem> msgList = s.readByCriteria(criteria, null, null);
            if (msgList != null && msgList.size() > 0) {
                for (Mensagem aux : msgList) {
                    ItemService is = new ItemService();
                    aux.setItem(is.readById(aux.getItem().getId()));
                    if (aux.getItem().getItemImagemList() != null && aux.getItem().getItemImagemList().size() > 0) {
                        ItemImagem itemImagem = aux.getItem().getItemImagemList().get(0);
                        List<ItemImagem> itemImagemList = new ArrayList<>();
                        itemImagemList.add(itemImagem);
                        aux.getItem().setItemImagemList(itemImagemList);
                    }
                }
            }
            mv = new ModelAndView("mensagem/list");
            mv.addObject("mensagemList", msgList);
            mv.addObject("anunciante", anunciante);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/mensagem/verifica", method = RequestMethod.POST)
    public @ResponseBody
    List<Mensagem> verificaMensagem(HttpSession session) throws Exception {
        Usuario usuario = (Usuario) session.getAttribute("usuarioSessao");
        List<Mensagem> listMensagem = new ArrayList<>();
        MensagemService s = new MensagemService();
        listMensagem = s.verificaMensagem(usuario);

        return listMensagem;
    }

    @RequestMapping(value = "/anunciante/mensagem/{idMensagem}", method = RequestMethod.GET)
    public ModelAndView getConversa(HttpSession session, @PathVariable Long idMensagem) {
        ModelAndView mv;

        try {
            Anunciante anuncianteSessao = (Anunciante) session.getAttribute("usuarioSessao");
            Anunciante parceiroChat = new Anunciante();
            MensagemService s = new MensagemService();
            Mensagem msg = s.readById(idMensagem);
            if (msg != null) {
                session.setAttribute("mensagem", msg);
                if (msg.getRemetente().getId().equals(anuncianteSessao.getId())) {
                    parceiroChat = msg.getDestinatario();
                } else if (msg.getDestinatario().getId().equals(anuncianteSessao.getId())) {
                    parceiroChat = msg.getRemetente();
                }
//                Map<Long, Object> criteria = new HashMap<>();
//                criteria.put(MensagemCriteria.USUARIO_PARCEIRO_ID, parceiroChat.getId());
//                criteria.put(MensagemCriteria.USUARIO_SESSAO_ID, anuncianteSessao.getId());
//                criteria.put(MensagemCriteria.ITEM_ID, msg.getItem().getId());
//                List<Mensagem> mensagemList = s.readMessageByItemAndAnunciante(criteria);
                AnuncianteService anun = new AnuncianteService();
                parceiroChat = anun.readById(parceiroChat.getId());
                mv = new ModelAndView("mensagem/view-conversa");
//                mv.addObject("mensagemList", mensagemList);
                mv.addObject("mensagem", msg);
                mv.addObject("parceiroChat", parceiroChat);
                mv.addObject("anunciante", anuncianteSessao);
            } else {
                mv = new ModelAndView("error");
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/mensagens", method = RequestMethod.GET)
    @ResponseBody
    public List<Mensagem> getMensagens(HttpSession session, HttpServletResponse response) throws Exception {
        List<Mensagem> mensagemList = new ArrayList<>();
        try {
            Anunciante anuncianteSessao = (Anunciante) session.getAttribute("usuarioSessao");
            Anunciante parceiroChat = new Anunciante();
            MensagemService s = new MensagemService();
            Mensagem msg = (Mensagem) session.getAttribute("mensagem");
//            Mensagem msg = s.readById(idMensagem);
            if (msg != null) {
                if (msg.getRemetente().getId().equals(anuncianteSessao.getId())) {
                    parceiroChat = msg.getDestinatario();
                } else if (msg.getDestinatario().getId().equals(anuncianteSessao.getId())) {
                    parceiroChat = msg.getRemetente();
                }
                Map<Long, Object> criteria = new HashMap<>();
                criteria.put(MensagemCriteria.USUARIO_PARCEIRO_ID, parceiroChat.getId());
                criteria.put(MensagemCriteria.USUARIO_SESSAO_ID, anuncianteSessao.getId());
                criteria.put(MensagemCriteria.ITEM_ID, msg.getItem().getId());
                mensagemList = s.readMessageByItemAndAnunciante(criteria);
                Date date = new Date();
                for (Mensagem mensagem : mensagemList) {
                    if (mensagem.getData_hora_leitura() == null && mensagem.getDestinatario().getId().equals(anuncianteSessao.getId())) {
                        mensagem.setData_hora_leitura(date);
                        s.update(mensagem);
                    }
                }
                AnuncianteService anun = new AnuncianteService();
                parceiroChat = anun.readById(parceiroChat.getId());
                response.setStatus(200);
            } else {
                response.setStatus(500);
            }
        } catch (Exception ex) {
            response.setStatus(500);
        }
        return mensagemList;
    }

    @RequestMapping(value = "/anunciante/enviar/mensagem", method = RequestMethod.POST)
    @ResponseBody
    public void enviarMensagem(@RequestBody String mensagem, HttpServletResponse response, HttpSession session) {
        try {
            Type type = new TypeToken<Mensagem>() {
            }.getType();
            Gson g = new Gson();
            Mensagem mensagemNova = g.fromJson(mensagem, type);

            Anunciante anuncianteSessao = (Anunciante) session.getAttribute("usuarioSessao");
            Mensagem mensagemSessao = (Mensagem) session.getAttribute("mensagem");
//            Mensagem mensagemNova = new Mensagem();
            mensagemNova.setRemetente(anuncianteSessao);
            if (mensagemSessao != null) {
                if (mensagemSessao.getRemetente().getId().equals(anuncianteSessao.getId())) {
                    mensagemNova.setDestinatario(mensagemSessao.getDestinatario());
                } else if (mensagemSessao.getDestinatario().getId().equals(anuncianteSessao.getId())) {
                    mensagemNova.setDestinatario(mensagemSessao.getRemetente());
                }
                Date date = new Date();
                mensagemNova.setData_hora_envio(date);
                mensagemNova.setItem(mensagemSessao.getItem());
                
//                mensagemNova.setTexto(mensagem);

                MensagemService s = new MensagemService();
                s.create(mensagemNova);

                response.setStatus(200);
            }
        } catch (Exception e) {
            response.setStatus(500);
        }
    }

}

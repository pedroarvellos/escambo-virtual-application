package escambovirtual.controller;

import com.google.gson.Gson;
import escambovirtual.model.criteria.CidadeCriteria;
import escambovirtual.model.entity.Administrador;
import escambovirtual.model.entity.Anunciante;
import escambovirtual.model.entity.Cidade;
import escambovirtual.model.entity.Imagem;
import escambovirtual.model.entity.Log;
import escambovirtual.model.entity.Usuario;
import escambovirtual.model.service.CidadeService;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Joao
 */
@Controller
public class UsuarioController {

    @RequestMapping(value = "/usuario/login", method = RequestMethod.POST)
    public ModelAndView login(String email, String senha, HttpSession session) throws Exception {
        UsuarioService s = new UsuarioService();
        SenhaService ss = new SenhaService();
        String senhaMD5 = ss.convertPasswordToMD5(senha);

        ModelAndView mv;

        Usuario usuario = null;
        usuario = s.login(email, senhaMD5);
        if (usuario instanceof Administrador) {
            session.setAttribute("usuarioSessao", usuario);
            mv = new ModelAndView("redirect:/administrador/home");
            mv.addObject("administrador", usuario);

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Login de administrador");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        } else if (usuario instanceof Anunciante) {
            session.setAttribute("usuarioSessao", usuario);
            mv = new ModelAndView("redirect:/anunciante/home");
            mv.addObject("anunciante", usuario);

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Login de anunciante");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        } else {
            mv = new ModelAndView("redirect:/index");
            mv.addObject("erro", 1);
        }

        return mv;
    }

    @RequestMapping(value = "/usuario/login/mobile", method = RequestMethod.GET)
    public ModelAndView getLoginMobile() {
        ModelAndView mv = new ModelAndView("usuario/login-mobile");

        return mv;
    }

    @RequestMapping(value = "/usuario/login/mobile", method = RequestMethod.POST)
    public ModelAndView postLoginMobile(String email, String senha, HttpSession session) throws Exception {
        UsuarioService s = new UsuarioService();
        SenhaService ss = new SenhaService();
        String senhaMD5 = ss.convertPasswordToMD5(senha);

        ModelAndView mv;

        Usuario usuario = null;
        usuario = s.login(email, senhaMD5);
        if (usuario instanceof Administrador) {
            session.setAttribute("usuarioSessao", usuario);
            mv = new ModelAndView("redirect:/administrador/home");
            mv.addObject("administrador", usuario);

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Login via mobile de administrador");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        } else if (usuario instanceof Anunciante) {
            session.setAttribute("usuarioSessao", usuario);
            mv = new ModelAndView("redirect:/anunciante/home");
            mv.addObject("anunciante", usuario);

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Login via mobile de anunciante");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        } else {
            mv = new ModelAndView("redirect:/index");
            mv.addObject("erro", 1);
        }

        return mv;
    }

    @RequestMapping(value = "/sair", method = RequestMethod.GET)
    public ModelAndView logout(HttpSession session) throws Exception {
        Usuario usuario = (Usuario) session.getAttribute("usuarioSessao");

        Log log = new Log();

        if (usuario instanceof Administrador) {

            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Logout de administrador");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);

        } else if (usuario instanceof Anunciante) {

            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Logout de anunciante");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        }

        ModelAndView mv = new ModelAndView("/../../index");
        session.removeAttribute("usuarioSessao");
        return mv;
    }

    @RequestMapping(value = "/usuario/recuperar-senha", method = RequestMethod.POST)
    public ModelAndView recuperarSenha(String emailRecuperacao, HttpSession session) throws Exception {
        ModelAndView mv;

        UsuarioService s = new UsuarioService();
        Usuario usuario = s.recuperarSenha(emailRecuperacao);

        if (usuario != null) {
            mv = new ModelAndView("redirect:/index");

            Log log = new Log();
            Date date = new Date();
//            log.setDataHora(date);
            log.setEvento("Recuperação de senha");
            log.setIdEvento(usuario.getId());
            log.setIdUsuario(usuario.getId());
            LogService sl = new LogService();
            sl.create(log);
        } else {
            mv = new ModelAndView("redirect:/index");
            mv.addObject("erro", 1);
        }

        return mv;
    }

    //método é mapeado caso o usuário não tenha permissão para acessar
    //determinada área do sistema
    @RequestMapping(value = "/anunciante/permissao-negada", method = RequestMethod.GET)
    public ModelAndView permissaoNegadaAnunciante(HttpSession session) {
        Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");
        ModelAndView mv = new ModelAndView("usuario/anunciante/permissao-negada");
        mv.addObject("anunciante", anunciante);
        return mv;
    }

    @RequestMapping(value = "/administrador/permissao-negada", method = RequestMethod.GET)
    public ModelAndView permissaoNegadaAdm(HttpSession session) {
        Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
        ModelAndView mv = new ModelAndView("usuario/administrador/permissao-negada");
        mv.addObject("administrador", administrador);
        return mv;
    }

    @RequestMapping(value = "/usuario/check/email", method = RequestMethod.POST)
    @ResponseBody
    public String checkEmail(@RequestBody String email, HttpServletResponse response) {
        String result = null;
        Boolean emailOk = null;
        Gson g = new Gson();
        Map<String, Object> resultado = new HashMap<>();
        try {
            if (!email.equals("")) {
                UsuarioService us = new UsuarioService();
                emailOk = us.checkEmailUsuario(email);
            }

            if (emailOk == false) {
                resultado.put("result", "exist");
                result = g.toJson(resultado);
            } else if (emailOk == true) {
                resultado.put("result", "not");
                result = g.toJson(resultado);
            }
            response.setStatus(200);
        } catch (Exception e) {
            response.setStatus(500);
            e.printStackTrace();
            resultado.put("result", "null");
            result = g.toJson(resultado);
        }
        return result;
    }

    @RequestMapping(value = "/usuario/cidades/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String getEstados(HttpServletResponse response, @PathVariable Long id) {
        List<Cidade> cidadeList = new ArrayList<>();
        String cidades = null;
        try {

            CidadeService cs = new CidadeService();
            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(CidadeCriteria.ESTADO_FK, id);
            cidadeList = cs.readByCriteria(criteria, null, null);

            Gson g = new Gson();
            cidades = g.toJson(cidadeList);

            response.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
        }
        return cidades;
    }

    @RequestMapping(value = "/usuario/{id}/img.jpg", method = RequestMethod.GET)
    public void streamImagem(@PathVariable Long id, HttpServletResponse response) throws Exception {
        UsuarioService s = new UsuarioService();
        Imagem imagem = s.getImagem(id);
        response.setContentType("imagem/jpg");
        response.getOutputStream().write(imagem.getConteudo());
        response.flushBuffer();
    }
}

package escambovirtual.controller;

import escambovirtual.model.criteria.TrocaCriteria;
import escambovirtual.model.entity.Anunciante;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.Log;
import escambovirtual.model.entity.Oferta;
import escambovirtual.model.entity.Troca;
import escambovirtual.model.service.LogService;
import escambovirtual.model.service.OfertaService;
import escambovirtual.model.service.TrocaService;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Joao
 */
@Controller
public class TrocaController {

    //aceitar a oferta para realizar a troca
    @RequestMapping(value = "/anunciante/oferta/{id}/aceitar", method = RequestMethod.POST)
    public ModelAndView postAceitarOferta(@PathVariable Long id, HttpSession session) {
        ModelAndView mv = null;
        try {
            Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");

            OfertaService os = new OfertaService();
            Oferta oferta = os.readById(id);
            if (oferta != null) {

                Troca troca = new Troca();
                troca.setOferta(oferta);
                troca.setUsuario1(oferta.getItem().getAnunciante());
                Item itemOfertado = oferta.getOfertaItem().getItemList().get(0);
                troca.setUsuario2(itemOfertado.getAnunciante());

                Date date = new Date();
                troca.setData_hora(date);
                troca.setStatus("Realizada");

                TrocaService ts = new TrocaService();
                ts.create(troca);

                mv = new ModelAndView("redirect:/anunciante/troca/list");

                Log log = new Log();
//                log.setDataHora(date);
                log.setEvento("Aceite de Oferta - Troca Realizada");
                log.setIdEvento(id);
                log.setIdUsuario(anunciante.getId());
                LogService sl = new LogService();
                sl.create(log);
            } else {
                mv = new ModelAndView("oferta/oferta-not-found");
            }

        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/troca/list", method = RequestMethod.GET)
    public ModelAndView getListTroca(HttpSession session) {
        ModelAndView mv;
        try {
            Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");
            TrocaService ts = new TrocaService();

            Map<Long, Object> criteria = new HashMap<>();
            criteria.put(TrocaCriteria.ANUNCIANTE_EQ, anunciante.getId());

            List<Troca> trocaList = ts.readByCriteria(criteria, null, null);

            mv = new ModelAndView("troca/list");
            mv.addObject("trocaList", trocaList);
            mv.addObject("anunciante", anunciante);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/troca/{id}", method = RequestMethod.GET)
    public ModelAndView getDetalhesTroca(@PathVariable Long id, HttpSession session) {
        ModelAndView mv;
        try {
            Anunciante anunciante = (Anunciante) session.getAttribute("usuarioSessao");
            TrocaService s = new TrocaService();
            Troca troca = s.readById(id);
            if (troca != null) {
                if (troca.getUsuario1().getId().equals(anunciante.getId()) || troca.getUsuario2().getId().equals(anunciante.getId())) {

                    mv = new ModelAndView("troca/view");
                    mv.addObject("anunciante", anunciante);
                    mv.addObject("troca", troca);
                } else {
                    mv = new ModelAndView("troca/error");
                    mv.addObject("anunciante", anunciante);
                }
            } else {
                mv = new ModelAndView("troca/error");
                mv.addObject("anunciante", anunciante);
            }
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }

    @RequestMapping(value = "/anunciante/troca/view/item", method = RequestMethod.GET)
    public ModelAndView getItemTroca(HttpSession session, @PathVariable Long idTroca) {
        ModelAndView mv;
        try {
            mv = new ModelAndView();
        } catch (Exception e) {
            mv = new ModelAndView();
        }
        return mv;
    }
}

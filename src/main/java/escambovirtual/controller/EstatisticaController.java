package escambovirtual.controller;

import escambovirtual.model.entity.Administrador;
import escambovirtual.model.entity.EstatisticaGeral;
import escambovirtual.model.entity.EstatisticaRegiao;
import escambovirtual.model.service.EstatisticaService;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Joao
 */
@Controller
public class EstatisticaController {

    @RequestMapping(value = "/administrador/estatisticas-sistema", method = RequestMethod.GET)
    public ModelAndView estatisticas(Integer opcao, HttpSession session) throws Exception {
        ModelAndView mv = null;
        try {
            Administrador administrador = (Administrador) session.getAttribute("usuarioSessao");
            EstatisticaService s = new EstatisticaService();
            EstatisticaGeral estatistica = new EstatisticaGeral(); 
            List<EstatisticaRegiao> estatisticaRegiaoList = new ArrayList<>();
            if (opcao != null) {
                switch (opcao) {
                    case 1:
                        estatistica = s.infoItem();
                        break;
                    case 2:
                        estatistica = s.infoUsuario();
                        break;
                    case 3: estatisticaRegiaoList = s.infoRegiao();
                        break;
                    default:
                        break;
                }
            }

            mv = new ModelAndView("estatistica/estatistica");
            mv.addObject("administrador", administrador);
            mv.addObject("estatistica", estatistica);
            mv.addObject("infoEstado", estatisticaRegiaoList);
            mv.addObject("opcao", opcao);
        } catch (Exception e) {
            mv = new ModelAndView("error");
            mv.addObject("error", e);
        }
        return mv;
    }
}

package escambovirtual.model.service;

import escambovirtual.model.ConnectionManager;
import escambovirtual.model.base.service.BaseEstatisticaService;
import escambovirtual.model.criteria.ItemCriteria;
import escambovirtual.model.criteria.UsuarioCriteria;
import escambovirtual.model.dao.EstadoDAO;
import escambovirtual.model.dao.EstatisticaDAO;
import escambovirtual.model.dao.ItemDAO;
import escambovirtual.model.dao.UsuarioDAO;
import escambovirtual.model.entity.Estado;
import escambovirtual.model.entity.EstatisticaGeral;
import escambovirtual.model.entity.EstatisticaRegiao;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Joao
 */
public class EstatisticaService implements BaseEstatisticaService {

    @Override
    public EstatisticaGeral infoItem() throws Exception {
        EstatisticaGeral infoItens = new EstatisticaGeral();
        Connection conn = ConnectionManager.getInstance().getConnection();      
        try{
            Map<Long, Object> criteria = new HashMap<>();
            ItemDAO dao = new ItemDAO();
            criteria.put(ItemCriteria.STATUS_EQ, "Publicar");            
            infoItens.setItemPublicado(dao.countByCriteria(conn, criteria, null, null));
            criteria.clear();
            criteria.put(ItemCriteria.STATUS_EQ, "Em Avaliação");
            infoItens.setItemEmAvaliacao(dao.countByCriteria(conn, criteria, null, null));
            criteria.clear();
            criteria.put(ItemCriteria.STATUS_EQ, "Não Publicar");
            infoItens.setItemNaoPublicado(dao.countByCriteria(conn, criteria, null, null));
            criteria.clear();
            criteria.put(ItemCriteria.STATUS_EQ, "Trocado");
            infoItens.setItemTrocado(dao.countByCriteria(conn, criteria, null, null));
            infoItens.setItemTotal(dao.countByCriteria(conn, null, null, null));
            
            conn.commit();
            conn.close();
        }catch(Exception e){
            conn.rollback();
            conn.close();
        }
        return infoItens;
    }

    @Override
    public EstatisticaGeral infoUsuario() throws Exception {
        EstatisticaGeral infoItens = new EstatisticaGeral();
        Connection conn = ConnectionManager.getInstance().getConnection();      
        try{
            Map<Long, Object> criteria = new HashMap<>();
            UsuarioDAO dao = new UsuarioDAO();
            criteria.put(UsuarioCriteria.ADMINISTRADOR, true);
            infoItens.setUsuarioAdm(dao.countByCriteria(conn, criteria, null, null));
            criteria.clear();
            criteria.put(UsuarioCriteria.ANUNCIANTE, true);
            infoItens.setUsuarioAnunciante(dao.countByCriteria(conn, criteria, null, null));
            infoItens.setUsuarioTotal(dao.countByCriteria(conn, null, null, null));            
            
            conn.commit();
            conn.close();
        }catch(Exception e){
            conn.rollback();
            conn.close();
        }
        return infoItens;
    }

    @Override
    public List<EstatisticaRegiao> infoRegiao() throws Exception {
        List<EstatisticaRegiao> estatisticaRegiaoList = new ArrayList<>();
        Connection conn = ConnectionManager.getInstance().getConnection();
        try{
            EstatisticaDAO dao = new EstatisticaDAO();
            estatisticaRegiaoList = dao.infoRegiao(conn);
            conn.commit();
            conn.close();
        }catch(Exception e){
            conn.rollback();
            conn.close();
        }
        return estatisticaRegiaoList;
    }
    
}

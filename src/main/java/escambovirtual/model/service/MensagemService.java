package escambovirtual.model.service;

import escambovirtual.model.ConnectionManager;
import escambovirtual.model.base.service.BaseMensagemService;
import escambovirtual.model.dao.MensagemDAO;
import escambovirtual.model.entity.Mensagem;
import escambovirtual.model.entity.Usuario;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joao
 */
public class MensagemService implements BaseMensagemService {

    @Override
    public void create(Mensagem entity) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            MensagemDAO dao = new MensagemDAO();
            dao.create(conn, entity);
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
    }

    @Override
    public Mensagem readById(Long id) throws Exception {
        Mensagem mensagem = null;

        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            MensagemDAO dao = new MensagemDAO();
            mensagem = dao.readById(conn, id);
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return mensagem;
    }

    @Override
    public List<Mensagem> readByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        List<Mensagem> mensagemList = new ArrayList<>();
        try {
            MensagemDAO dao = new MensagemDAO();
            mensagemList = dao.readByCriteria(conn, criteria, limit, offset);            
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return mensagemList;
    }

    @Override
    public void update(Mensagem entity) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            MensagemDAO dao = new MensagemDAO();
            dao.update(conn, entity);
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
    }

    @Override
    public void delete(Long id) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Long countByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<Mensagem> verificaMensagem(Usuario usuario) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        List<Mensagem> mensagemList = new ArrayList<>();
        try {
            MensagemDAO dao = new MensagemDAO();
            mensagemList = dao.verificaMensagem(usuario, conn);
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return mensagemList;
    }

    @Override
    public Map<String, String> validate(Map<String, Object> fields) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<Mensagem> readMessageByItemAndAnunciante(Map<Long, Object> criteria) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        List<Mensagem> mensagemList = new ArrayList<>();
        try {
            MensagemDAO dao = new MensagemDAO();
            mensagemList = dao.readMessageByItemAndAnunciante(conn, criteria);           
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return mensagemList;
    }

}

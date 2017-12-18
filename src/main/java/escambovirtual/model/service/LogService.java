package escambovirtual.model.service;

import escambovirtual.model.ConnectionManager;
import escambovirtual.model.base.service.BaseLogService;
import escambovirtual.model.dao.LogDAO;
import escambovirtual.model.entity.Log;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class LogService implements BaseLogService{

    @Override
    public void create(Log entity) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            LogDAO dao = new LogDAO();
            dao.create(conn, entity);
            conn.commit();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
        }
    }

    @Override
    public Log readById(Long id) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Log> readByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        List<Log> logList = null;

        try {
            LogDAO dao = new LogDAO();
            if (criteria == null) {
                criteria = new HashMap<>();
            }
            
            logList = (List) dao.readByCriteria(conn, criteria, limit, offset);
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
        }

        return logList;
    }

    @Override
    public void update(Log entity) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Long id) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Long countByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        Long count = null;
        try {
            LogDAO dao = new LogDAO();
            count = dao.countByCriteria(conn, criteria, limit, offset);
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return count;
    
    }

    @Override
    public Map<String, String> validate(Map<String, Object> fields) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}

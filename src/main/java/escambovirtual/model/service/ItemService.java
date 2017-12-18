package escambovirtual.model.service;

import escambovirtual.model.ConnectionManager;
import escambovirtual.model.base.service.BaseItemService;
import escambovirtual.model.dao.ItemDAO;
import escambovirtual.model.entity.Cidade;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.ItemImagem;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Joao
 */
public class ItemService implements BaseItemService {

    @Override
    public void create(Item entity) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            ItemDAO dao = new ItemDAO();
            dao.create(conn, entity);
            List<ItemImagem> itemImagemList = entity.getItemImagemList();
            if (itemImagemList != null) {
                for (ItemImagem itemImagem : itemImagemList) {
                    itemImagem.setItem(entity);
                    dao.createImage(conn, itemImagem);
                }
            }
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
    }

    @Override
    public Item readById(Long id) throws Exception {
        Item item = null;

        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            ItemDAO dao = new ItemDAO();
            item = dao.readById(conn, id);
            if (item != null) {
                item.setItemImagemList(dao.readImagesHashByItemId(conn, item.getId()));
            }
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return item;
    }

    @Override
    public List<Item> readByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        List<Item> itemList = null;
        try {
            ItemDAO dao = new ItemDAO();
            itemList = dao.readByCriteria(conn, criteria, limit, offset);
            if (itemList != null) {
                for (Item item : itemList) {
                    item.setItemImagemList(dao.readImagesHashByItemId(conn, item.getId()));
                }
            }
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
        return itemList;
    }

    @Override
    public void update(Item entity) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            ItemDAO dao = new ItemDAO();
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
        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            ItemDAO dao = new ItemDAO();
            dao.delete(conn, id);
            conn.commit();
            conn.close();
        } catch (Exception e) {
            conn.rollback();
            conn.close();
            throw e;
        }
    }

    @Override
    public Map<String, String> validate(Map<String, Object> fields) throws Exception {
        Map<String, String> errors = new HashMap<>();
        
        String nome = (String) fields.get("nome");
        if(nome == null || nome.trim().isEmpty()){
            errors.put("nome", "É necessário que você dê um nome ao item!");
        }
        
        String data = (String) fields.get("data_aquisicao");
        if(data == null){
            errors.put("data", "Coloque ao menos uma data aproximada");
        }
        
        String descricao = (String) fields.get("descricao");
        if(descricao == null || descricao.trim().isEmpty()){
            errors.put("descricao", "Coloque uma simples descrição...");
        }
        
        Cidade cidade = (Cidade) fields.get("cidade");
        if(cidade == null){
            errors.put("cidade", "Precisamos que você coloque uma localização para que outras pessoas possam encontrar seu item!");            
        }
        
        return errors;
    }

    @Override
    public Long countByCriteria(Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Connection conn = ConnectionManager.getInstance().getConnection();
        Long count = null;
        try {
            ItemDAO dao = new ItemDAO();
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

    public ItemImagem readImageByHash(String hash) throws Exception {

        ItemImagem itemImagem = null;

        Connection conn = ConnectionManager.getInstance().getConnection();
        try {
            ItemDAO dao = new ItemDAO();
            itemImagem = dao.readImageByHash(conn, hash);
            conn.close();
        } catch (Exception e) {
            conn.close();
            throw e;
        }

        return itemImagem;
    }

}

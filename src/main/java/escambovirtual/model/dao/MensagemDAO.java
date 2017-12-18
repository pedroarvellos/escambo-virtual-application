package escambovirtual.model.dao;

import com.sun.mail.imap.protocol.INTERNALDATE;
import escambovirtual.model.base.BaseDAO;
import escambovirtual.model.criteria.MensagemCriteria;
import escambovirtual.model.entity.Anunciante;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.Mensagem;
import escambovirtual.model.entity.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Joao
 */
public class MensagemDAO implements BaseDAO<Mensagem> {

    @Override
    public void create(Connection conn, Mensagem entity) throws Exception {
        String sql = "INSERT INTO mensagem(data_hora_envio, texto, remetente_fk, destinatario_fk, item_fk) VALUES (?, ?, ?, ?, ?) RETURNING id";

        PreparedStatement ps = conn.prepareStatement(sql);

        int i = 0;
        ps.setTimestamp(++i, new Timestamp(entity.getData_hora_envio().getTime()));

        ps.setString(++i, entity.getTexto());
        ps.setLong(++i, entity.getRemetente().getId());
        ps.setLong(++i, entity.getDestinatario().getId());
        ps.setLong(++i, entity.getItem().getId());

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            entity.setId(rs.getLong("id"));
        }

        rs.close();
        ps.close();
    }

    @Override
    public Mensagem readById(Connection conn, Long id) throws Exception {
        String sql = "SELECT mensagem.*, item.id item_id, item.nome item_nome FROM mensagem left join item on item.id = mensagem.item_fk WHERE mensagem.id=?";

        Mensagem mensagem = null;
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            mensagem = new Mensagem();

            mensagem.setId(rs.getLong("id"));
            mensagem.setTexto(rs.getString("texto"));
            
            Item item = new Item();
            item.setId(rs.getLong("item_id"));
            item.setNome(rs.getString("item_nome"));
            mensagem.setItem(item);

            mensagem.setDestinatario(new Anunciante(rs.getLong("destinatario_fk")));
            mensagem.setRemetente(new Anunciante(rs.getLong("remetente_fk")));

            mensagem.setData_hora_envio(new Date(rs.getTimestamp("data_hora_envio").getTime()));
            if (rs.getObject("data_hora_leitura") != null) {
                mensagem.setData_hora_leitura(new Date(rs.getTimestamp("data_hora_leitura").getTime()));
            }
        }

        rs.close();
        ps.close();

        return mensagem;
    }

    @Override
    public List<Mensagem> readByCriteria(Connection conn, Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        String sql = "with "
                + "itens as ("
                + "select max(id) from mensagem group by item_fk"
                + ")"
                + "select * from mensagem where ( remetente_fk = ? or destinatario_fk = ? ) and id in (select * from itens)";

        PreparedStatement ps = conn.prepareStatement(sql);
        int i = 0;
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_SESSAO_ID));
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_SESSAO_ID));

        ResultSet rs = ps.executeQuery();
        List<Mensagem> msgList = new ArrayList<>();
        while (rs.next()) {
            Mensagem mensagem = new Mensagem();

            mensagem.setId(rs.getLong("id"));
            mensagem.setTexto(rs.getString("texto"));

            mensagem.setDestinatario(new Anunciante(rs.getLong("destinatario_fk")));
            Item item = new Item();
            item.setId(rs.getLong("item_fk"));
            mensagem.setItem(item);

            UsuarioDAO userDAO = new UsuarioDAO();
            Anunciante remetente = (Anunciante) userDAO.readById(conn, rs.getLong("remetente_fk"));
            mensagem.setRemetente(remetente);

            mensagem.setData_hora_envio(new Date(rs.getTimestamp("data_hora_envio").getTime()));

            if (rs.getObject("data_hora_leitura") != null) {
                mensagem.setData_hora_leitura(new Date(rs.getTimestamp("data_hora_leitura").getTime()));
            }

            msgList.add(mensagem);
        }

        rs.close();
        ps.close();

        return msgList;
    }

    @Override
    public void update(Connection conn, Mensagem entity) throws Exception {
        String sql = "UPDATE mensagem SET data_hora_leitura=? WHERE id=?";

        PreparedStatement ps = conn.prepareStatement(sql);

        int i = 0;
        ps.setTimestamp(++i, new Timestamp(entity.getData_hora_leitura().getTime()));

        ps.setLong(++i, entity.getId());

        ps.execute();
        ps.close();
    }

    @Override
    public void delete(Connection conn, Long id) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Long countByCriteria(Connection conn, Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<Mensagem> verificaMensagem(Usuario usuario, Connection conn) throws Exception {
        String sql = "select * from mensagem where destinatario_fk=? and data_hora_leitura is null ";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, usuario.getId());

        ResultSet rs = ps.executeQuery();
        List<Mensagem> mensagemList = new ArrayList<>();
        while (rs.next()) {
            Mensagem mensagem = new Mensagem();

            mensagem.setId(rs.getLong("id"));
            mensagem.setTexto(rs.getString("texto"));

            mensagem.setDestinatario(new Anunciante(rs.getLong("destinatario_fk")));
            mensagem.setRemetente(new Anunciante(rs.getLong("remetente_fk")));

            mensagem.setData_hora_envio(new Date(rs.getTimestamp("data_hora_envio").getTime()));
            if (rs.getObject("data_hora_leitura") != null) {
                mensagem.setData_hora_leitura(new Date(rs.getTimestamp("data_hora_leitura").getTime()));
            }

            mensagemList.add(mensagem);
        }
        rs.close();
        ps.close();

        return mensagemList;
    }

    public List<Mensagem> readMessageByItemAndAnunciante(Connection conn, Map<Long, Object> criteria) throws Exception {
        String sql = "select mensagem.*, usuario.id usuario_id, usuario.nome usuario_nome from mensagem left join usuario on usuario.id = mensagem.remetente_fk where remetente_fk = ? and destinatario_fk = ? and item_fk = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        int i = 0;
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_SESSAO_ID));
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_PARCEIRO_ID));
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.ITEM_ID));

        ResultSet rs = ps.executeQuery();
        List<Mensagem> mensagemList = new ArrayList<>();
        while (rs.next()) {
            Mensagem mensagem = new Mensagem();

            mensagem.setId(rs.getLong("id"));
            mensagem.setTexto(rs.getString("texto"));

            mensagem.setDestinatario(new Anunciante(rs.getLong("destinatario_fk")));
            
            Anunciante remetente = new Anunciante();
            remetente.setId(rs.getLong("usuario_id"));
            remetente.setNome(rs.getString("usuario_nome"));
            mensagem.setRemetente(remetente);

            mensagem.setData_hora_envio(new Date(rs.getTimestamp("data_hora_envio").getTime()));
            if (rs.getObject("data_hora_leitura") != null) {
                mensagem.setData_hora_leitura(new Date(rs.getTimestamp("data_hora_leitura").getTime()));
            }

            mensagemList.add(mensagem);
        }
        
        sql = "select mensagem.*, usuario.id usuario_id, usuario.nome usuario_nome from mensagem left join usuario on usuario.id = mensagem.remetente_fk where remetente_fk = ? and destinatario_fk = ? and item_fk = ?";
        ps = conn.prepareStatement(sql);
        i = 0;
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_PARCEIRO_ID));
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.USUARIO_SESSAO_ID));
        ps.setLong(++i, (Long) criteria.get(MensagemCriteria.ITEM_ID));

        rs = ps.executeQuery();
        
        while (rs.next()) {
            Mensagem mensagem = new Mensagem();

            mensagem.setId(rs.getLong("id"));
            mensagem.setTexto(rs.getString("texto"));

            mensagem.setDestinatario(new Anunciante(rs.getLong("destinatario_fk")));
            
            Anunciante remetente = new Anunciante();
            remetente.setId(rs.getLong("usuario_id"));
            remetente.setNome(rs.getString("usuario_nome"));
            mensagem.setRemetente(remetente);

            mensagem.setData_hora_envio(new Date(rs.getTimestamp("data_hora_envio").getTime()));
            if (rs.getObject("data_hora_leitura") != null) {
                mensagem.setData_hora_leitura(new Date(rs.getTimestamp("data_hora_leitura").getTime()));
            }

            mensagemList.add(mensagem);
        }
        rs.close();
        ps.close();

        return mensagemList;
    }

    @Override
    public String applyCriteria(Connection conn, Map<Long, Object> criteria) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

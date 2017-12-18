package escambovirtual.model.dao;

import escambovirtual.model.base.BaseDAO;
import escambovirtual.model.criteria.OfertaCriteria;
import escambovirtual.model.entity.Anunciante;
import escambovirtual.model.entity.Cidade;
import escambovirtual.model.entity.Estado;
import escambovirtual.model.entity.Item;
import escambovirtual.model.entity.Oferta;
import escambovirtual.model.entity.OfertaItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Joao
 */
public class OfertaDAO implements BaseDAO<Oferta> {

    @Override
    public void create(Connection conn, Oferta entity) throws Exception {
        String sql = "INSERT INTO oferta(data_hora, item_fk, status) VALUES (?, ?, ?) RETURNING id";

        PreparedStatement ps = conn.prepareStatement(sql);
        int i = 0;
        ps.setTimestamp(++i, new Timestamp(entity.getDataOferta().getTime()));
        ps.setLong(++i, entity.getItem().getId());
        ps.setString(++i, entity.getStatus());

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            entity.setId(rs.getLong("id"));
        }
        rs.close();
        ps.close();

        createOfertaItem(conn, entity);
    }

    public void createOfertaItem(Connection conn, Oferta entity) throws Exception {
        String sql = "INSERT INTO oferta_item(oferta_fk, item_fk, item)VALUES (?, ?, ?) RETURNING id";
        PreparedStatement ps = conn.prepareStatement(sql);

        if (entity.getOfertaItem().getItemList() != null && entity.getOfertaItem().getItemList().size() > 0) {
            for (Item aux : entity.getOfertaItem().getItemList()) {
                int i = 0;
                ps.setLong(++i, entity.getId());
                ps.setLong(++i, aux.getId());
                ps.setString(++i, entity.getOfertaItem().getItemDescrito());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    entity.getOfertaItem().setId(rs.getLong("id"));
                }
                rs.close();
            }
            ps.close();
        } else {
            int i = 0;
            ps.setLong(++i, entity.getId());
            ps.setNull(++i, Types.BIGINT);
            ps.setString(++i, entity.getOfertaItem().getItemDescrito());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                entity.getOfertaItem().setId(rs.getLong("id"));
            }
            rs.close();
            ps.close();
        }
    }

    @Override
    public Oferta readById(Connection conn, Long id) throws Exception {
        String sql = "SELECT oferta.id oferta_id, oferta.status oferta_status, oferta.data_hora oferta_data_hora, oferta.item_fk, item.id item_id, item.nome item_nome, item.descricao item_descricao, item.data_compra item_data_compra, item.estado_fk item_estado_fk, item.cidade_fk item_cidade_fk, item.data_hora_cadastro item_data_cadastro, usuario.id anunciante_id, usuario.nome anunciante_nome, usuario.email anunciante_email, usuario.apelido anunciante_apelido, anunciante.reputacao anunciante_reputacao, cidade.id cidade_id, cidade.nome cidade_nome, estado.id estado_id, estado.nome estado_nome, estado.uf estado_uf FROM oferta left join item on item.id=oferta.item_fk left join anunciante on anunciante.usuario_fk=item.usuario_fk left join usuario on usuario.id=anunciante.usuario_fk left join cidade on cidade.id=item.cidade_fk left join estado on estado.id=item.estado_fk where oferta.id=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setLong(1, id);
        ResultSet rs = ps.executeQuery();
        Oferta oferta = null;
        if (rs.next()) {
            oferta = new Oferta();
            oferta.setId(rs.getLong("oferta_id"));
            oferta.setDataOferta(rs.getDate("oferta_data_hora"));
            oferta.setStatus(rs.getString("oferta_status"));
            Item item = new Item();
            item.setId(rs.getLong("item_id"));
            String data[] = rs.getString("item_data_compra").split("-");
            String data2 = data[2] + "/" + data[1] + "/" + data[0];
            item.setDataAquisicao(data2);
            data = rs.getString("item_data_cadastro").split("-");
            data2 = data[2] + "/" + data[1] + "/" + data[0];
            item.setDataCadastro(data2);

            Estado estado = new Estado();
            estado.setId(rs.getLong("estado_id"));
            estado.setNome(rs.getString("estado_nome"));
            estado.setUf(rs.getString("estado_uf"));
            Cidade cidade = new Cidade();
            cidade.setId(rs.getLong("cidade_id"));
            cidade.setNome(rs.getString("cidade_nome"));
            cidade.setEstado(estado);

            item.setCidade(cidade);

            item.setNome(rs.getString("item_nome"));
            item.setDescricao(rs.getString("item_descricao"));

            Anunciante anunciante = new Anunciante();
            anunciante.setId(rs.getLong("anunciante_id"));
            anunciante.setApelido(rs.getString("anunciante_apelido"));
            anunciante.setNome(rs.getString("anunciante_nome"));
            anunciante.setEmail(rs.getString("anunciante_email"));
            anunciante.setReputacao(rs.getInt("anunciante_reputacao"));

            item.setAnunciante(anunciante);
            oferta.setItem(item);

            //buscando os itens ou o item descrito da oferta
            sql = "select oferta_item.id of_item_id, oferta_item.oferta_fk of_item_oferta, oferta_item.item of_item_item_descrito, item.id item_id, item.nome item_nome, item.data_compra item_data_compra, item.estado_fk item_estado_fk, item.cidade_fk item_cidade_fk, item.data_hora_cadastro item_data_cadastro,  item.descricao item_descricao, usuario.id anunciante_id, usuario.nome anunciante_nome, usuario.email anunciante_email, usuario.apelido anunciante_apelido, usuario.telefone anunciante_telefone, anunciante.reputacao anunciante_reputacao, cidade.id cidade_id, cidade.nome cidade_nome, estado.id estado_id, estado.nome estado_nome, estado.uf estado_uf from oferta_item left join oferta on oferta.id=oferta_item.oferta_fk left join item on item.id=oferta_item.item_fk left join anunciante on anunciante.usuario_fk=item.usuario_fk left join usuario on usuario.id=anunciante.usuario_fk left join cidade on cidade.id=item.cidade_fk left join estado on estado.id=item.estado_fk where oferta_item.oferta_fk=?";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, oferta.getId());

            rs = ps.executeQuery();
            OfertaItem ofertaItem = new OfertaItem();
            while (rs.next()) {
                ofertaItem.setId(rs.getLong("of_item_id"));
                ofertaItem.setItemDescrito(rs.getString("of_item_item_descrito"));

                item = new Item();
                item.setId(rs.getLong("item_id"));
                item.setNome(rs.getString("item_nome"));
                data = rs.getString("item_data_compra").split("-");
                data2 = data[2] + "/" + data[1] + "/" + data[0];
                item.setDataAquisicao(data2);
                data = rs.getString("item_data_cadastro").split("-");
                data2 = data[2] + "/" + data[1] + "/" + data[0];
                item.setDataCadastro(data2);

                estado = new Estado();
                estado.setId(rs.getLong("estado_id"));
                estado.setNome(rs.getString("estado_nome"));
                estado.setUf(rs.getString("estado_uf"));
                cidade = new Cidade();
                cidade.setId(rs.getLong("cidade_id"));
                cidade.setNome(rs.getString("cidade_nome"));
                cidade.setEstado(estado);

                item.setCidade(cidade);

                item.setDescricao(rs.getString("item_descricao"));
                anunciante = new Anunciante();
                anunciante.setId(rs.getLong("anunciante_id"));
                anunciante.setApelido(rs.getString("anunciante_apelido"));
                anunciante.setNome(rs.getString("anunciante_nome"));
                anunciante.setEmail(rs.getString("anunciante_email"));
                anunciante.setTelefone(rs.getString("anunciante_telefone"));
                anunciante.setReputacao(rs.getInt("anunciante_reputacao"));
                item.setAnunciante(anunciante);

                ofertaItem.getItemList().add(item);

            }
            oferta.setOfertaItem(ofertaItem);

        }
        rs.close();
        ps.close();
        return oferta;
    }

    @Override
    public List<Oferta> readByCriteria(Connection conn, Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        String sql = "SELECT oferta.id oferta_id, oferta.status oferta_status, oferta.data_hora oferta_data_hora, oferta.item_fk, item.id item_id, item.nome item_nome, item.descricao item_descricao, item.data_compra item_data_compra, item.estado_fk item_estado_fk, item.cidade_fk item_cidade_fk, item.data_hora_cadastro item_data_cadastro, usuario.id anunciante_id, usuario.nome anunciante_nome, usuario.email anunciante_email, usuario.apelido anunciante_apelido, anunciante.reputacao anunciante_reputacao, cidade.id cidade_id, cidade.nome cidade_nome, estado.id estado_id, estado.nome estado_nome, estado.uf estado_uf  FROM oferta left join item on item.id=oferta.item_fk left join anunciante on anunciante.usuario_fk=item.usuario_fk left join usuario on usuario.id=anunciante.usuario_fk left join cidade on cidade.id=item.cidade_fk left join estado on estado.id=item.estado_fk  where 1=1";

        sql += applyCriteria(conn, criteria);

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();
        Oferta oferta = null;
        List<Oferta> ofertaList = new ArrayList<>();
        while (rs.next()) {
            oferta = new Oferta();
            oferta.setId(rs.getLong("oferta_id"));
            oferta.setDataOferta(rs.getDate("oferta_data_hora"));
            oferta.setStatus(rs.getString("oferta_status"));
            Item item = new Item();
            item.setId(rs.getLong("item_id"));
            String data[] = rs.getString("item_data_compra").split("-");
            String data2 = data[2] + "/" + data[1] + "/" + data[0];
            item.setDataAquisicao(data2);
            data = rs.getString("item_data_cadastro").split("-");
            data2 = data[2] + "/" + data[1] + "/" + data[0];
            item.setDataCadastro(data2);

            Estado estado = new Estado();
            estado.setId(rs.getLong("estado_id"));
            estado.setNome(rs.getString("estado_nome"));
            estado.setUf(rs.getString("estado_uf"));
            Cidade cidade = new Cidade();
            cidade.setId(rs.getLong("cidade_id"));
            cidade.setNome(rs.getString("cidade_nome"));
            cidade.setEstado(estado);

            item.setCidade(cidade);

            item.setNome(rs.getString("item_nome"));
            item.setDescricao(rs.getString("item_descricao"));

            Anunciante anunciante = new Anunciante();
            anunciante.setId(rs.getLong("anunciante_id"));
            anunciante.setApelido(rs.getString("anunciante_apelido"));
            anunciante.setNome(rs.getString("anunciante_nome"));
            anunciante.setEmail(rs.getString("anunciante_email"));
            anunciante.setReputacao(rs.getInt("anunciante_reputacao"));

            item.setAnunciante(anunciante);
            oferta.setItem(item);

            //buscando os itens ou o item descrito da oferta
            sql = "select oferta_item.id of_item_id, oferta_item.oferta_fk of_item_oferta, oferta_item.item of_item_item_descrito, item.id item_id, item.nome item_nome, item.data_compra item_data_compra, item.descricao item_descricao, item.estado_fk item_estado_fk, item.cidade_fk item_cidade_fk, item.data_hora_cadastro item_data_cadastro, usuario.id anunciante_id, usuario.nome anunciante_nome, usuario.email anunciante_email, usuario.apelido anunciante_apelido, usuario.telefone anunciante_telefone, anunciante.reputacao anunciante_reputacao, cidade.id cidade_id, cidade.nome cidade_nome, estado.id estado_id, estado.nome estado_nome, estado.uf estado_uf  from oferta_item left join oferta on oferta.id=oferta_item.oferta_fk left join item on item.id=oferta_item.item_fk left join anunciante on anunciante.usuario_fk=item.usuario_fk left join usuario on usuario.id=anunciante.usuario_fk  left join cidade on cidade.id=item.cidade_fk left join estado on estado.id=item.estado_fk  where oferta_item.oferta_fk=?";
            PreparedStatement ps1 = conn.prepareStatement(sql);
            ps1.setLong(1, oferta.getId());

            ResultSet rs1 = ps1.executeQuery();
            OfertaItem ofertaItem = new OfertaItem();
            while (rs1.next()) {
                ofertaItem.setId(rs1.getLong("of_item_id"));
                ofertaItem.setItemDescrito(rs1.getString("of_item_item_descrito"));

                item = new Item();
                item.setId(rs1.getLong("item_id"));
                item.setNome(rs1.getString("item_nome"));
                data = rs1.getString("item_data_compra").split("-");
                data2 = data[2] + "/" + data[1] + "/" + data[0];
                item.setDataAquisicao(data2);
                data = rs.getString("item_data_cadastro").split("-");
                data2 = data[2] + "/" + data[1] + "/" + data[0];
                item.setDataCadastro(data2);

                estado = new Estado();
                estado.setId(rs.getLong("estado_id"));
                estado.setNome(rs.getString("estado_nome"));
                estado.setUf(rs.getString("estado_uf"));
                cidade = new Cidade();
                cidade.setId(rs.getLong("cidade_id"));
                cidade.setNome(rs.getString("cidade_nome"));
                cidade.setEstado(estado);

                item.setCidade(cidade);

                item.setDescricao(rs1.getString("item_descricao"));
                anunciante = new Anunciante();
                anunciante.setId(rs1.getLong("anunciante_id"));
                anunciante.setApelido(rs1.getString("anunciante_apelido"));
                anunciante.setNome(rs1.getString("anunciante_nome"));
                anunciante.setEmail(rs1.getString("anunciante_email"));
                anunciante.setTelefone(rs1.getString("anunciante_telefone"));
                anunciante.setReputacao(rs1.getInt("anunciante_reputacao"));
                item.setAnunciante(anunciante);

                ofertaItem.getItemList().add(item);
            }
            oferta.setOfertaItem(ofertaItem);
            ofertaList.add(oferta);
            rs1.close();
            ps1.close();
        }
        rs.close();
        ps.close();
        return ofertaList;
    }

    @Override
    public void update(Connection conn, Oferta entity) throws Exception {
        String sql = "UPDATE oferta SET status=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        int i = 0;
        ps.setString(++i, entity.getStatus());
        ps.setLong(++i, entity.getId());

        ps.execute();
        ps.close();
    }

    @Override
    public void delete(Connection conn, Long id) throws Exception {
        String sql = "DELETE FROM oferta WHERE id=?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, id);
        ps.execute();
        ps.close();
    }

    @Override
    public String applyCriteria(Connection conn, Map<Long, Object> criteria) throws Exception {
        String sql = "";

        Long itemID = (Long) criteria.get(OfertaCriteria.ITEM_ID);
        if (itemID != null && itemID > 0) {
            sql += " AND item.id=" + itemID;
        }

        Long anunciateID = (Long) criteria.get(OfertaCriteria.ANUNCIANTE_ID);
        if (anunciateID != null && anunciateID > 0) {
            sql += " AND usuario.id=" + anunciateID;
        }

        String status = (String) criteria.get(OfertaCriteria.STATUS_EQ);
        if (status != null && !status.isEmpty()) {
            sql += "AND oferta.status='" + status+"'";
        }

        return sql;
    }

    @Override
    public Long countByCriteria(Connection conn, Map<Long, Object> criteria, Long limit, Long offset) throws Exception {
        Long count = null;
        String sql = "SELECT count(*) count FROM oferta left join item on item.id=oferta.item_fk left join anunciante on anunciante.usuario_fk=item.usuario_fk left join usuario on usuario.id=anunciante.usuario_fk WHERE 1=1";
        sql += applyCriteria(conn, criteria);
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getLong("count");
        }
        return count;
    }

}

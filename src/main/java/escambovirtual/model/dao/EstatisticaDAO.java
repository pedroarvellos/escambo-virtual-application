package escambovirtual.model.dao;

import escambovirtual.model.entity.Estado;
import escambovirtual.model.entity.EstatisticaRegiao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Joao
 */
public class EstatisticaDAO {

    public List<EstatisticaRegiao> infoRegiao(Connection conn) throws Exception {
        String sql = "select E.id, E.uf, E.nome as estado, count(I.id) as qtd_item from estado E left join item I on E.id = I.estado_fk group by E.id";

        Statement s = conn.createStatement();
        ResultSet rs = s.executeQuery(sql);

        List<EstatisticaRegiao> estatisticaRegiaoList = new ArrayList<>();

        while (rs.next()) {
            EstatisticaRegiao estatisticaRegiao = new EstatisticaRegiao();
            Estado estado = new Estado();
            estado.setId(rs.getLong("id"));
            estado.setNome(rs.getString("estado"));
            estado.setUf(rs.getString("uf"));

            estatisticaRegiao.setEstado(estado);

            estatisticaRegiao.setQtdeItem(rs.getLong("qtd_item"));            

            estatisticaRegiaoList.add(estatisticaRegiao);
        }
        rs.close();
        s.close();
        return estatisticaRegiaoList;
    }

}

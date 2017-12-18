package escambovirtual.model.base.service;

import escambovirtual.model.entity.EstatisticaGeral;
import escambovirtual.model.entity.EstatisticaRegiao;
import java.util.List;

/**
 *
 * @author Joao
 */
public interface BaseEstatisticaService {
    
    
    public EstatisticaGeral infoItem() throws Exception;
    public EstatisticaGeral infoUsuario() throws Exception;
    public List<EstatisticaRegiao> infoRegiao() throws Exception;
}

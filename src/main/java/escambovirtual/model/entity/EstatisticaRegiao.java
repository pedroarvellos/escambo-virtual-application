package escambovirtual.model.entity;

/**
 *
 * @author Joao
 */
public class EstatisticaRegiao {

    private Estado estado;
    private Long qtdeItem;
    private Long qtdeUsuario;

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public Long getQtdeItem() {
        return qtdeItem;
    }

    public void setQtdeItem(Long qtdeItem) {
        this.qtdeItem = qtdeItem;
    }

    public Long getQtdeUsuario() {
        return qtdeUsuario;
    }

    public void setQtdeUsuario(Long qtdeUsuario) {
        this.qtdeUsuario = qtdeUsuario;
    }
}

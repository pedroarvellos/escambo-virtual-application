package escambovirtual.model.entity;

/**
 *
 * @author Joao
 */
public class EstatisticaGeral {

    private Long itemTotal;
    private Long itemEmAvaliacao;
    private Long itemPublicado;
    private Long itemTrocado;
    private Long itemNaoPublicado;
    
    private Long usuarioTotal;
    private Long usuarioAnunciante;
    private Long usuarioAdm;

    public Long getUsuarioTotal() {
        return usuarioTotal;
    }

    public void setUsuarioTotal(Long usuarioTotal) {
        this.usuarioTotal = usuarioTotal;
    }

    public Long getUsuarioAnunciante() {
        return usuarioAnunciante;
    }

    public void setUsuarioAnunciante(Long usuarioAnunciante) {
        this.usuarioAnunciante = usuarioAnunciante;
    }

    public Long getUsuarioAdm() {
        return usuarioAdm;
    }

    public void setUsuarioAdm(Long usuarioAdm) {
        this.usuarioAdm = usuarioAdm;
    }

    public Long getItemTotal() {
        return itemTotal;
    }

    public void setItemTotal(Long itemTotal) {
        this.itemTotal = itemTotal;
    }

    public Long getItemEmAvaliacao() {
        return itemEmAvaliacao;
    }

    public void setItemEmAvaliacao(Long itemEmAvaliacao) {
        this.itemEmAvaliacao = itemEmAvaliacao;
    }

    public Long getItemPublicado() {
        return itemPublicado;
    }

    public void setItemPublicado(Long itemPublicado) {
        this.itemPublicado = itemPublicado;
    }

    public Long getItemTrocado() {
        return itemTrocado;
    }

    public void setItemTrocado(Long itemTrocado) {
        this.itemTrocado = itemTrocado;
    }

    public Long getItemNaoPublicado() {
        return itemNaoPublicado;
    }

    public void setItemNaoPublicado(Long itemNaoPublicado) {
        this.itemNaoPublicado = itemNaoPublicado;
    }
}

package escambovirtual.model.entity;


/**
 *
 * @author Joao
 */
public class Anunciante extends Usuario {

    public Anunciante() {
    }
    
    public Anunciante(Long id) {
        super(id);
    }
    
    private Integer reputacao;

    public Integer getReputacao() {
        return reputacao;
    }

    public void setReputacao(Integer reputacao) {
        this.reputacao = reputacao;
    }

}

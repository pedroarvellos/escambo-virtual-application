package escambovirtual.model.entity;

import escambovirtual.model.base.BaseEntity;
import java.util.Date;

/**
 *
 * @author Joao
 */
public class Troca extends BaseEntity{
    
    private Oferta oferta;    
    private String status;
    private Integer nivel_satisfacao;
    private Date avaliacao_data_hora;
    private Date data_hora;
    private String avaliacao_descricao;
    private Usuario usuario1;
    private Usuario usuario2;

    public Date getData_hora() {
        return data_hora;
    }

    public void setData_hora(Date data_hora) {
        this.data_hora = data_hora;
    }

    public Usuario getUsuario1() {
        return usuario1;
    }

    public void setUsuario1(Usuario usuario1) {
        this.usuario1 = usuario1;
    }

    public Usuario getUsuario2() {
        return usuario2;
    }

    public void setUsuario2(Usuario usuario2) {
        this.usuario2 = usuario2;
    }

    public Integer getNivel_satisfacao() {
        return nivel_satisfacao;
    }

    public void setNivel_satisfacao(Integer nivel_satisfacao) {
        this.nivel_satisfacao = nivel_satisfacao;
    }

    public Date getAvaliacao_data_hora() {
        return avaliacao_data_hora;
    }

    public void setAvaliacao_data_hora(Date avaliacao_data_hora) {
        this.avaliacao_data_hora = avaliacao_data_hora;
    }

    public String getAvaliacao_descricao() {
        return avaliacao_descricao;
    }

    public void setAvaliacao_descricao(String avaliacao_descricao) {
        this.avaliacao_descricao = avaliacao_descricao;
    }

    public Oferta getOferta() {
        return oferta;
    }

    public void setOferta(Oferta oferta) {
        this.oferta = oferta;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

package escambovirtual.model.entity;

import escambovirtual.model.base.BaseEntity;
import java.util.Date;

/**
 *
 * @author Joao
 */
public class Mensagem extends BaseEntity{
    
    private String texto;
    private Anunciante remetente;
    private Anunciante destinatario;
    private Item item;
    private Date data_hora_envio;   
    private Date data_hora_leitura;   

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Anunciante getRemetente() {
        return remetente;
    }

    public void setRemetente(Anunciante remetente) {
        this.remetente = remetente;
    }

    public Anunciante getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(Anunciante destinatario) {
        this.destinatario = destinatario;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Date getData_hora_envio() {
        return data_hora_envio;
    }

    public void setData_hora_envio(Date data_hora_envio) {
        this.data_hora_envio = data_hora_envio;
    }

    public Date getData_hora_leitura() {
        return data_hora_leitura;
    }

    public void setData_hora_leitura(Date data_hora_leitura) {
        this.data_hora_leitura = data_hora_leitura;
    }
    
    
}

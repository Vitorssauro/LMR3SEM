package View;

import java.awt.*;
import javax.swing.BoxLayout;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;


public class VendasPainel extends JPanel{

    // Atributos

    private JComboBox<String> clientesBox;


    public VendasPainel() {
        super();

        clientesBox = new JComboBox<String>();

        setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        add(new JLabel("Cadastro de Vendas"));
        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(5, 2));
        
        inputPanel.add(new JLabel("Cliente"));

        clientesBox.addItem("Selecione o Cliente");        
        clientesBox.addItem("1");
        clientesBox.addItem("2");
        
        inputPanel.add(clientesBox);

        inputPanel.add(new JLabel("Veiculo"));

        add(inputPanel);

    }
}

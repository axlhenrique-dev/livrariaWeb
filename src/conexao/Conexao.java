package conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {

    private static final String BANCO = "livraria";
    private static final String USUARIO = "UsuárioDoProfessor";
    private static final String SENHA = "SenhaDoProfessor";

    private static final String SERVIDOR = "jdbc:mysql://localhost:3306/";
    private static final String CONFIG = "?useTimezone=true&serverTimezone=UTC";

    public static Connection getConexao() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver do MySQL não encontrado.", e);
        }

        String url = SERVIDOR + BANCO + CONFIG;
        return DriverManager.getConnection(url, USUARIO, SENHA);
    }
}

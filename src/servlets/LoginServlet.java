package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexao.Conexao;

//Login e sessão
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");

        String sql = "SELECT nome FROM usuario WHERE nome = ? AND senha = ?";

        HttpSession sessao = request.getSession();

        try (Connection conn = Conexao.getConexao();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nome);
            ps.setString(2, senha);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                sessao.setAttribute("logado", "true");
                sessao.setAttribute("usuario", rs.getString("nome"));

                //Redirecionamento caso login aprovado
                response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");
            } else {
                //Redirecionamento caso login recusado
                sessao.setAttribute("erroLogin", "Usuário ou senha inválidos!");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } catch (Exception e) {
            //Redirecionamento caso erro por qualquer outro fator que não seja senha
            sessao.setAttribute("erroLogin", "Erro ao efetuar login: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}

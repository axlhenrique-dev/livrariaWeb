package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexao.Conexao;


@WebServlet("/InserirUsuarioServlet")
public class InserirUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession sessao = request.getSession();
        if (!"true".equals(sessao.getAttribute("logado"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");

        String sql = "INSERT INTO usuario (nome, senha) VALUES (?, ?)";

        try (Connection conn = Conexao.getConexao();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nome);
            ps.setString(2, senha);

            ps.execute();

            response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");

        } catch (Exception e) {
            request.setAttribute("erro", "Erro ao cadastrar usuário: " + e.getMessage());
            request.getRequestDispatcher("/admin/usuario_form.jsp").forward(request, response);
        }
    }
}

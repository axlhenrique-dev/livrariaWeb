package servlets;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import conexao.Conexao;


@WebServlet("/AtualizarLivroServlet")
@MultipartConfig
public class AtualizarLivroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession sessao = request.getSession();
        if (!"true".equals(sessao.getAttribute("logado"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String ano = request.getParameter("ano");
        String preco = request.getParameter("preco");
        String idEditora = request.getParameter("idEditora");

        // Trecho para manter a foto atual caso nenhuma nova foto seja enviada
        String nomeArquivo = request.getParameter("fotoAtual");

        Part parteFoto = request.getPart("foto");
        if (parteFoto != null && parteFoto.getSize() > 0) {
            nomeArquivo = Paths.get(parteFoto.getSubmittedFileName()).getFileName().toString();

            String caminhoPasta = getServletContext().getRealPath("/fotos");
            File pasta = new File(caminhoPasta);
            if (!pasta.exists()) {
                pasta.mkdirs();
            }

            parteFoto.write(caminhoPasta + File.separator + nomeArquivo);
        }

        String sql = "UPDATE livro SET titulo = ?, autor = ?, ano = ?, preco = ?, foto = ?, idEditora = ? WHERE id = ?";

        try (Connection conn = Conexao.getConexao();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, titulo);
            ps.setString(2, autor);
            ps.setInt(3, Integer.parseInt(ano));
            ps.setDouble(4, Double.parseDouble(preco));
            ps.setString(5, nomeArquivo);
            ps.setInt(6, Integer.parseInt(idEditora));
            ps.setInt(7, id);

            ps.execute();

            response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");

        } catch (Exception e) {
            request.setAttribute("erro", "Erro ao atualizar livro: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/livro_editar.jsp?id=" + id);
        }
    }
}

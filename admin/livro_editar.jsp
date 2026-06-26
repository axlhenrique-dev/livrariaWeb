<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="conexao.Conexao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessaoAtual = request.getSession();
    if (!"true".equals(sessaoAtual.getAttribute("logado"))) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    String titulo = "", autor = "", foto = "";
    int ano = 0, idEditoraAtual = 0;
    double preco = 0;

    String sqlBusca = "SELECT * FROM livro WHERE id = ?";

    try (Connection conn = Conexao.getConexao();
            PreparedStatement ps = conn.prepareStatement(sqlBusca)) {

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            titulo = rs.getString("titulo");
            autor = rs.getString("autor");
            ano = rs.getInt("ano");
            preco = rs.getDouble("preco");
            foto = rs.getString("foto");
            idEditoraAtual = rs.getInt("idEditora");
        }
    } catch (Exception e) {
%>
        <p class="erro">Erro ao carregar livro: <%= e.getMessage() %></p>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Livro</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <section>

        <h1>Editar Livro</h1>

        <form action="<%= request.getContextPath() %>/AtualizarLivroServlet" method="post" enctype="multipart/form-data">

            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="fotoAtual" value="<%= foto == null ? "" : foto %>">

            <label>Tí­tulo:</label>
            <input type="text" name="titulo" value="<%= titulo %>" required><br>

            <label>Autor:</label>
            <input type="text" name="autor" value="<%= autor %>" required><br>

            <label>Ano:</label>
            <input type="number" name="ano" value="<%= ano %>" required><br>

            <label>Preço:</label>
            <input type="number" step="0.01" name="preco" value="<%= preco %>" required><br>

            <label>Editora:</label>
            <select name="idEditora" required>
                <%
                    String sqlEditoras = "SELECT id, nome FROM editora ORDER BY nome";
                    try (Connection conn = Conexao.getConexao();
                            PreparedStatement ps = conn.prepareStatement(sqlEditoras)) {

                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            int idEd = rs.getInt("id");
                %>
                    <option value="<%= idEd %>" <%= idEd == idEditoraAtual ? "selected" : "" %>><%= rs.getString("nome") %></option>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <option>Erro ao carregar editoras</option>
                <%
                    }
                %>
            </select><br>

            <% if (foto != null && !foto.isEmpty()) { %>
                <p>Capa atual:<br><img src="<%= request.getContextPath() %>/fotos/<%= foto %>" class="capa-livro"></p>
            <% } %>

            <label>Nova Foto da Capa (opcional):</label>
            <input type="file" name="foto" accept="image/*"><br>

            <div class="acoes-form">
                <button type="submit">Atualizar</button>
                <a href="admin.jsp" class="botao-voltar">Voltar</a>
            </div>
        </form>

    </section>
</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="conexao.Conexao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessaoAtual = request.getSession();
    if (sessaoAtual.getAttribute("logado") == null) {
        sessaoAtual.setAttribute("logado", "false");
    }

    String busca = request.getParameter("busca");
    if (busca == null) {
        busca = "";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Livros Virtual</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <h1>Catálogo de Livros Virtual</h1>

        <!-- Processo de login e verificação de sessão -->

        <% if ("false".equals(sessaoAtual.getAttribute("logado"))) { %>
            <form action="LoginServlet" method="post" class="form-login">
                <input type="text" name="nome" placeholder="Usuário" required>
                <input type="password" name="senha" placeholder="Senha" required>
                <button type="submit">Entrar</button>
            </form>

            <!-- Sessão com erro -->
            <% if (sessaoAtual.getAttribute("erroLogin") != null) { %>
                <p class="erro"><%= sessaoAtual.getAttribute("erroLogin") %></p>
                <% sessaoAtual.removeAttribute("erroLogin"); %>
            <% } %>
        <% } else { %>

            <!-- Sessão bem sucedida -->
            <p class="bem-vindo">
                Bem-vindo, <%= sessaoAtual.getAttribute("usuario") %>! |
                <a href="<%= request.getContextPath() %>/admin/admin.jsp">Painel Administrativo</a> |
                <a href="<%= request.getContextPath() %>/LogoutServlet">Sair</a>
            </p>
        <% } %>
    </header>

    <section>
        <form action="index.jsp" method="get" class="form-busca">
            <input type="text" name="busca" placeholder="Buscar por Título..." value="<%= busca %>">
            <button type="submit">Buscar</button>
        </form>

        <table>
            <tr>
                <th>Capa</th>
                <th>Título</th>
                <th>Autor</th>
                <th>Ano</th>
                <th>Preço</th>
                <th>Editora</th>
            </tr>
            <%
                String sql = "SELECT l.titulo, l.autor, l.ano, l.preco, l.foto, e.nome AS editora " +
                             "FROM livro l LEFT JOIN editora e ON l.idEditora = e.id " +
                             "WHERE l.titulo LIKE ? ORDER BY l.titulo";

                try (Connection conn = Conexao.getConexao();
                        PreparedStatement ps = conn.prepareStatement(sql)) {

                    ps.setString(1, "%" + busca + "%");
                    ResultSet rs = ps.executeQuery();

                    boolean temLivro = false;

                    while (rs.next()) {
                        temLivro = true;
                        String foto = rs.getString("foto");
            %>
                <tr>
                    <td>
                        <% if (foto != null && !foto.isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/fotos/<%= foto %>" class="capa-livro" alt="capa">
                        <% } else { %>
                            -
                        <% } %>
                    </td>
                    <td><%= rs.getString("titulo") %></td>
                    <td><%= rs.getString("autor") %></td>
                    <td><%= rs.getInt("ano") %></td>
                    <td>R$ <%= String.format("%.2f", rs.getDouble("preco")) %></td>
                    <td><%= rs.getString("editora") %></td>
                </tr>
            <%
                    }

                    if (!temLivro) {
            %>
                <tr><td colspan="6">Nenhum livro encontrado.</td></tr>
            <%
                    }

                } catch (Exception e) {
            %>
                <tr><td colspan="6">Erro ao carregar livros: <%= e.getMessage() %></td></tr>
            <%
                }
            %>
        </table>
    </section>

</body>
</html>

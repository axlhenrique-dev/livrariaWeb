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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Painel Administrativo</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <header>
        <h1>Painel Administrativo</h1>
        <p class="bem-vindo">
            Bem-vindo, <%= sessaoAtual.getAttribute("usuario") %>! |
            <a href="<%= request.getContextPath() %>/index.jsp">Ver Catálogo</a> |
            <a href="<%= request.getContextPath() %>/LogoutServlet">Sair</a>
        </p>
    </header>

    <section class="menu-admin">
        <a href="livro_form.jsp" class="botao">+ Adicionar Livro</a>
        <a href="editora_form.jsp" class="botao">+ Adicionar Editora</a>
        <a href="usuario_form.jsp" class="botao">+ Adicionar Usuário</a>
    </section>

    <section>
        <h2>Livros Cadastrados</h2>
        <table>
            <tr>
                <th>Tí­tulo</th>
                <th>Autor</th>
                <th>Ano</th>
                <th>Preço</th>
                <th>Editora</th>
                <th>Ação</th>
            </tr>
            <%
                String sql = "SELECT l.id, l.titulo, l.autor, l.ano, l.preco, e.nome AS editora " +
                             "FROM livro l LEFT JOIN editora e ON l.idEditora = e.id ORDER BY l.titulo";

                try (Connection conn = Conexao.getConexao();
                        PreparedStatement ps = conn.prepareStatement(sql)) {

                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("titulo") %></td>
                    <td><%= rs.getString("autor") %></td>
                    <td><%= rs.getInt("ano") %></td>
                    <td>R$ <%= String.format("%.2f", rs.getDouble("preco")) %></td>
                    <td><%= rs.getString("editora") %></td>
                    <td><a href="livro_editar.jsp?id=<%= rs.getInt("id") %>">Editar</a></td>
                </tr>
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

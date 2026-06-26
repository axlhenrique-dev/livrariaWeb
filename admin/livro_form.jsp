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
    <title>Adicionar Livro</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <section>

        <h1>Adicionar Livro</h1>

        <% if (request.getAttribute("erro") != null) { %>
            <p class="erro"><%= request.getAttribute("erro") %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/InserirLivroServlet" method="post" enctype="multipart/form-data">

            <label>Tí­tulo:</label>
            <input type="text" name="titulo" required><br>

            <label>Autor:</label>
            <input type="text" name="autor" required><br>

            <label>Ano:</label>
            <input type="number" name="ano" required><br>

            <label>Preçoo:</label>
            <input type="number" step="0.01" name="preco" required><br>

            <label>Editora:</label>
            <select name="idEditora" required>
                <%
                    String sql = "SELECT id, nome FROM editora ORDER BY nome";
                    try (Connection conn = Conexao.getConexao();
                            PreparedStatement ps = conn.prepareStatement(sql)) {

                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("nome") %></option>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <option>Erro ao carregar editoras</option>
                <%
                    }
                %>
            </select><br>

            <label>Foto da Capa:</label>
            <input type="file" name="foto" accept="image/*"><br>

            <div class="acoes-form">
                <button type="submit">Salvar</button>
                <a href="admin.jsp" class="botao-voltar">Voltar</a>
            </div>
        </form>
        
    </section>    
</body>
</html>

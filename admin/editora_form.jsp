<%@ page import="javax.servlet.http.*" %>
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
    <title>Adicionar Editora</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <section>

        <h1>Adicionar Editora</h1>

        <% if (request.getAttribute("erro") != null) { %>
            <p class="erro"><%= request.getAttribute("erro") %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/InserirEditoraServlet" method="post">

            <label>Nome:</label>
            <input type="text" name="nome" required><br>

            <label>Cidade:</label>
            <input type="text" name="cidade"><br>

            <div class="acoes-form">
                <button type="submit">Salvar</button>
                <a href="admin.jsp" class="botao-voltar">Voltar</a>
            </div>
        </form>

    </section>
</body>
</html>

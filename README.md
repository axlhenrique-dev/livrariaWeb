#Catálogo de Livros Virtual

Projeto integrador da disciplina de **Desenvolvimento Web com Java**, desenvolvido no quinto semestre do curso de Análise e Desenvolvimento de Sistemas, no Claretiano - Centro Universirário. O sistema é uma aplicação web de catálogo de livros com painel administrativo, construído com **JSP**, **Servlets** e **JDBC**, rodando no **Apache Tomcat 9**. A proposta do projeto é um sistema simples, de fácil manutenção e utilizando apenas recursos nativos do JEE.

---

##Estrutura do Projeto

```
LivrariaWeb/
├── src/
│   ├── conexao/
│   │   └── Conexao.java          # Classe de conexão com o banco de dados
│   └── servlets/
│       ├── LoginServlet.java
│       ├── LogoutServlet.java
│       ├── InserirLivroServlet.java
│       ├── AtualizarLivroServlet.java
│       ├── InserirEditoraServlet.java
│       └── InserirUsuarioServlet.java
├── admin/
│   ├── admin.jsp
│   ├── livro_form.jsp
│   ├── livro_editar.jsp
│   ├── editora_form.jsp
│   └── usuario_form.jsp
├── css/
│   └── style.css
├── fotos/                        # Pasta onde as capas dos livros são salvas
├── WEB-INF/
│   ├── web.xml
│   └── lib/
│       └── mysql-connector-java-8_0_20.jar
├── index.jsp
└── banco.sql
```

---

## ✅ Funcionalidades

- Catálogo público com listagem e busca de livros por título
- Login e logout de administrador com controle de sessão
- Cadastro, edição e visualização de livros (com upload de foto de capa)
- Cadastro de editoras
- Cadastro de usuários administradores

---

## ⚙️ Pré-requisitos

- Java JDK 8 ou superior
- Apache Tomcat 9
- MySQL (XAMPP ou instalação standalone)

---

## 🚀 Como rodar

**1. Banco de dados**

Abra o MySQL e execute o arquivo `banco.sql` para criar o banco `livraria` com as tabelas e dados iniciais:

```sql
source /caminho/para/banco.sql
```

**2. Credenciais do banco**

Abra `src/conexao/Conexao.java` e ajuste as constantes com suas credenciais:

```java
private static final String USUARIO = "root";
private static final String SENHA   = "sua_senha";
```

**3. Compilar os Servlets**

Na raiz do projeto, execute:

```bash
javac -encoding UTF-8 \
  -cp "WEB-INF/lib/mysql-connector-java-8_0_20.jar:/caminho/tomcat9/lib/servlet-api.jar" \
  -d WEB-INF/classes \
  src/conexao/*.java src/servlets/*.java
```

> No Windows, substitua `:` por `;` no `-cp`.

**4. Implantar no Tomcat**

Copie (ou crie um link simbólico) da pasta `LivrariaWeb/` para dentro de `webapps/` do Tomcat:

```bash
cp -r LivrariaWeb/ /caminho/tomcat9/webapps/
```

**5. Subir o servidor**

```bash
/caminho/tomcat9/bin/startup.sh   # Linux/Mac
/caminho/tomcat9/bin/startup.bat  # Windows
```

**6. Acessar**

```
http://localhost:8080/LivrariaWeb/
```

Login padrão: **usuário** `administrador` / **senha** `livraria2026`

---

## 🛠️ Tecnologias utilizadas

| Tecnologia | Uso |
|---|---|
| Java (JSP + Servlets) | Back-end e páginas dinâmicas |
| JDBC | Comunicação com o banco de dados |
| MySQL | Banco de dados relacional |
| HTML + CSS | Interface do usuário |
| Apache Tomcat 9 | Servidor de aplicação |

---

## 📝 Observações

- O projeto **não usa Maven** — a compilação é feita manualmente com `javac`.
- A função de upload de foto de capa requer permissão de escrita na pasta `fotos/` do servidor.
- As senhas de usuário são armazenadas em texto puro, adequado ao escopo acadêmico do projeto.

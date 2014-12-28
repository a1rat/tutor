<%--<%@ page contentType="text/html; charset=windows-1251" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<% Class.forName("org.postgresql.Driver");
  Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
          "postgres",
          "postgres");%>
<%
  HttpSession hs = request.getSession();
  if (hs.getAttribute("current_user")== null) {
    response.sendRedirect("/");
  }
%>
<html>
<head lang="ru">
  <meta charset="UTF-8">
  <title>Кабинет</title>
  <link rel="stylesheet" href="bootstrap.min.css">
  <%--<link rel="stylesheet" href="/style.css">--%>
  <%--<link rel="stylesheet" href="bootstrap.min.css">--%>
  <%--<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css">--%>
  <%--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">--%>
</head>
<body>
<div class="container">
  <div class="modal-header" style="padding-top: 0px;height: 150px;background: url('header.jpg')">
    <div class="row">
      <div class="span10"></div>
      <div class="span2">
        <%--<form class="form-horizontal" action="/servlet" method="post">--%>
          <%--<input type="text" class="input-medium" placeholder="Email" name="email">--%>
          <%--<input type="password" class="input-medium" placeholder="Password" name="password">--%>
          <%--<input class="bottom pull-right" type="submit" value="Войти">--%>
        <%--</form>--%>
      </div>
    </div>
  </div>
  <div class="grid">
    <div class="row container" style="height: 30px">
      <ul class="nav nav-pills">
        <li><a href="index.jsp">Главная</a></li>
        <li><a href="/logout">Выход</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="container">
  <div>
    <div class="row">
      <%--<div class="span4">--%>
        <%--<%--%>
          <%--PreparedStatement s = connection.prepareStatement("SELECT name From class");--%>
          <%--ResultSet cl = s.executeQuery();%>--%>
        <%--<ul class="nav nav-list">--%>
          <%--<%while (cl.next()) {%>--%>
          <%--<li><a href="#">--%>
            <%--<%=cl.getString("name")%>--%>
          <%--</a></li>--%>
          <%--<%}%>--%>
        <%--</ul>--%>
      <%--</div>--%>
      <div class="span12">
        <%
//          HttpSession hs = request.getSession();
          PreparedStatement statement = connection.prepareStatement("SELECT aplications.name, aplications.email,class.name" +
                  " FROM aplications INNER JOIN class on class.id = aplications.class_id\n" +
                  "WHERE aplications.tutor_id = (SELECT id FROM tutors WHERE email = '"+hs.getAttribute("current_user")+"')");
//                  ("SELECT a.name,a.email,c.name FROM " +
//                  "aplications as a,class as c, tutors as t WHERE t.email = "+hs.getAttribute("current_user")+ "and a.class_id = c.id;");
          ResultSet resultSet = statement.executeQuery();%>
        <center>


        <h4 style="align-content: center">Заявки</h4>

          <%--<ul class="nav nav-list">--%>
            <table border="1">
              <tr>
                <th align="center">Имя</th>
                <th align="center">Email</th>
                <th align="center">Предмет</th>
              </tr>
          <%while (resultSet.next()){%>
            <tr>
              <td><%=resultSet.getString(1)%></td>
              <td><%=resultSet.getString(2)%></td>
              <td><%=resultSet.getString(3)%></td>
              <%--<li><%=resultSet.getString(1)+" "+resultSet.getString(2)+" "+resultSet.getString(3)%></li>--%>
            </tr>
        <%}%>
            <%--</ul>--%>
        </table>
        </center>
            <%--System.out.println(resultSet.getString(1));--%>
            <%--System.out.println(resultSet.getString(2));--%>
            <%--System.out.println(resultSet.getString(3));--%>
          <%--}--%>
          <%--System.out.println(hs.getAttribute("current_user").toString());%>--%>
      </div>
    </div>
  </div>
</div>
</body>
</html>
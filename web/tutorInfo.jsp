<%--<%@ page contentType="text/html; charset=windows-1251" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<% Class.forName("org.postgresql.Driver");
  Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
          "postgres",
          "postgres");%>
<%--<%--%>
  <%--HttpSession hs = request.getSession();--%>
  <%--if (hs.getAttribute("current_user") != null) {--%>
    <%--response.sendRedirect("/lk");--%>
  <%--}--%>
<%--%>--%>
<html>
<head lang="ru">
  <meta charset="UTF-8">
  <title>Главная</title>
  <%--<style type="text/css"></style>--%>
  <%--<link rel="stylesheet" href="style.css">--%>
  <link  href="bootstrap.min.css" rel="stylesheet">
  <%--<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css">--%>
  <%--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">--%>
</head>
<body>
<div class="container">
  <div class="modal-header" style="padding-top: 0px;height: 150px;background: url('header.jpg')">
    <div class="row">
      <div class="span9"></div>
      <div class="span2">
        <form class="form-horizontal" action="/servlet" method="post">
          <input type="text" class="input-medium" placeholder="Email" name="email">
          <input type="password" class="input-medium" placeholder="Password" name="password">
          <input class="bottom pull-right" type="submit" value="Войти">
        </form>
      </div>
    </div>
  </div>
  <div class="grid">
    <div class="row container" style="height: 30px">
      <ul class="nav nav-pills">
        <li><a href="/">Главная</a></li>
        <li><a href="/search?nameClass=&city=">Найти репетитора</a></li>
        <li><a href="/reg">Репетиторам</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="container">
  <div>
    <div class="row">
      <div class="span3">
        <%
          PreparedStatement s = connection.prepareStatement("SELECT name From class");
          ResultSet cl = s.executeQuery();%>
        <ul class="nav nav-list">
          <%while (cl.next()) {
            String nameClass = cl.getString("name");%>
          <li><a href="/search?nameClass=<%=nameClass%>&city=">
            <%=nameClass%>
          </a></li>
          <%}%>
        </ul>
      </div>
      <div class="span9">
        <%String tutorId = request.getParameter("id");
          PreparedStatement p = connection.prepareStatement("SELECT name FROM tutors WHERE id = "+tutorId+"");
          ResultSet r = p.executeQuery();
          while (r.next()) {%>
        <%=r.getString(1)%>
        </br>
          <%}
          PreparedStatement c = connection.prepareStatement("SELECT name FROM class INNER JOIN class_tutor " +
                  "on class.id = class_tutor.class_id WHERE tutor_id = "+tutorId+"");
          ResultSet rs = c.executeQuery();%>

        <table>
          <tr>
            <td><h5>Предметы</h5></td>
          </tr>
            <%while (rs.next()) {%>
          <tr>
            <td> <%=rs.getString(1)%></td>
          </tr>

            <%}%>
          </table>
        </br>
        <h5>Дополнительная информация</h5>
          <%
            PreparedStatement pr = connection.prepareStatement("SELECT info FROM tutors WHERE id = "+tutorId+"");
            ResultSet re = pr.executeQuery();
            while (re.next()) {%>
              <%=re.getString(1)%>
            <%}%>
            <%--<center>--%>
              <h3>Отзывы</h3>
              <table border="1">
                <tr>
                  <td>Имя</td>
                  <td>Отзыв</td>
                </tr>

                  <%PreparedStatement t = connection.prepareStatement("SELECT name,comment FROM reviews WHERE tutor_id = "+tutorId+"");
                  ResultSet d = t.executeQuery();
                    while (d.next()){%>
                <tr>
                  <td><%=d.getString(1)%></td>
                  <td><%=d.getString(2)%></td>
                </tr>
                  <%}
                  %>

              </table>
              <h4>Оставит отзыв</h4>
              <form method="post" action="/otz?tutorid=<%=tutorId%>&">
              <table>
                <tr>
                  <td>Имя</td>
                  <td><input type="text" name="name"></td>
                </tr>
                <tr>
                  <td>Отзыв</td>
                  <td><textarea name="info"></textarea></td>
                </tr>
                <tr>
                  <td><input type="submit" value="Оставить отзыв"></td>
                </tr>
              </table>
              </form>
            <%--</center>--%>
            <h4>Оставить Заявки</h4>
          <form method="post" action="/z?tutorid=<%=tutorId%>&">
            Имя
            <input type="text" name="name"><br>
            Email
            <input type="email" name="email"><br>
            Предмет
            <select name="nameClass">
              <%
                LinkedList list4 = new LinkedList();
                PreparedStatement statement = connection.prepareStatement("SELECT name From class INNER JOIN" +
                        " class_tutor on class.id = class_tutor.class_id WHERE tutor_id = "+tutorId+"");
                ResultSet rs2 = statement.executeQuery();
                while (rs2.next()) {
                  list4.add(rs2.getString("name"));
                }
                for (int i = 0; i < list4.size(); i++) {%>
              <option value="<%=list4.get(i)%>"><%=list4.get(i)%></option>
              <%}%>
            </select>
            <input type="submit" value="Оставить заявку">
          </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
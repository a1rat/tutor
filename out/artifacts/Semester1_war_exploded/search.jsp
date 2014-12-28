<%--<%@ page contentType="text/html; charset=windows-1251" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.LinkedList" %>
<% Class.forName("org.postgresql.Driver");
  Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
          "postgres",
          "postgres");%>
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
        <li ><a href="/">Главная</a></li>
        <li class="active"><a href="/search?nameClass=&city=">Найти репетитора</a></li>
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
        <%String nameClass = request.getParameter("nameClass");
          String city = request.getParameter("city");
          if (nameClass.equals("") && city.equals("")){%>
            <form method="get" action="/search">
            <table>
            <tr>
            <td>Город</td>
            <td><select name="city">
        <%
          LinkedList list = new LinkedList();
          PreparedStatement ci = connection.prepareStatement("SELECT name From cities");
          ResultSet rs = ci.executeQuery();
          while (rs.next()) {
            list.add(rs.getString("name"));
          }
          for (int i = 0; i < list.size(); i++) {%>
        <option value="<%=list.get(i)%>"><%=list.get(i)%>
        </option>
        <%}%>
        </select></td>
        </tr>
        <tr>
          <td>Предмет</td>
          <td>
            <select name="nameClass">
              <%
                LinkedList list1 = new LinkedList();
                PreparedStatement c = connection.prepareStatement("SELECT name From class");
                ResultSet rs1 = c.executeQuery();
                while (rs1.next()) {
                  list1.add(rs1.getString("name"));
                }
                for (int i = 0; i < list1.size(); i++) {%>
              <option value="<%=list1.get(i)%>"><%=list1.get(i)%></option>
              <%}%>
            </select>
        </tr>
        <tr>
          <td>
            <input type="submit" value="Найти">
          </td>
        </tr>
        </table>
        </form>
          <%}%>
            <%if (city.equals("") && !nameClass.equals("")){
            PreparedStatement s1 = connection.prepareStatement("SELECT id,name,email,info FROM tutors INNER JOIN class_tutor ON" +
                    " tutors.id = class_tutor.tutor_id WHERE class_tutor.class_id = (SELECT id from class" +
                    " WHERE class.name= '" + nameClass + "');");
            ResultSet r = s1.executeQuery();%>
        <table border="1">
          <%while (r.next()){%>
          <tr>
            <td><a href="/tutorInfo?id=<%=r.getString(1)%>"><%=r.getString(2)%></a></td>
            <td><%=r.getString(3)%></td>
            <td><%=r.getString(4)%></td>
          </tr>
          <%}%>
        </table>
          <%}%>
        <%if (!city.equals("") && !nameClass.equals("")){
          PreparedStatement s1 = connection.prepareStatement("SELECT id,name,email,info FROM (tutors INNER JOIN class_tutor ON tutors.id = class_tutor.tutor_id) WHERE \n" +
                  "  class_tutor.class_id = (SELECT id from class WHERE class.name= '" + nameClass + "') \n" +
                  "  AND tutors.city_id = (SELECT id from cities WHERE name = '" + city + "');");
          ResultSet r = s1.executeQuery();%>
        <table border="1">
          <%while (r.next()){%>
          <tr>
            <td><a href="/tutorInfo?id=<%=r.getString(1)%>"><%=r.getString(2)%></a></td>
            <td><%=r.getString(3)%></td>
            <td><%=r.getString(4)%></td>
          </tr>
          <%}%>
        </table>
        <%}%>
<%--        <h4 style="text-align: center">Какая нибудь информация</h4>--%>
      </div>
    </div>
  </div>
</div>
</body>
</html>
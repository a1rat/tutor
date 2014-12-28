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
    if (hs.getAttribute("current_user") != null) {%>
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
            <%--<div class="span2">--%>
                <%--<form class="form-horizontal" action="/servlet" method="post">--%>
                    <%--<input type="text" class="input-medium" placeholder="Email" name="email">--%>
                    <%--<input type="password" class="input-medium" placeholder="Password" name="password">--%>
                    <%--<input class="bottom pull-right" type="submit" value="Войти">--%>
                <%--</form>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="grid">
        <div class="row container" style="height: 30px">
            <ul class="nav nav-pills">
                <li class="active"><a href="/">Главная</a></li>
                <li><a href="/search?nameClass=&city=">Найти репетитора</a></li>
                <li><a href="/lk">Кабинет</a></li>
                <li><a href="/logout">Выход</a></li>
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
                <h4 style="text-align: center">Какая нибудь информация</h4>
            </div>
        </div>
    </div>
</div>
</body>
</html>
    <%} else {
%>
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
                <li class="active"><a href="/">Главная</a></li>
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
                <h4 style="text-align: center">Какая нибудь информация</h4>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%}%>
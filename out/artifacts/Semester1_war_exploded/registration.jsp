<%--<%@ page contentType="text/html; charset=windows-1251" %>--%>
<%@page pageEncoding="UTF-8"%>
<%--<%request.setCharacterEncoding("windows-1251");%>--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<% Class.forName("org.postgresql.Driver");
    Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
            "postgres",
            "postgres");%>
<html>
<head lang="ru">
    <meta charset="UTF-8">
    <title>Регистрация</title>
    <link rel="stylesheet" href="bootstrap.min.css">
    <%--<style type="text/css"></style>--%>
    <%--<link rel="stylesheet" href="/style.css">--%>
    <%--<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css">--%>
    <%--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">--%>
</head>
<body>
<div class="container">
    <div class="modal-header" style="padding-top: 0px;height: 150px;background: url('header.jpg')">
    </div>
    <div class="grid">
        <div class="row container" style="height: 30px">
            <ul class="nav nav-pills">
                <li><a href="/index.jsp">Главная</a></li>
                <li><a href="/search?nameClass=&city=">Найти репетитора</a></li>
                <li class="active"><a href="/reg">Репетиторам</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="container">
    <div>
        <div class="row">
            <div class="span4">
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
            <div class="span8">
                <h5>Регистрация</h5>
                <form method="post" action="/servletReg">
                <%--<form method="post" action="/servletReg">--%>
                    <table>
                        <tr>
                            <td>ФИО <span style="color: #ee5f5b">*</span></td>
                            <td><input type="text" name="name"></td>
                        </tr>
                        <tr>
                            <td>Email<span style="color: #ee5f5b">*</span></td>
                            <td><input type="email" name="email"></td>
                        </tr>
                        <tr>
                            <td>Город <span style="color: #ee5f5b">*</span></td>
                            <td><select name="city">
                                <%
                                    LinkedList list = new LinkedList();
                                    PreparedStatement ci = connection.prepareStatement("SELECT name From cities");
                                    ResultSet city = ci.executeQuery();
                                    while (city.next()) {
                                        list.add(city.getString("name"));
                                    }
                                    for (int i = 0; i < list.size(); i++) {%>
                                <option value="<%=list.get(i)%>"><%=list.get(i)%>
                                </option>
                                <%}%>
                            </select></td>
                        </tr>
                        <tr>
                            <td>Предметы <span style="color: #ee5f5b">*</span><p></td>
                            <td>
                            <%
                                PreparedStatement ps = connection.prepareStatement("SELECT * FROM class");
                                ResultSet re = ps.executeQuery();
                                while (re.next()){%>
                                <input type="checkbox" name="idClass" value="<%=re.getInt("id")%>"><%=re.getString("name")%><Br>
                                <%}
                            %>
                            </td>
                        </tr>
                        <tr>
                            <td>О Себе <span style="color: #ee5f5b">*</span></td>
                            <td><textarea name="info"></textarea></td>
                        </tr>
                        <tr>
                            <td>Пароль<span style="color: #ee5f5b">*</span></td>
                            <td><input type="password" name="password"></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" value="Зарегестрироваться">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.PrintWriter" %>
<% Class.forName("org.postgresql.Driver");
  Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
          "postgres",
          "postgres");%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
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
</body>
</html>

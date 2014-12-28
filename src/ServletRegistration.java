import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.LinkedList;

/**
 * Created by ????? on 16.11.2014.
 */
@WebServlet(name = "ServletRegistration")
public class ServletRegistration extends HttpServlet {
    Connection connection;

    public void init() throws ServletException {
        super.init();
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/tutor",
                    "postgres",
                    "postgres");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html; charset=windows-1251");
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String city = request.getParameter("city");
        String info = request.getParameter("info");
        String[] idClass = request.getParameterValues("idClass");
//        String aClass = request.getParameter("class");
//        System.out.println(aClass);
        MessageDigest md = null;
        StringBuffer sb = new StringBuffer();
        try {
            md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte byteData[] = md.digest();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        int idCity = 0;
        try {
            PreparedStatement statement1 = connection.prepareStatement("SELECT * FROM cities WHERE name = ?");
            statement1.setString(1, city);
            ResultSet set = statement1.executeQuery();
            while (set.next()) {
                idCity = set.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            PreparedStatement statement = connection.prepareStatement("INSERT into tutors VALUES (DEFAULT, ?,?,?,?,?)");
            statement.setString(1, name);
            statement.setInt(2, idCity);
            statement.setString(3, email);
            statement.setString(4, sb.toString());
            statement.setString(5, info);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        LinkedList<String> list = new LinkedList();
//        Pattern p = Pattern.compile("[а-яА-я]+[ ]{0,1}[а-яА-я]+");
//        Matcher m = p.matcher(aClass);
//        while (m.find()) {
//            list.add(aClass.substring(m.start(), m.end()));
//        }

        LinkedList<Integer> list = new LinkedList<Integer>();
        for (String s : idClass) {
            list.add(Integer.parseInt(s));
        }

        int idTutor = 0;
        try {
            PreparedStatement statement3 = connection.prepareStatement("SELECT id FROM tutors WHERE name = '" + name + "';");
            ResultSet set1 = statement3.executeQuery();
            while (set1.next()) {
                idTutor = set1.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        LinkedList<Integer> listClassId = new LinkedList();
//        for (int i = 0; i < list.size(); i++) {
//            try {
//                PreparedStatement statement4 = connection.prepareStatement("SELECT id FROM class WHERE name = '" + list.get(i) + "';");
//                ResultSet set2 = statement4.executeQuery();
//                while (set2.next()) {
//                    listClassId.add(set2.getInt("id"));
//                }
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
        try {
            PreparedStatement statement2 = connection.prepareStatement("INSERT into class_tutor VALUES (?,?)");
            for (int i = 0; i < list.size(); i++) {
                statement2.setInt(1, list.get(i));
                statement2.setInt(2, idTutor);
                statement2.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("/");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/");
    }
}

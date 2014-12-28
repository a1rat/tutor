import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

/**
 * Created by Àéðàò on 08.11.2014.
 */

public class ServletLogin extends HttpServlet {
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
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
        if (!email.equals("") && !password.equals("")) {
            try {
                PreparedStatement statement = connection.prepareStatement("SELECT COUNT(email) as count FROM TUTORS WHERE email = '" + email + "';");
                ResultSet set = statement.executeQuery();
                while (set.next()) {
                    if (set.getInt("count") == 1) {
//                        System.out.println(2);
                        PreparedStatement statement1 = connection.prepareStatement("SELECT password FROM TUTORS WHERE email = '" + email + "';");
                        ResultSet set1 = statement1.executeQuery();
                        while (set1.next()) {
                            if (sb.toString().equals(set1.getString("password"))) {
                                Cookie cookie = new Cookie("current_user", email);
//                                System.out.println(1);
                                cookie.setMaxAge(3600);
                                cookie.setPath("/");
                                response.addCookie(cookie);
                                HttpSession hs = request.getSession();
                                hs.setAttribute("current_user", email);
                                response.sendRedirect("/lk");
                            } else {
                                response.sendRedirect("/index.jsp");
                            }
                        }
                    } else {
                        response.sendRedirect("/index.jsp");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
//            response.sendRedirect("/index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.sendRedirect("/index.jsp");
    }
}

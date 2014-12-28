import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * Created by Айрат on 23.12.2014.
 */
@WebServlet(name = "ServletZ")
public class ServletZ extends HttpServlet {
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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String id = request.getParameter("tutorid");
        String c = request.getParameter("nameClass");
        System.out.println(c);
        int idClass = -1;
        try {
            PreparedStatement s = connection.prepareStatement("SELECT id FROM class WHERE class.name = ?");
            s.executeUpdate(c, 1);
            ResultSet re = s.executeQuery();
            while (re.next()) {
                 idClass = re.getInt(1);
                System.out.println(idClass);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

            try {
                PreparedStatement statement = connection.prepareStatement("insert into aplications values(DEFAULT ,?,?,?,?);");
                statement.setString(1,name);
                statement.setString(2, email);
                statement.setInt(3, idClass);
                statement.setInt(4, Integer.parseInt(id));
                statement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("/tutorInfo?id="+id+"");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/");
    }
}

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by Айрат on 23.12.2014.
 */
@WebServlet(name = "ServletOtz")
public class ServletOtz extends HttpServlet {
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
        String info = request.getParameter("info");
        String id = request.getParameter("tutorid");
        if (!info.equals("") && !name.equals("")) {
            try {
                PreparedStatement statement = connection.prepareStatement("insert into reviews values(?,?,?);");
                statement.setInt(1, Integer.parseInt(id));
                statement.setString(2, info);
                statement.setString(3,name);
                statement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("/tutorInfo?id="+id+"");
        } else {
            response.sendRedirect("/");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/");
    }
}

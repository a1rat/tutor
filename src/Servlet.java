import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Created by Айрат on 16.11.2014.
 */
@WebServlet(name = "Servlet")
public class Servlet extends HttpServlet {
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

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        PrintWriter pw = response.getWriter();
////        try {
//////            PreparedStatement statement1 = connection.prepareStatement("SELECT * FROM cities;");
//////            ResultSet set = statement1.executeQuery();
//////            while (set.next()) {
//////                pw.print(set.getInt("id"));
//////                pw.print(set.getString("name"));
////////                idCity = set.getInt("id");
//////            }
//////            PreparedStatement s = connection.prepareStatement("SELECT name From class");
//////            ResultSet cl = s.executeQuery();
//////            while (cl.next()) {
//////                pw.print(cl.getString("name"));
//////                }
////            PreparedStatement statement1 = connection.prepareStatement("SELECT password FROM tutors");
////            ResultSet set1 = statement1.executeQuery();
////            while (set1.next()) {
////                pw.print(set1.getString("password"));
////            }
////        } catch (SQLException e) {
////            e.printStackTrace();
////        }
//        PreparedStatement statement1 = null;
//        int idCity = 0;
//        try {
//            statement1 = connection.prepareStatement("SELECT * FROM cities WHERE cities.name ='Казань'");
//            ResultSet set = statement1.executeQuery();
//            while (set.next()) {
////                pw.print(set1.getInt("id"));
////                pw.print(set.getString("name"));
//                idCity = set.getInt("id");
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        pw.print(idCity);
        String city = request.getParameter("city");
        PrintWriter pw = response.getWriter();
        int idCity = 0;
        try {
            Statement statement1 = connection.createStatement();
//            statement1.setString(1,city);
            ResultSet set = statement1.executeQuery("SELECT * FROM cities");
            while (set.next()) {
                pw.print(set.getInt("id"));
                pw.print(set.getString("name"));
                idCity = set.getInt("id");
                pw.print(idCity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

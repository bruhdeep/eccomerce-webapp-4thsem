package controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PassEncrypt;
import resources.MyConstants;

@WebServlet("/editUser")
public class EditUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user details from request parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Retrieve username from session
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Connect to the database
        	Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn1 = DriverManager.getConnection(MyConstants.DB_URL, MyConstants.DB_USER_NAME, MyConstants.DB_USER_PASSWORD);

            // Prepare SQL statement to update user details
            String sql = "UPDATE users SET firstName=?, lastName=?, email=?, password = ? WHERE username=?";
            stmt = conn1.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            try {
				stmt.setString(4, password = PassEncrypt.encrypt(password, MyConstants.encCode));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            stmt.setString(5, username);

            // Execute SQL statement to update user details
            int rowsUpdated = stmt.executeUpdate();

            // Check if any rows were updated
            if (rowsUpdated > 0) {
                // User details updated successfully
            	response.sendRedirect(request.getContextPath() + "/pages/profile.jsp");
            } else {
                // Failed to update user details
                response.getWriter().println("Failed to update user details.");
            }
        } catch (SQLException ex) {
            // Handle database errors
            ex.printStackTrace();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            // Close database resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    
}

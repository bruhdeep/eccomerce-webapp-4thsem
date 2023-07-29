package controller.servlets.login;

import java.io.*;		
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.PassEncrypt;
import resources.MyConstants;

import java.sql.*;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        // Retrieve parameters from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection conn = null;
        
        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(MyConstants.DB_URL, MyConstants.DB_USER_NAME, MyConstants.DB_USER_PASSWORD);
            
            // Execute the query to check if the user exists
            String query = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password = PassEncrypt.encrypt(password, MyConstants.encCode));
            ResultSet rs = stmt.executeQuery();
            
            // Check if the user exists
            if (rs.next()) {
            	
            	String filterquery = "SELECT role FROM users WHERE username = ? AND role = ?";
            	PreparedStatement stmm = conn.prepareStatement(filterquery);
            	stmm.setString(1, username);
            	stmm.setString(2, "admin");
            	ResultSet rm = stmm.executeQuery();
            	
            		if (rm.next()) {
            			HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("loggedIn", true);
                        response.sendRedirect(request.getContextPath() + "/pages/admin/adminpanel.jsp");
            		}else {
            			HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("loggedIn", true);
                response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            		}
                
            } else {
                // User does not exist, redirect to login page with error message
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=1");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            // Close the database connection
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
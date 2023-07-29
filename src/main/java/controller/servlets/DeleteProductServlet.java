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

import resources.MyConstants;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // retrieve the product id from the request parameter
        String productId = request.getParameter("productId");


        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(MyConstants.DB_URL, MyConstants.DB_USER_NAME, MyConstants.DB_USER_PASSWORD);

            // prepare the delete statement
            String deleteQuery = "DELETE FROM products WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
            pstmt.setString(1, productId);

            // execute the delete statement
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // product was successfully deleted, redirect to product list page
                response.sendRedirect(request.getContextPath() + "/ProductListServlet");
            } else {
                // no product was deleted, redirect to error page
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        }
    }
}

package controller.servlets;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import resources.MyConstants;


@WebServlet("/AddProductServlet")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
	    maxFileSize = 1024 * 1024 * 10, // 10 MB
	    maxRequestSize = 1024 * 1024 * 50 // 50 MB
	)
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddProductServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("productName");
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("productPrice"));
		int stock = Integer.parseInt(request.getParameter("productStock"));
		int rating = Integer.parseInt(request.getParameter("productRating"));
		
		Part filePart = request.getPart("productImage");
		String fileName = filePart.getSubmittedFileName();
		
		String uniqueFileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
		
		String uploadDirectory = request.getServletContext().getRealPath("/")+"images/products/";
		Path imagePath=Paths.get(uploadDirectory+uniqueFileName);
		
		try {
			// Connect to the database
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(MyConstants.DB_URL, MyConstants.DB_USER_NAME, MyConstants.DB_USER_PASSWORD);
			
			// Insert the product into the database
			String sql = "INSERT INTO products (productName, category, price, stock, rating, productImage) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, name);
			statement.setString(2, category);
			statement.setDouble(3, price);
			statement.setInt(4, stock);
			statement.setInt(5, rating);
			statement.setString(6, uniqueFileName);
			
			int result = statement.executeUpdate();
			if(result > 0) {
				Files.createDirectories(Paths.get(uploadDirectory));
				boolean created= new File(uploadDirectory+uniqueFileName).createNewFile();
				
				if(created) {
					Files.copy(filePart.getInputStream(), imagePath, StandardCopyOption.REPLACE_EXISTING);
				}
				response.sendRedirect(request.getContextPath() + "/pages/admin/addproduct.jsp");
			}else {
				System.out.println("Data is not inserted");
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}

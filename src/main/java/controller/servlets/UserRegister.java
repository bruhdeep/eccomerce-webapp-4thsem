package controller.servlets;


import java.io.File;			
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;
import model.PassEncrypt;
import resources.MyConstants;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class register
 */
@WebServlet("/UserRegister")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
	    maxFileSize = 1024 * 1024 * 10, // 10 MB
	    maxRequestSize = 1024 * 1024 * 50 // 50 MB
	)
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		
		PrintWriter out = response.getWriter();
		out.write("Hello" + request.getParameter("username"));
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String role = request.getParameter("role").toLowerCase();
		
		//profile picture ko lagi
		Part filePart = request.getPart("profile_pic");
		String fileName = filePart.getSubmittedFileName();
			    
		// uuid
		String uniqueFileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
		String uploadDirectory = request.getServletContext().getRealPath("/")+"images/users/";
		Path imagePath=Paths.get(uploadDirectory+uniqueFileName);
		
		
		
		if (firstName == "" || lastName == "" || email == "" || username == "" || password == "" || confirmPassword == "") {
			request.setAttribute("error", "You are missing shit");
			doGet(request, response);
		}else {
			if (!password.equalsIgnoreCase(confirmPassword)) {
				request.setAttribute("error", "passowrd no match");
				doGet(request, response);
			}else {
				System.out.println("Account is za created");
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection(MyConstants.DB_URL, MyConstants.DB_USER_NAME, MyConstants.DB_USER_PASSWORD);
					String query = "Insert into users(firstName, lastName, email, username, password, role, profilePath) value(?, ?, ?, ?, ?, ?, ?)";
					PreparedStatement st = con.prepareStatement(query);
					st.setString(1, firstName);
					st.setString(2, lastName);
					st.setString(3, email);
					st.setString(4, username);
					try {
						st.setString(5, password = PassEncrypt.encrypt(password, MyConstants.encCode));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					st.setString(6, role);
					st.setString(7, uniqueFileName);
					
					int result = st.executeUpdate();
					if(result > 0) {
						Files.createDirectories(Paths.get(uploadDirectory));
						boolean created= new File(uploadDirectory+uniqueFileName).createNewFile();
						
						if(created) {
							Files.copy(filePart.getInputStream(), imagePath, StandardCopyOption.REPLACE_EXISTING);
						}
						response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
						System.out.println(request.getContextPath() + "/pages/home.jsp");
					}else {
						out.println("Data is not inserted");
					}
					
				
				
				}catch(SQLException ex){
					out.println(ex.getMessage());
					ex.printStackTrace();
				}catch(ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

}

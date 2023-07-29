<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page session = "false" %>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%
    HttpSession session = request.getSession();
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/lugapasaldb";
            Connection con = DriverManager.getConnection(url, "root", "");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='" + username + "'");
            if (rs.next()) {
                String userName = rs.getString("username");
                String fullname = rs.getString("firstName")+ " " + rs.getString("lastName");
                String email = rs.getString("email");
                String imglink = rs.getString("profilePath");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navstyle.css">
	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome-free-6.4.0-web/css/all.css">
<style>
		body {
			background: url("../images/back.jpg") no-repeat;
			background-size: cover;
			font-family: Arial, sans-serif;
			font-size: 14px;
			line-height: 1.6;
			color: #333;
		}
		
		.khalithau{
			min-height: 20vh;
		}
		
		.containerr {
			max-width: 800px;
			margin: 0 auto;
			padding: 20px;
			background-color: #fff;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
			border-radius: 5px;
		}
		h1 {
			margin-top: 0;
			font-size: 28px;
			font-weight: 400;
			text-align: center;
			margin-bottom: 20px;
		}
		.profile-img {
			width: 150px;
			height: 150px;
			border-radius: 50%;
			overflow: hidden;
			margin: 0 auto;
			display: block;
			margin-bottom: 20px;
		}
		.profile-img img {
			width: 100%;
			height: auto;
		}
		
		form {
    max-width: 500px;
    margin: auto;
}

input[type=text], input[type=email] {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid black;
    border-radius: 4px;
    color: black;
}

input[type=submit] {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=submit]:hover {
    background-color: #45a049;
}
		
		
		
	</style>
<title>Profile</title>
</head>
<nav id="navbar">
    <div class="menu">
        <div>
            <img src="${pageContext.request.contextPath}/images/users/<%=imglink%>" alt="logo" width = "200" height="200">
            <ul>
                <li><a href="profile.jsp">Profile</a></li> 
                <li><a href="#">What's new</a></li> 
                <li><a href="#" onclick="logout()">Logout</a>
                <form id="logoutForm" action="${pageContext.request.contextPath}/LogoutServlet" method="post"></form>
                </li> 
            </ul>
            <ul>
                <li><a href="#">Projects</a></li> 
                <li><a href="#">News</a></li> 
                <li><a href="#">Store</a></li> 
                <li><a href="#">About</a></li> 
                <li><a href="#">Contact</a></li> 
            </ul>
            <ul class="social-media">
                <li><a href="#">
                    <i class="fab fa-facebook"></i>
                </a></li> 
                <li><a href="#">
                    <i class="fab fa-instagram"></i>
                </a></li> 
                <li><a href="#">
                    <i class="fab fa-twitter"></i>
                </a></li> 
                <li><a href="#">
                    <i class="fab fa-youtube"></i>
                </a></li> 
            </ul>
            <form action="#">
                <div class="input-wrap">
                    <input type="search" placeholder="Search...">
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
    <div class="container">
        <a href="#" class="brand">Luga pasal</a>
        <div class="container-inner">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="#">Products</a></li>
                <li><% if (session != null && session.getAttribute("username") != null) { %>
    				<!-- user is logged in, show logout button -->
    				<a href="#" onclick="logout()">Logout</a>
                		<form id="logoutForm" action="${pageContext.request.contextPath}/LogoutServlet" method="post"></form>
					<% } else { %>
    				<!-- user is not logged in, show login button -->
    				<a href="${pageContext.request.contextPath}/pages/login.jsp">Login</a>
					<% } %>
				</li>    
            </ul>
            <form action="#">
                <div class="input-wrap">
                    <input type="search" placeholder="Search...">
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>
        <i class="fas fa-bars" id="menu-btn"></i>
    </div>    
</nav>
<script src="${pageContext.request.contextPath}/scripts/navbar.js"></script>
<body>
	<div class = "khalithau"></div>
	<div class="containerr">
		<h1>My Profile</h1>
		<div class="profile-img">
			<img src="${pageContext.request.contextPath}/images/users/<%=imglink%>">
		</div>
		<form action="${pageContext.request.contextPath}/editUser" method="post">
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" required><br>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        <label for="password">Password:</label>
        <input type="text" id="password" name="password" required><br>
        <input type="submit" value="Save Changes">
    </form>
	</div>	

</body>
</html>
<%
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
%>

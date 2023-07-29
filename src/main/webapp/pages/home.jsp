<%@ page session = "true" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="resources.MyConstants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Luga pasal</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navstyle.css">
	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome-free-6.4.0-web/css/all.css">
    
    <script src="https://code .jquery.com/jquery-1.10.2.js"></script>
	<script>
		function logout() {
			 // Submit the logout form
			document.getElementById("logoutForm").submit();
		}
	</script>
</head>
<nav id="navbar">
    <div class="menu">
        <div class = "menuholder">
        <%
    HttpSession usession = request.getSession();
    String username = (String) usession.getAttribute("username");
    if (username == null) {
    	String uimglink = "prof.png";
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String uurl = "jdbc:mysql://localhost:3306/lugapasaldb";
            Connection ucon = DriverManager.getConnection(uurl, "root", "");
            Statement ustmt = ucon.createStatement();
            ResultSet urs = ustmt.executeQuery("SELECT * FROM users WHERE username='" + username + "'");
            if (urs.next()) {
                String uimglink = urs.getString("profilePath");
%>
			<img src="${pageContext.request.contextPath}/images/users/<%=uimglink%>" alt="luga pasal" width = "150" height="150" >
            <%
            }
            urs.close();
            ustmt.close();
            ucon.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
%>
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
                <li><a href="#">Home</a></li>
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
<script src="../scripts/navbar.js"></script>
	<body>
		<div class = "bannerthingy">
		</div>
		<div class="banner-container">
			  <div class="banner-slide">
			    <img src="../images/banner1.jpg" alt="Banner 1">
			  </div>
			  <div class="banner-slide">
			    <img src="../images/banner2.jpg" alt="Banner 2">
			  </div>
			  <div class="banner-slide">
			    <img src="../images/banner3.jpg" alt="Banner 3">
			  </div>
		</div>

	
	
	
	
		<div class="homecontainer">
			<h1>Product Catalog</h1>
			<form action="home.jsp" method="get">
			    <label for="sort"></label>
			    <select id="sort" name="sort">
			    <option value="name">Name</option>
			    <option value="price">Price</option>
			    <option value="rating">Rating</option>
			    </select>
			    <input type="submit" value="Sort">
			</form>
            <%
String sortParam = request.getParameter("sort");
String sortQuery = "";

if (sortParam != null && !sortParam.isEmpty()) {
    if (sortParam.equals("name")) {
        sortQuery = "ORDER BY productName";
    } else if (sortParam.equals("price")) {
        sortQuery = "ORDER BY price";
    } else if (sortParam.equals("rating")) {
        sortQuery = "ORDER BY rating DESC";
    }
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/lugapasaldb";
    Connection con = DriverManager.getConnection(url, "root", "");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT productName, category, price, stock, rating, productImage FROM products " + sortQuery);
    
    while (rs.next()) {
        String productName = rs.getString("productName");
        String category = rs.getString("category");
        int price = rs.getInt("price");
        int stock = rs.getInt("stock");
        int rating = rs.getInt("rating");
        String imagelink = rs.getString("productImage");

        %>

       <div class="product-card">
    <div class="product-image">
        <img src="${pageContext.request.contextPath}/images/products/<%=imagelink%>">
    </div>
    <div class="product-details">
        <h3 class="product-name"><%=productName%></h3>
        <p class="category"><%=category%></p>
        <p class="product-price">Rs. <%=price%></p>
        <p class="product-stock">In Stock: <%=stock%></p>
        <p class="product-rating"><%=rating%>/5</p>
        <div id="add-to-cart-form-container">
            <form id="add-to-cart-form" method="post" action="AddToCartServlet">
                <input type="hidden" name="itemName" value="<%=productName%>">
                <input type="hidden" name="price" value="<%=price%>">
                <input type="hidden" name="quantity" value="1">
                <button id="add-to-cart-btn" type="submit">Add to Cart</button>
            </form>
        </div>
    </div>
</div>

<script>
    var addToCartForm = document.getElementById("add-to-cart-form");
    var addToCartBtn = document.getElementById("add-to-cart-btn");
    
    addToCartBtn.addEventListener("click", function(event) {
        event.preventDefault();
        addToCartForm.submit();
    });
</script>


        <% 
    }
    rs.close();
    stmt.close();
    con.close();
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
}
%>
    	</div>


	</body>
	<script src="../scripts/homebanner.js"></script>
</html>
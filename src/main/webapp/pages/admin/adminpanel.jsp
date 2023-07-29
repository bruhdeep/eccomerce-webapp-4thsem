<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<!--=== Coding by CodingLab | www.codinglabweb.com === -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----======== CSS ======== -->
    <link rel="stylesheet" href="../../css/adminpanelstyle.css">
     
    <!----===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script>
		function logout() {
			 // Submit the logout form
			document.getElementById("logoutForm").submit();
		}
	</script>

    <title>Dashboard</title> 
</head>
<body>
    <nav>
        <div class="logo-name">
            <div class="logo-image">
                <img src="images/logo.png" alt="">
            </div>

            <span class="logo_name">Luga Pasal</span>
        </div>

        <div class="menu-items">
            <ul class="nav-links">
                <li><a href="#">
                    <i class="uil uil-estate"></i>
                    <span class="link-name">Dahsboard</span>
                </a></li>
                <li><a href="addproduct.jsp">
                    <i class="uil uil-files-landscapes"></i>
                    <span class="link-name">Add Product</span>
                </a></li>
                <li><a href="#">
                    <i class="uil uil-chart"></i>
                    <span class="link-name">Analytics</span>
                </a></li>
                <li><a href="#">
                    <i class="uil uil-thumbs-up"></i>
                    <span class="link-name">Like</span>
                </a></li>
                <li><a href="#">
                    <i class="uil uil-comments"></i>
                    <span class="link-name">Comment</span>
                </a></li>
                <li><a href="#">
                    <i class="uil uil-share"></i>
                    <span class="link-name">Share</span>
                </a></li>
            </ul>
            
            <ul class="logout-mode">
                <li><a href="#" onclick="logout()"><i class="uil uil-signout"></i><span class="link-name">Logout</span></a>
                <form id="logoutForm" action="${pageContext.request.contextPath}/LogoutServlet" method="post"></form>
                </li> 

                <li class="mode">
                    <a href="#">
                        <i class="uil uil-moon"></i>
                    <span class="link-name">Dark Mode</span>
                </a>

                <div class="mode-toggle">
                  <span class="switch"></span>
                </div>
            </li>
            </ul>
        </div>
    </nav>

    <section class="dashboard">
        <div class="top">
            <i class="uil uil-bars sidebar-toggle"></i>

            <div class="search-box">
                <i class="uil uil-search"></i>
                <input type="text" placeholder="Search here...">
            </div>
            
            <img src="images/profile.jpg" alt="">
        </div>

        <div class="dash-content">
            <div class="overview">
                <div class="title">
                    <i class="uil uil-tachometer-fast-alt"></i>
                    <span class="text">Dashboard</span>
                </div>

                <div class="boxes">
                    <div class="box box1">
                        <i class="uil uil-thumbs-up"></i>
                        <span class="text">Total Likes</span>
                        <span class="number">69,222,98</span>
                    </div>
                    <div class="box box2">
                        <i class="uil uil-comments"></i>
                        <span class="text">Comments</span>
                        <span class="number">20,120,271</span>
                    </div>
                    <div class="box box3">
                        <i class="uil uil-share"></i>
                        <span class="text">Total Share</span>
                        <span class="number">10,120,11</span>
                    </div>
                </div>
            </div>

            <div class="users">
                <div class="title">
                    <i class="uil uil-clock-three"></i>
                    <span class="text">User details</span>
                </div>

                <div class="activity-data">
                    <table>
					    <tr>
					      <th>firstName</th>
					      <th>lastName</th>
					      <th>email</th>
					      <th>username</th>
					    </tr>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/lugapasaldb";
    Connection con = DriverManager.getConnection(url, "root", "");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT firstName, lastName, email, username FROM users WHERE role = 'customer'");
    
    while (rs.next()) {
        String firstName = rs.getString("firstName");
        String lastName = rs.getString("lastName");
        String email = rs.getString("email");
        String username = rs.getString("username");

        %>
					    <tr>
						<td><%= firstName %></td>
					      <td><%= lastName %></td>
					      <td><%= email %></td>
					      <td><%= username %></td>
					    </tr>
					    <% 
    }
    rs.close();
    stmt.close();
    con.close();
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
}
%>
					</table>
                </div>
            </div>
        </div>
    </section>

    <script src="../../scripts/adminpaneljs.js"></script>
</body>
</html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luga pasal</title>
    <link rel="stylesheet" href="../fontawesome-free-6.4.0-web/css/all.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navstyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginstyle.css">
</head>
<nav id="navbar">
    <div class="menu">
        <div>
            <img src="${pageContext.request.contextPath}/images/prof.png" alt="logo" width = "200" height="200">
            <ul>
                <li><a href="#">Profile</a></li> 
                <li><a href="#">What's new</a></li> 
                <li><a href="#">Catergories</a></li> 
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
        </div>
    </div>
    <div class="container">
        <a href="#" class="brand">Luga pasal</a>
        <div class="container-inner">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="#">Products</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
        <i class="fas fa-bars" id="menu-btn"></i>
    </div>    
</nav>
<script src="${pageContext.request.contextPath}/scripts/navbar.js"></script>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
          <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter username">
          </div>
          <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password">
          </div>
          <button type="submit" class="btn btn-primary">Login</button>
          <a href="register.jsp" class="btn btn-secondary">Register</a>
        </form>
      </div>
</body>
</html>
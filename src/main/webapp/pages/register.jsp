<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luga pasal</title>
    <link rel="stylesheet" href="../fontawesome-free-6.4.0-web/css/all.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navstyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/registerstyle.css">
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
    <div class="register-container">
        <h1>Register</h1>
	    <h1>${error}</h1>
        <form method="post" action="${pageContext.request.contextPath}/UserRegister" enctype="multipart/form-data">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required><br><br>
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required><br><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="password" name="confirmPassword" required><br><br>
            <label for="role">Role:</label>
            <input type="text" id="role" name="role" required><br><br>
            <label for="profile_pic">Profile Picture</label>
            <input type="file" id="profile_pic" name="profile_pic" accept="image/*"><br><br>
			<input type="submit" value="Register">	
        </form>
    </div>
</body>
</html>
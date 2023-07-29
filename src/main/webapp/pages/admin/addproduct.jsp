<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<style>
    /* Some basic styles to make the page look better */
    body {
        font-family: Arial, sans-serif;
        background: url(../../images/mainbg.png);
    }

    .container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  background-color: #1c1c1c;
  color: #fff;
  border-radius: 10px;
}

h1 {
  font-size: 2rem;
  margin-bottom: 20px;
}

form {
  display: flex;
  flex-direction: column;
}

label {
  font-size: 1.2rem;
  margin-bottom: 5px;
}

input, select {
  padding: 10px;
  margin-bottom: 20px;
  border-radius: 5px;
  border: none;
  font-size: 1.2rem;
}

button[type="submit"] {
  background-color: #8b0000;
  color: #fff;
  border: none;
  padding: 10px 20px;
  font-size: 1.2rem;
  border-radius: 5px;
  cursor: pointer;
}

button[type="submit"]:hover {
  background-color: #ff0000;
}

input[type="file"] {
  margin-bottom: 20px;
}

.error-message {
  color: #ff0000;
  font-size: 1.2rem;
  margin-bottom: 20px;
}
    

</style>
</head>
<body>
    <div class="container">
        <h1>Add Product</h1>
        <form action="${pageContext.request.contextPath}/AddProductServlet" method="post" enctype="multipart/form-data">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName">
            <label for="category">Category:</label>
            <input type="text" id="category" name="category">
            <label for="productPrice">Product Price:</label>
            <input type="number" id="productPrice" name="productPrice">
            <label for="productStock">Product Stock:</label>
            <input type="number" id="productStock" name="productStock">
            <label for="productRating">Product Rating:</label>
            <input type="number" id="productRating" name="productRating">
            <label for="productImage">Product Image</label>
            <input type="file" id="productImage" name="productImage" accept="image/*">
            <button type="submit">Add Product</button>
        </form>
    </div>
</body>
</html>

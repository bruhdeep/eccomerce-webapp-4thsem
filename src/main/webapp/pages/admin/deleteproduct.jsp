<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Delete Product</title>
	<style>
	body {
  background-color: #f2f2f2;
  font-family: Arial, sans-serif;
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

h1 {
  font-size: 32px;
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
}

table th, table td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

table th {
  background-color: #f2f2f2;
}

.delete-btn {
  background-color: #ff0000;
  color: #fff;
  border: none;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
}

.delete-btn:hover {
  background-color: #cc0000;
}
	
	</style>
</head>
<body>
	<h1>Delete Product</h1>
	
	<%-- Retrieve product ID from request parameter --%>
	<%
		String productId = request.getParameter("productId");
		if (productId == null || productId.isEmpty()) {
			out.println("<p>Invalid product ID.</p>");
			return;
		}
	%>
	
	<form action="${pageContext.request.contextPath}/DeleteProductServlet" method="post">
		<input type="hidden" name="productId" value="<%=productId%>">
		<input type="submit" value="Delete Product">
	</form>
	
</body>
</html>

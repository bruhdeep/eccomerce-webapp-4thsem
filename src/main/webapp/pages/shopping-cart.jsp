<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    List<CartItem> cartItems = cart.getCartItems();
%>

<table>
    <thead>
        <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
        </tr>w
    </thead>
    <tbody>
        <% for (CartItem item : cartItems) { %>
            <tr>
                <td><%= item.getItemName() %></td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getQuantity() %></td>
            </tr>
        <% } %>
        <tr>
            <td colspan="2">Total Price:</td>
            <td><%= cart.getTotalPrice() %></td>
        </tr>
    </tbody>
</table>

package controller.servlets;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {
    private List<CartItem> cartItems;
    private double totalPrice;

    public ShoppingCart() {
        cartItems = new ArrayList<>();
        totalPrice = 0.0;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void addToCart(CartItem item) {
        cartItems.add(item);
        totalPrice += item.getPrice() * item.getQuantity();
    }
}

package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String itemName = request.getParameter("itemName");
	    double price = Double.parseDouble(request.getParameter("price"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));

	    CartItem item = new CartItem(itemName, price, quantity);

	    HttpSession session = request.getSession();
	    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

	    if (cart == null) {
	        cart = new ShoppingCart();
	        session.setAttribute("cart", cart);
	    }

	    cart.addToCart(item);

	    response.sendRedirect("shopping-cart.jsp");
	}


}

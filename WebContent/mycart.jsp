<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.ShoppingCart"%>
<%@page import="johnny.gamestore.mysql.beans.CartItem"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_CART);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }

    ShoppingCart cart;
    synchronized(session) {
        cart = (ShoppingCart)session.getAttribute(Constants.SESSION_CART);
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute(Constants.SESSION_CART, cart);
        }
        String id = request.getParameter("id");
        String strtype = request.getParameter("type");
        int type = 0;
        if (strtype!=null) {
            try {
                type = Integer.parseInt(strtype);
            } catch (NumberFormatException nfe) {

            }
        }
        if (id != null && !id.isEmpty()) {
            String strQuantity = request.getParameter("quantity");
            if (strQuantity == null) {                  
                cart.addItem(id, type);
            } else {                  
                int quantity;
                try {
                    quantity = Integer.parseInt(strQuantity);
                } catch(NumberFormatException nfe) {
                    quantity = 1;
                }
                cart.setItemQuantity(id, type, quantity);
            }
        }
    }
    
    List<CartItem> list = cart.getItems();
    pageContext.setAttribute("list", list);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>My Cart</h3>
        <c:choose>
            <c:when test="${list.size() == 0}">
                <h3 style='color:red'>Your Cart is empty!</h3>    
            </c:when>
            <c:otherwise>
                <c:set var="total" value="0" scope="page" />
                <c:set var="counter" value="0" scope="page" />
                <table cellspacing='0'>
                    <tr><th>No.</th><th>Name</th><th>Price</th><th>Quantity</th><th>SubTotal</th><th>Management</th></tr>
                <c:forEach var="cartitem" items="${list}">
                    <tr>
                        <td><c:out value="${counter + 1}"/></td><td><c:out value="${cartitem.itemName}"/></td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${cartitem.unitPrice}" type="currency"/></td>
                        <td>
                            <form>
                                <input type="hidden" name="id" value="<c:out value="${cartitem.itemId}"/>">
                                <input type="hidden" name="type" value="<c:out value="${cartitem.itemType}"/>">
                                <input type="text" name="quantity" size=3 value="<c:out value="${cartitem.quantity}"/>">
                                <input type="submit" class="formbutton2" value="Update">      
                            </form>
                        </td>
                        <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${cartitem.getTotalCost()}" type="currency"/></td>
                        <td><span><a href='mycart.jsp?id=<c:out value="${cartitem.itemId}"/>&type=<c:out value="${cartitem.itemType}"/>&quantity=0' class='button3' onclick = \"return confirm('Are you sure to delete this product?')\">Delete</a></span></td>
                    </tr>
                    <c:set var="total" value="${total + cartitem.getTotalCost()}" scope="page"/>
                    <c:set var="counter" value="${counter + 1}" scope="page"/>
                </c:forEach>
                <tr class='total'><td></td><td></td><td></td><td>Total</td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${total}" type="currency"/></td><td></td></tr>
                <tr><td></td><td></td><td></td><td></td><td></td><td><a href='checkout.jsp' class='button2'>Check Out</a></td></tr></table>
            </c:otherwise>
        </c:choose>
    </div>
</section>    
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.Order"%>
<%@page import="johnny.gamestore.mysql.beans.ShoppingCart"%>
<%@page import="johnny.gamestore.mysql.beans.CartItem"%>
<%@page import="johnny.gamestore.mysql.beans.OrderItem"%>
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
    
    String username = helper.username();
    String address = request.getParameter("address");
    String creditcard = request.getParameter("creditcard");
    
    String errmsg = "";    
    if (address == null || address.isEmpty() || creditcard == null || creditcard.isEmpty()) {
        errmsg = "Invalid parameter! Go back to Cart to process again!";
    }
    
    ShoppingCart cart = null;
    List<CartItem> list = null;
    String orderid = "";
    String confirmation = "";
    Calendar c = null;
    
    if (errmsg.isEmpty()) {
        synchronized(session) {
            cart = (ShoppingCart)session.getAttribute(Constants.SESSION_CART);
            if (cart == null) {
                errmsg = "No item in shopping cart, can't place order!";
            } else {
                list = cart.getItems();
                if (list == null || list.size() == 0) { 
                    errmsg = "No item in shopping cart, can't place order!";
                }                
            }
        }        

        orderid = helper.generateUniqueId();
        confirmation = username + orderid.substring(orderid.length()-4) + creditcard.substring(creditcard.length() - 4);
        
        if (errmsg.isEmpty()) {
            Date now = new Date();
            c = Calendar.getInstance();
            c.setTime(now);
            c.add(Calendar.DATE, 14); // 2 weeks
             //create order
            Order order = new Order(0, helper.username(), address, creditcard, confirmation, c.getTime());
            for (CartItem ob: list) {
                OrderItem item = new OrderItem(0, 0, ob.getItemId(), ob.getItemName(), ob.getItem().getType(), ob.getItem().getPrice(), ob.getItem().getImage(), ob.getItem().getMaker(), ob.getItem().getDiscount(), 1);
                item.setQuantity(ob.getQuantity());
                order.addItem(item);
            }

            // create 
            int generatedKey = OrderDB.insert(order);
            order.setId(generatedKey);
            // remove cart from session
            session.removeAttribute(Constants.SESSION_CART);
            pageContext.setAttribute("order", order);
            pageContext.setAttribute("list", list);
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>Order - Confirmation</h3>
        <c:choose>
            <c:when test="${not empty errmsg}">
                <h3 style='color:red'>${errmsg}</h3>    
            </c:when>
            <c:otherwise>
                <c:set var="total" value="0" scope="page" />
                <c:set var="counter" value="0" scope="page" />
                <table class="order_table">
                    <tr><td width="30%"><h5><i>Order Id: </i></h5></td><td width="70%">${order.id}</td></tr>
                    <tr><td><h5><i>Customer Name: </i></h5></td><td>${order.userName}</td></tr>
                    <tr><td><h5><i>Address: </i></h5></td><td>${order.address}</td></tr>
                    <tr><td><h5><i>Confirmation Number: </i></h5></td><td>${order.confirmationNumber}</td></tr>    
                    <tr><td><h5><i>Delivery Date: </i></h5></td><td>${order.formatDeliveryDate}</td><td></td></tr>
                </table>
                <table cellspacing='0'>
                    <tr><th>No.</th><th>Product Name</th><th>Price</th><th>Quantity</th><th>SubTotal</th></tr>                
                <c:forEach var="cartitem" items="${list}">
                    <tr>
                        <td><c:out value="${counter + 1}"/></td>
                        <td><c:out value="${cartitem.itemName}"/></td>
                        <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${cartitem.unitPrice}" type="currency"/></td>
                        <td><c:out value="${cartitem.quantity}"/></td>                                 
                        <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${cartitem.totalCost}" type="currency"/></td>
                    </tr>
                    <c:set var="total" value="${total + cartitem.totalCost}" scope="page"/>
                    <c:set var="counter" value="${counter + 1}" scope="page"/>
                </c:forEach>
                <tr class='total'><td></td><td></td><td></td><td>Total</td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${total}" type="currency"/></td></tr>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
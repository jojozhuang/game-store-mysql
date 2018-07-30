<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.Order"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_MYORDER);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }

    String errmsg = "";
    List<Order> orders = OrderDB.getList(helper.username());
    if (orders == null || orders.size() == 0) {
        errmsg = "You have no order yet!";
    }

    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("orders", orders);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>My Orders</h3>
        <c:choose>
            <c:when test="${not empty errmsg}">
                <h3 style='color:red'>${errmsg}</h3>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${orders}">
                    <div class="order_box">
                        <table class="order_table">
                            <tr><td><h5><i>Order Id: </i></h5></td><td><c:out value="${order.id}"/></td>
                                <td>
                                    <form action="ordercancel.jsp" method="Post"> 
                                        <input type="hidden" name="orderid" value="<c:out value="${order.id}"/>">
                                        <input type="submit" value="Cancel Order" class="formbutton" onclick = "return confirm('Are you sure to cancel this order?')">     
                                    </form>
                                </td>
                            </tr>
                            <tr><td><h5><i>Customer Name: </i></h5></td><td><c:out value="${order.userName}"/></td><td></td></tr>
                            <tr><td><h5><i>Address: </i></h5></td><td><c:out value="${order.address}"/></td><td></td></tr>
                            <tr><td><h5><i>Confirmation Number: </i></h5></td><td><c:out value="${order.confirmationNumber}"/></td><td></td></tr>
                            <tr><td><h5><i>Delivery Date: </i></h5></td><td><c:out value="${order.formatDeliveryDate}"/></td><td></td></tr>
                        </table>
                        <table cellspacing='0'>
                            <tr><th>No.</th><th>Name</th><th>Price</th><th>Quantity</th><th>SubTotal</th></tr>
                            <c:set var="total" value="0" scope="page" />
                            <c:set var="counter" value="0" scope="page" />
                            <c:forEach var="orderitem" items="${order.getItems()}">                                
                                <tr>
                                    <td><c:out value="${counter + 1}"/></td>
                                    <td><c:out value="${orderitem.productName}"/></td>
                                    <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${orderitem.unitPrice}" type="currency"/></td>
                                    <td><c:out value="${orderitem.quantity}"/></td>                                 
                                    <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${orderitem.totalCost}" type="currency"/></td>
                                </tr>
                                <c:set var="total" value="${total + orderitem.getTotalCost()}" scope="page"/>
                                <c:set var="counter" value="${counter + 1}" scope="page"/>
                            </c:forEach>
                            <tr class='total'><td></td><td></td><td></td><td>Total</td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${total}" type="currency"/></td></tr>
                        </table>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    <div class='clear'></div>
</section>    
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
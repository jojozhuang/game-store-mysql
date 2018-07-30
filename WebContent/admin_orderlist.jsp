<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.Order"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_ALLORDERS);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    
    String usertype = helper.usertype();
    String errmsg = "";
    if (usertype==null || !usertype.equals(Constants.CONST_TYPE_SALESMAN_LOWER)) {
        errmsg = "You have no authorization to manage order!";
    }

    List<Order> list = OrderDB.getList();
    if (list == null || list.size() == 0) {
        errmsg = "There is no order yet!";
    } else {
        String orderid = request.getParameter("orderid");
        String itemid = request.getParameter("itemid");
        String strtype = request.getParameter("type");
        String strQuantity = request.getParameter("quantity");
        if (orderid!=null && itemid != null && strtype != null && strQuantity != null) {
            int type = 0;
            try {
                type = Integer.parseInt(strtype);
            } catch (NumberFormatException nfe) {

            }            
            int quantity;
            try {
                quantity = Integer.parseInt(strQuantity);
            } catch(NumberFormatException nfe) {
                quantity = 1;
            }
            OrderDB.setItemQuantity(Integer.parseInt(orderid), Integer.parseInt(itemid), quantity);
        }
    }
    
    if ("GET".equalsIgnoreCase(request.getMethod())) {
        if (list != null) {
            for (Order ord: list) {
                session.removeAttribute("OrderItem"+ord.getId());                
            }
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("list", list);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>All Orders</h3>
        <c:choose>
            <c:when test="${not empty errmsg}">
                <h3 style='color:red'>${errmsg}</h3>
            </c:when>
            <c:otherwise>
                <div style='padding:5px'><a href='admin_orderadd.jsp' class='button'>Create New Order</a></div>
                <table cellspacing='0'>
                    <tr><th>Order Id</th><th>Customer Name</th><th>Delivery Date</th><th>Management</th></tr>
                <c:forEach var="order" items="${list}">
                    <tr>
                        <td><c:out value="${order.id}"/></td><td><c:out value="${order.userName}"/></td><td><c:out value="${order.formatDeliveryDate}"/></td>
                        <td>
                            <span style='padding-right:3px;'><a href='admin_orderedit.jsp?orderid=<c:out value="${order.id}"/>' class='button'>Edit</a></span>
                            <span><a href='admin_orderdel.jsp?orderid=<c:out value="${order.id}"/>' class='button' onclick = "return confirm('Are you sure to delete this order?')">Delete</a></span>
                        </td>
                    </tr>
                </c:forEach>               
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</section>    
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
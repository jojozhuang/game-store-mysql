<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.Order"%>
<%@page import="johnny.gamestore.mysql.beans.OrderItem"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    String errmsg = "";
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_MYORDER);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    
    String orderid = request.getParameter("orderid");
    if (orderid==null||orderid.isEmpty()) {
        errmsg = "Invalid parameter! Order id is empty!";
    }

    if (errmsg.isEmpty()) {
        List<Order> orders = OrderDB.getList();
        synchronized(session) {
            if (orders == null || orders.size() == 0) {
                errmsg = "You have no order!";
            } else {
                Order order = OrderDB.getOrder(Integer.parseInt(orderid));
                if (order == null) {
                    errmsg = "Order ["+orderid+"] is not found!";
                } else {                    
                    List<OrderItem> items = order.getItems();
                    for (OrderItem item: items) {
                        if (item.getProductType() == 4 || item.getProductType() == 5) {
                            Date deliverydate = order.getDeliveryDate();
                            Calendar c = Calendar.getInstance();
                            c.setTime(deliverydate);
                            c.add(Calendar.DATE, -5);
                            Date now = new Date();
                            int comparison = now.compareTo(c.getTime());
                            if (comparison > 0) {
                                errmsg = "The order can only be cancelled within 5 days before delivery date ["+helper.formateDate(order.getDeliveryDate())+"]"
                                        + "<br><h2 style=\"color:red;\">You can't cancel it now.</h2>";
                            }
                        }
                    }
                }
            }
            if (errmsg.isEmpty()) {
                OrderDB.delete(Integer.parseInt(orderid));
                errmsg = "Your order ["+orderid+"] has been removed!";
            }
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>Cancel Order</h3>
        <h3 style='color:red'>${errmsg}</h3>
    </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
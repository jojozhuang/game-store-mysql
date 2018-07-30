<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="johnny.gamestore.mysql.beans.User"%>
<%@page import="johnny.gamestore.mysql.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="johnny.gamestore.mysql.beans.SelectorOption"%>
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
    
    String orderid = request.getParameter("orderid");
    if (orderid==null||orderid.isEmpty()) {
        errmsg = "Invalid Paramters!";
    }
    
    Order order = (Order)session.getAttribute("OrderItem"+orderid);
    if (errmsg.isEmpty()) {        
        Order orgorder = OrderDB.getOrder(Integer.parseInt(orderid));
        if (orgorder == null) {
            errmsg = "Order ["+orderid+"] does not exist!";
        } else {
            if (order == null) {
                // copy from the original instance
                order = new Order();
                order.setId(orgorder.getId());
                order.setUserName(orgorder.getUserName());
                order.setAddress(orgorder.getAddress());
                order.setCreditCard(orgorder.getCreditCard());
                order.setConfirmationNumber(orgorder.getConfirmationNumber());
                order.setDeliveryDate(orgorder.getDeliveryDate());
                order.setItems(orgorder.getItems());
                session.setAttribute("OrderItem"+orderid, order);
            } else {            
                String address = request.getParameter("address");
                String creditcard = request.getParameter("creditcard");
                String actiontype = request.getParameter("actiontype");

                if ("GET".equalsIgnoreCase(request.getMethod())) {
                    //order.setAddress(address);
                    //order.setCreditCard(creditcard);
                } else {
                    if (actiontype != null && actiontype.equals("save")){
                        order.setAddress(address);
                        order.setCreditCard(creditcard);
                        if (address == null || address.isEmpty()) {
                            errmsg = "Address can't be empty!";
                        } else if (creditcard == null || creditcard.length() != 16) {
                            errmsg = "Credit card can't be empty and must be 16 numbers length!";
                        } else {
                            if (order != null) {
                                if (order.getItems().size() == 0) {
                                    errmsg = "The order contains nothing. You must choose at least one product!";
                                } else {
                                    String uniqueid = helper.generateUniqueId();
                                    String confirmation = order.getUserName() + uniqueid.substring(uniqueid.length()-4) + creditcard.substring(creditcard.length() - 4);
                                    Date now = new Date();
                                    Calendar c = Calendar.getInstance();
                                    c.setTime(now);
                                    c.add(Calendar.DATE, 14); // 2 weeks
                                    //set order                        
                                    order.setConfirmationNumber(confirmation);
                                    order.setDeliveryDate(c.getTime());
                                    // update, save to file
                                    Order updOrder = OrderDB.getOrder(order.getId());
                                    updOrder.setAddress(order.getAddress());
                                    updOrder.setCreditCard(order.getCreditCard());
                                    updOrder.setItems(order.getItems());
                                    OrderDB.update(order);                                    
                                    session.removeAttribute("OrderItem"+orderid);
                                    errmsg = "Order ["+order.getId()+"] is updated!";
                                    order = OrderDB.getOrder(Integer.parseInt(orderid));
                                    session.setAttribute("OrderItem"+orderid, order);
                                }
                            }
                        }
                    }
                }    

                if (actiontype != null && actiontype.equals("updatequantity")){                    
                    if (order != null) {  
                        String itemid = request.getParameter("itemid");
                        int id = Integer.parseInt(itemid);
                        if (itemid != null && !itemid.isEmpty()) {
                            String strQuantity = request.getParameter("quantity");
                            int quantity;
                            if (strQuantity == null || strQuantity.isEmpty()) {
                                quantity = 0;
                            } else {
                                try {
                                    quantity = Integer.parseInt(strQuantity);
                                } catch(NumberFormatException nfe) {
                                    quantity = 1;
                                }
                            }
                            order.setItemQuantity(id, quantity);
                        }
                    }
                }
            }
        }
    }    
    
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("order", order);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>Edit Order</h3>   
        <h3 style='color:red'>${errmsg}</h3>
        <div class="order_box">
            <form action="admin_orderedit.jsp?actiontype=save" method="Post">
                <input type='hidden' name='orderid' id='orderid' value='${order.id}'>
                <input type='hidden' name='username' id='username' value='${order.userName}'>
                <table class="order_table">               
                    <tr><td><h5><i>User Name: </i></h5></td><td>${order.userName}</td><td><input type="submit" class="formbutton" value="Save"></td></tr>
                    <tr><td><h5><i>Address: </i></h5></td><td><input type='text' name='address' id='address' value='${order.address}' required /></td><td></td></tr>
                    <tr><td><h5><i>Credit Card Number: </i></h5></td><td><input type='text' name='creditcard' id='creditcard' value='${order.creditCard}' required /></td><td></td></tr>
                    <tr><td><h5><i>Confirmation Number: </i></h5></td><td><c:out value="${order.confirmationNumber}"/></td><td></td></tr>
                    <tr><td><h5><i>Delivery Date: </i></h5></td><td><c:out value="${order.formatDeliveryDate}"/></td><td></td></tr>
                </table>
            </form>
            <table cellspacing='0'>
                <tr><th>No.</th><th>Name</th><th>Price</th><th>Quantity</th><th>SubTotal</th><th>Management</th></tr>
                <c:set var="total" value="0" scope="page" />
                <c:set var="counter" value="0" scope="page" />
                <c:forEach var="orderitem" items="${order.getItems()}">                                
                    <tr>
                        <td><c:out value="${counter + 1}"/></td>
                        <td><c:out value="${orderitem.productName}"/></td>
                        <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${orderitem.unitPrice}" type="currency"/></td>
                        <td>
                            <form action="admin_orderedit.jsp?actiontype=updatequantity" method="Post">
                                <input type="hidden" name="orderid" value="<c:out value="${order.id}"/>">
                                <input type="hidden" name="itemid" value="<c:out value="${orderitem.orderItemId}"/>">
                                <input type="text" name="quantity" size=3 value="<c:out value="${orderitem.quantity}"/>">
                                <input type="submit" class="formbutton2" value="Update">
                            </form>
                        </td>
                        <td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${orderitem.totalCost}" type="currency"/></td>
                        <td>
                            <span><a href='admin_orderedit.jsp?actiontype=updatequantity&orderid=<c:out value="${order.id}"/>&itemid=<c:out value="${orderitem.orderItemId}"/>&quantity=0' class='button3' onclick = "return confirm('Are you sure to delete this product?')">Delete</a></span>
                        </td>
                    </tr>
                    <c:set var="total" value="${total + orderitem.getTotalCost()}" scope="page"/>
                    <c:set var="counter" value="${counter + 1}" scope="page"/>
                </c:forEach>
                <tr class='total'><td></td><td></td><td></td><td>Total</td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${total}" type="currency"/></td><td></td></tr>
                <tr><td colspan="2"><a class='fancybox fancybox.iframe button2' href='admin_orderitemedit.jsp'>Add Item</a></td><td></td><td></td><td></td><td></td></tr>
            </table>
        </div>       
    </div>
</section>

<script>
    $().ready(function () {
        $('#username').change(function() {
            sethref();
        });
        $('#address').change(function() {
            sethref();
        });
        $('#creditcard').change(function() {
            sethref();
        });
        $(".fancybox").fancybox({
            fitToView: false,
            autoSize: false,
            autoDimensions: false,
            width: 370,
            height: 260,
            afterClose: function () { 
                location.href = 'admin_orderedit.jsp?orderid='+$('#orderid').val();
                //location.href = location.href;                
            } //window.location.reload(); }
        });
        sethref();
        function sethref() {
            var orderid = $('#orderid').val();
            var username = $('#username').val();
            var address = $('#address').val();
            var creditcard = $('#creditcard').val();
            var url = 'admin_orderitemedit.jsp?orderid='+orderid+'&username='+username+'&address='+address+'&creditcard='+creditcard;
            $('.fancybox').attr('href', url);
        }
    });
 </script>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
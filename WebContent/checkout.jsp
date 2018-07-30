<%@page import="johnny.gamestore.mysql.beans.Payment"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    String errmsg = "";
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_CART);
    
    Payment payment = new Payment(helper.username(), "1st Jackson Ave,Chicago,IL", "3101122033287498");
    if ("GET".equalsIgnoreCase(request.getMethod())) {
        
    } else {         
        String address = request.getParameter("address");
        String creditcard = request.getParameter("creditcard");
        payment.setAddress(address);
        payment.setCreditCard(creditcard);
        if (address == null || address.isEmpty()) {
            errmsg = "Address can't be empty!";
        } else if (creditcard == null || creditcard.length() != 16) {
            errmsg = "Credit card can't be empty and must be 16 numbers length!";
        }

        if (errmsg.isEmpty()) {
            request.setAttribute("address", address);
            request.setAttribute("creditcard", creditcard);
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/orderplace.jsp");
            dispatcher.forward(request, response);
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("payment", payment);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div class="post">
    <h3>Provide your address and credit card</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <form action="checkout.jsp" method="Post">
      <table style='width:55%'>
        <tr><td>Full Name:</td><td><input type='text' name='username' value='${payment.name}' required disabled/></td></tr>
        <tr><td>Address:</td><td><input type='text' name='address' value='${payment.address}' required /></td></tr>
        <tr><td>Credit Card Number</td><td><input type='text' name='creditcard' value='${payment.creditCard}' required /></td></tr>
        <tr><td><a href='mycart.jsp' class='button2'>Back to cart</a></td><td><input name="create" value="Place Order" type="submit" class="formbutton" /></td></tr>
      </table>	  
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
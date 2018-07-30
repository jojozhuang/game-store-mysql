<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.dao.ProductDao"%>
<%@page import="johnny.gamestore.mysql.dao.ConsoleDao"%>
<%@page import="johnny.gamestore.mysql.dao.GameDao"%>
<%@page import="johnny.gamestore.mysql.dao.TabletDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.ProductItem"%>
<%@page import="johnny.gamestore.mysql.beans.Console"%>
<%@page import="johnny.gamestore.mysql.beans.Accessory"%>
<%@page import="johnny.gamestore.mysql.beans.Game"%>
<%@page import="johnny.gamestore.mysql.beans.Tablet"%>
<%@page import="johnny.gamestore.mysql.beans.Review"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    String errmsg = "";
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_HOME);
    
    String productkey = request.getParameter("productkey");
    String rating = "";
    String reviewtext = "";
    
    if (productkey == null || productkey.isEmpty()) {
        errmsg = "Invalid Parameter. Cannot find product: " + productkey;
    } else {
        ProductDao dao = ProductDao.createInstance();
        
        if ("GET".equalsIgnoreCase(request.getMethod())) {

        } else {
            if(!helper.isLoggedin()){
                session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
                response.sendRedirect("account_login.jsp");
                return;
            }
            
            ProductItem product = dao.getProduct(productkey);            
            if (product == null) {
                errmsg = "No such product: " + productkey;
            } else {
                rating = request.getParameter("rating");
                reviewtext = request.getParameter("reviewtext");
                if (rating!=null&&reviewtext!=null) {
                    Review newreview = new Review(helper.generateUniqueId(), productkey, helper.username(), Integer.parseInt(rating), new Date(), reviewtext);
                    //product.getReviews().add(0, newreview);
                    switch(product.getType()) {
                        case 1:
                            ConsoleDao consoleDao = ConsoleDao.createInstance();
                            consoleDao.addConsoleReview(product.getId(), newreview);
                            break;
                        case 2:
                            ConsoleDao consoleDao2 = ConsoleDao.createInstance();
                            consoleDao2.addAccessoryReview(product.getConsole(), product.getId(), newreview);
                            break;
                        case 3:
                            GameDao gameDao = GameDao.createInstance();
                            gameDao.addGameReview(product.getId(), newreview);
                            break;
                        case 4:
                            TabletDao tabletDao = TabletDao.createInstance();
                            tabletDao.addTabletReview(product.getId(), newreview);
                            break;
                    }
                }
            }
        }
        
        ProductItem product = dao.getProduct(productkey);
        List<Review> list = product.getReviews();
        pageContext.setAttribute("list", list);
        pageContext.setAttribute("product", product);
        pageContext.setAttribute("errmsg", errmsg);
    }
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div class="post">
    <h3 class="title">Product Review</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <div class="entry">
      <h2>${product.name}</h2>
      <img src="images/${product.image}" style="width: 300px;" />
      <br>
      <hr>
      <h5>Submit Your Review</h5>
      <form action='review.jsp' method='POST'>
          <input type='hidden' name='productkey' value='${product.id}'>
        <table>
            <tr><td>Rating:</td><td><select name='rating' class='input'><option value='5' selected>5</option><option value='4'>4</option><option value='3'>3</option><option value='2'>2</option><option value='1'>1</option></select></td></tr>
            <tr><td>Comments:</td><td><textarea name="reviewtext" rows="5" cols="50"></textarea></td></tr>
            <tr><td></td><td><input type='submit' class='formbutton' value='Submit'></td></tr>
        </table>        
      </form>
      <hr>
        <c:choose>
            <c:when test="${list.size() == 0}">
                <h3>0 Comment</h3>
                <hr style="border-top: dotted 1px;" />
            </c:when>
            <c:otherwise>
                <h3><c:out value="${list.size()}"/> Comments</h3>
                <hr style="border-top: dotted 1px;" />
                <c:forEach var="review" items="${list}">
                    <table cellspacing='0'>
                        <tr><td><b><c:out value="${review.userName}"/></b></td><td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${review.reviewDate}" /></td></tr>
                        <tr><td>Rating:</td><td><c:out value="${review.rating}"/></td></tr>
                        <tr><td>Comment:</td><td><c:out value="${review.reviewText}"/></td></tr>
                        <tr><td colspan="2"></td></tr>
                    </table>                
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
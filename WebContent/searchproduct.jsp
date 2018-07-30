<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="johnny.gamestore.mysql.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.ProductItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_HOME);
    String productName = request.getParameter("productname");
    productName = productName == null ? "" : productName;
    
    ProductDao dao = ProductDao.createInstance();
    ArrayList<ProductItem> list = dao.searchProduct(productName);
    
    pageContext.setAttribute("list", list);    
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <h3>Product Search Result</h3>
    <c:choose>
        <c:when test="${list.size()==0}">
            <h3>No matched result found!</h3> 
        </c:when>
        <c:otherwise>
            <c:set var="counter" value="0" scope="page" />
            <c:forEach var="product" items="${list}">   
                <c:if test="${(counter + 1)%3 == 1}">
                    <div class='special_grid_row'>     
                </c:if>
                <div class="special_grid_col">
                  <div class="special_box">
                    <img src="images/<c:out value="${product.image}"/>" class="img-responsive" alt=""/>
                    <h5><c:out value="${product.name}"/></h5>
                    <div class="grid_1">
                      <div class="special_item_price">
                        <span class="price-old"><fmt:setLocale value="en_US"/><fmt:formatNumber value="${product.price}" type="currency"/></span><span class="price-new"><fmt:setLocale value="en_US"/><fmt:formatNumber value="${product.discountedPrice}" type="currency"/></span>
                      </div>
                      <div class="special_item_add">
                        <ul>
                          <li>
                            <form method='post' action='mycart.jsp'>
                              <input type='hidden' name='id' value='<c:out value="${product.id}"/>'>
                              <input type='hidden' name='name' value='<c:out value="${product.name}"/>'>
                              <input type='hidden' name='type' value='<c:out value="${product.type}"/>'>
                              <input type='hidden' name='maker' value='<c:out value="${product.maker}"/>'>
                              <input type='hidden' name='access' value=''>
                              <input type='submit' class='formbutton' value='Add to Cart'>
                            </form>
                          </li>
                          <li><a class='button' href='review.jsp?productkey=<c:out value="${product.id}"/>'>Reviews</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <c:if test="${(counter + 1)%3 == 0 || counter == list.size()}">
                    </div>    
                </c:if>
                <c:set var="counter" value="${counter + 1}" scope="page"/>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <div class='clear'></div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
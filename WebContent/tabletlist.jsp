<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@page import="johnny.gamestore.mysql.dao.TabletDao"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.beans.Tablet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_TABLETS);
    String makerName = request.getParameter("maker");
    makerName = makerName == null ? "" : makerName;

    TabletDao dao = TabletDao.createInstance();
    List<Tablet> list = dao.getTabletList(makerName);
    pageContext.setAttribute("makerName", makerName);
    pageContext.setAttribute("list", list);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <h3>${makerName} Tablets</h3>
    <c:set var="counter" value="0" scope="page" />
    <c:forEach var="tablet" items="${list}">   
        <c:if test="${(counter + 1)%3 == 1}">
            <div class='special_grid_row'>     
        </c:if>
        <div class="special_grid_col">
          <div class="special_box">
            <img src="images/<c:out value="${tablet.image}"/>" class="img-responsive" alt=""/>
            <h5><c:out value="${tablet.name}"/></h5>
            <div class="grid_1">
              <div class="special_item_price">
                <span class="price-old"><fmt:setLocale value="en_US"/><fmt:formatNumber value="${tablet.price}" type="currency"/></span><span class="price-new"><fmt:setLocale value="en_US"/><fmt:formatNumber value="${tablet.discountedPrice}" type="currency"/></span>
              </div>
              <div class="special_item_add">
                <ul>
                  <li>
                    <form method='post' action='mycart.jsp'>
                      <input type='hidden' name='id' value='<c:out value="${tablet.key}"/>'>
                      <input type='hidden' name='name' value='<c:out value="${tablet.name}"/>'>
                      <input type='hidden' name='type' value='4'>
                      <input type='hidden' name='maker' value='<c:out value="${tablet.maker}"/>'>
                      <input type='hidden' name='access' value=''>
                      <input type='submit' class='formbutton' value='Add to Cart'>
                    </form>
                  </li>
                  <li><a class='button' href='review.jsp?productkey=<c:out value="${tablet.key}"/>'>Reviews</a></li>
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
    <div class='clear'>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
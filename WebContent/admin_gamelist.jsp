<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.dao.GameDao"%>
<%@page import="johnny.gamestore.mysql.beans.Game"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_GAMEMNG);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    
    String usertype = helper.usertype();
    String errmsg = "";
    if (usertype==null || !usertype.equals(Constants.CONST_TYPE_STOREMANAGER_LOWER)) {
        errmsg = "You have no authorization to manage game!";
    } else {    
        GameDao dao = GameDao.createInstance();
        List<Game> list = dao.getGameList();
        pageContext.setAttribute("list", list);
    }
    pageContext.setAttribute("errmsg", errmsg);
%>
<jsp:include page="layout_menu.jsp" />
<section id='content'>
    <div class='cart'>
        <h3>Game Management</h3>        
        <c:choose>
            <c:when test="${not empty errmsg}">
                <h3 style='color:red'>${errmsg}</h3>
            </c:when>
            <c:otherwise>
                <div style='padding:5px'><a href='admin_gameadd.jsp' class='button'>Create New Game</a></div>
                <c:set var="counter" value="0" scope="page" />
                <table cellspacing='0'>
                    <tr><th>No.</th><th>Maker</th><th>Game Name</th><th>Price</th><th>Management</th></tr>
                <c:forEach var="game" items="${list}">
                    <tr>
                        <td><c:out value="${counter + 1}"/></td><td><c:out value="${game.maker}"/></td><td><c:out value="${game.name}"/></td><td><fmt:setLocale value="en_US"/><fmt:formatNumber value="${game.price}" type="currency"/></td>
                        <td>
                            <span style='padding-right:3px;'><a href='admin_gameedit.jsp?gamekey=<c:out value="${game.key}"/>' class='button'>Edit</a></span>
                            <span><a href='admin_gamedel.jsp?gamekey=<c:out value="${game.key}"/>' class='button' onclick = "return confirm('Are you sure to delete this game?')">Delete</a></span>
                        </td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}" scope="page"/>
                </c:forEach>               
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_HOME);
%>
<jsp:include page="layout_menu.jsp" />
<img class="header-image" src="images/site/image.jpg" alt="Games" />
<section id="content">
  <div class="post">
    <h3 class="title">Welcome to GameSpeed</h3>
    <div class="entry">
      <img src="images/site/consoles.png"
              style="width: 600px; display: block; margin-left: auto; margin-right: auto" />
      <br>
      <h2>The world trusts us to deliver SPEEDY service for video-gaming fans</h2>
      <br>
      <h3>We beat our competitors in all aspects. Price-Match Gauranteed</h3>
    </div>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />

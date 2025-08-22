<%@ page import="javax.servlet.http.HttpSession" %>
<%
  HttpSession session1 = request.getSession(false);
  if (session1 != null) {
    session1.invalidate(); // destroy session
  }

  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

%>
<script type="text/javascript">
  history.pushState(null, null, location.href);
  window.addEventListener('popstate', function () {
    history.pushState(null, null, location.href);
  });
  window.onbeforeunload = function () {
    return "Are you sure you want to leave this page?";
  };


</script>


<%
  response.sendRedirect("login.jsp");
%>

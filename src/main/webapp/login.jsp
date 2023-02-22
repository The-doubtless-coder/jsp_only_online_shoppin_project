
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>Login</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
     <form action="loginAction.jsp" method="post">
         <input type="email" id="mail" name="u_email" placeholder="Enter Your Email Address" required>
         <input type="password" id="pass" name="u_password" placeholder="Enter Your Password" required>
         <input type="submit" value="Login">
     </form>
      <h2><a href="signup.jsp">SignUp</a></h2>
       <h2><a href="forgotPassword.jsp">Forgot Password?</a></h2>

  </div>
  <div class='whysignLogin'>
      <%
          if(request.getParameter("msg")!=null){
              String msg = request.getParameter("msg");
              if(msg.equals("empty_mail")){
      %>
  <h1>An empty email has been provided</h1>
<%
    }else if(msg.equals("empty_pass")){
%>
    <h1>An empty password has been passed</h1>
<%
    } else if (msg.equals("user_not_registered")) {
%>
      <h1>Please Register first!</h1>
      <%
              } else if (msg.equals("wrong_pass")) {
      %>
      <h1>Password does not match the one in our servers</h1>
      <%
              } else if (msg.equals("sql_error")) {
                  %>
      <h1>We have a sql error on our hands</h1>
      <%
              }
              request.removeAttribute("msg");
          }
      %>
    <h2>Online Shopping</h2>
    <p>The Online Shopping System is the application that allows the users to shop online without going to the shops to buy them.</p>
  </div>
</div>

</body>
</html>
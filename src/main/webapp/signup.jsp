<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>Signup</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
    <form action="signUpAction.jsp" method="post">
        <input type="text" name="name" id="user_name" placeholder="Enter Your Name" required autocomplete="on" autofocus>
        <input type="email" name="mail" id="user_mail" placeholder="Enter Your Email ID" required autocomplete="on">
        <input type="text" name="phone" id="user_telephone" placeholder="Enter Your Phone Number" required autocomplete="on">
        <select name="security_question" id="user_security_questions" required>
            <option value="hs_nickname">What was your high school nickname?</option>
            <option value="pet_name">what is the name of your pet?</option>
            <option value="fav_color" selected>what is your favourite color?</option>
            <option value="first_girlfriend_name">What was the name of your first girlfriend?</option>
            <option value="fav_meal">What is your favourite meal?</option>
        </select>
        <input type="text" name="security_question_answer" id="user_security_question_answer" placeholder="Enter Answer Here" required>
        <input type="password" name="password" id="user_password" placeholder="Enter Your Password" required>
        <input type="submit" value="Sign Up">
    </form>
      <h2><a href="login.jsp">Login</a></h2>
  </div>
  <div class='whysign'>
<%--//todo: configure specific responses depending on the exception that has been thrown--%>
<% if(request.getParameter("msg")!=null){
    String msg = request.getParameter("msg");
    if("success".equals(msg)){
%>
<h1>Successfully Updated</h1>
<%
    }else if(msg.equals("phone_val")) {
%>
<h1>Ensure phone starts with +254 then a 7</h1>
<%
    }else{
        %>
    <h1>Some thing Went Wrong! Try Again !</h1>
    <%
            }
        }
    %>
    <h2>Online Shopping</h2>
    <p>The Online Shopping System is the application that allows the users to shop online without going to the shops to buy them.</p>
  </div>
</div>

</body>
</html>
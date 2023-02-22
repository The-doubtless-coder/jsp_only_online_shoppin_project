<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>ForgotPassword</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
     <form action="forgotPasswordAction.jsp" method="post">
         <input type="email" id="mail" name="mail" placeholder="Enter Your EmailID" required>
         <input type="text" id="telefona" name="telefona" placeholder="Enter Your Mobile Number" required>
         <select name="security_question" id="user_security_questions" required>
             <option value="hs_nickname">What was your high school nickname?</option>
             <option value="pet_name">what is the name of your pet?</option>
             <option value="fav_color" selected>what is your favourite color?</option>
             <option value="first_girlfriend_name">What was the name of your first girlfriend?</option>
             <option value="fav_meal">What is your favourite meal?</option>
         </select>
         <input type="text" id="security_question_answer" name="user_security_question_answer" placeholder="Enter Your Answer" required>
         <input type="password" id="new_pass" name="new_pass" placeholder="Enter Your New Password" required>
         <input type="submit" value="Reset Password">
     </form>
      <h2><a href="login.jsp">Login</a></h2>
  </div>
  <div class='whyforgotPassword'>
      <%
          if(request.getParameter("msg")!=null){
              String msg = request.getParameter("msg");
              if(msg.equalsIgnoreCase("empty_value")){
      %>
<h1>Empty fields not allowed!</h1>
      <%
          } else if (msg.equalsIgnoreCase("no_match")) {
      %>
      <h1>Wrong email and phone combination</h1>
      <%
          }else if(msg.equalsIgnoreCase("both_no_match")){
      %>
      <h1>No match between provided question and answer</h1>
      <%
              } else if (msg.equalsIgnoreCase("question_no_match")) {
      %>
      <h1>Not the question answered during registration</h1>
      <%
              } else if (msg.equalsIgnoreCase("answer_no_match")) {
      %>
      <h1>wrong answer to question provided</h1>
      <%
          } else if (msg.equalsIgnoreCase("success")) {
      %>
      <h1>Password has been changed!</h1>
      <%
          } else if(msg.equalsIgnoreCase("phone_val")){
      %>
      <h1>Ensure phone starts with +254 then a 7</h1>
            <%
          }else if(msg.equalsIgnoreCase("genuine_pass")) {
                  %>
      <h1>Passwords needs Uppercases, lowercases, symbols and numbers: also be greater than 8 letters </h1>
      <%
          }else if(msg.equalsIgnoreCase("invalid_mail")){
      %>
      <h1>Enter a valid/genuine email</h1>
      <%
      } else{
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
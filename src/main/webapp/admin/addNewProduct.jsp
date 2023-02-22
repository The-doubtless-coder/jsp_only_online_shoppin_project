<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<%@include file="adminHeader.jsp" %>
<%@include file="../footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<title>Add New Product</title>
</head>
<body>
<%
 if(request.getParameter("msg")!=null){
  String msg = request.getParameter("msg");
  if(msg.equalsIgnoreCase("empty_val")){
%>
<h3 class="alert">Empty Values not Allowed</h3>
<%
 } else if (msg.equalsIgnoreCase("fail_save")) {
%>
<h3 class="alert">Product not saved, try again!</h3>
<%
 }else if(msg.equalsIgnoreCase("product_saved")){
%>
<h3 class="alert">Product Added Successfully!</h3>
<%
 } else if (msg.equalsIgnoreCase("sql_error")) {
%>
<h3 class="alert">Product not saved, try again! sql error!</h3>
<%
 }else {
%>
<h3 class="alert">Some thing went wrong! Try Again!</h3>
<%
 }}
%>

<%
 Connection conn = null;
 Statement st = null;
 ResultSet rs = null;
 String LARGEST_VAL_IN_PRODUCTS ="SELECT max(id) FROM products";
 PrintWriter pw = response.getWriter();
%>
<%
 int id = 1;
 try{
  conn = ConnectionProvider.getConnObject();
  if(conn!=null){
   st = conn.createStatement();
  }
  if(st!=null){
   rs = st.executeQuery(LARGEST_VAL_IN_PRODUCTS);
  }
  assert rs != null;
  if(rs.next()){
    id = rs.getInt(1);
    id = id + 1;
  }
 }catch (SQLException s){
  s.printStackTrace();
 }


%>
<form action="addNewProductAction.jsp" method="post">
<h3 style="color: yellow;">Product ID: <%=id%></h3>
 <input type="hidden" name="gen_prod_id" value="<%=id%>">

<div class="left-div">
 <h3>Enter Name</h3>
 <input class="input-style" type="text" name="product_name" required placeholder="Enter Product Name">
<hr>
</div>

<div class="right-div">
<h3>Enter Category</h3>
 <input class="input-style" type="text" name="product_category" required placeholder="Enter Product Category">
<hr>
</div>

<div class="left-div">
<h3>Enter Price</h3>
 <input class="input-style" type="number" min="1" step="any" name="product_price" required placeholder="Enter Product Price">
<hr>
</div>

<div class="right-div">
<h3>Active</h3>
 <select class="input-style" name="either_or">
  <option value="true">True</option>
  <option value="false">False</option>
 </select>
<hr>
</div>

 <button class="input-style" type="submit"><i class='far fa-arrow-alt-circle-right'></i></button>
</form>
</body>
//<%--<br><br><br>--%>
//<%--</body>--%>
</html>
<%@page import="java.util.ArrayList"%>
<%@page import="service.ItemServiceImpl"%>
<%@page import="service.itemService"%>
<%@page import="model.Item"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
itemService itemService = new ItemServiceImpl();
Item itemModel = new Item();
boolean update = false;
String stsMsg = "";

if(request.getParameter("updateId") != null) {
    update = true;
	itemModel = itemService.getItemById(Integer.parseInt(request.getParameter("updateId")));
}

if(request.getParameter("dltId") != null) {
    stsMsg = itemService.deleteItem(Integer.parseInt(request.getParameter("dltId")));
}

 //Update an Item
 if (request.getParameter("itemId") != null) {
	 stsMsg = itemService.updateItem(
			 Integer.parseInt(request.getParameter("itemId")),
			 request.getParameter("itemCode"),
			 request.getParameter("itemName"),
			 request.getParameter("itemPrice"),
			 request.getParameter("itemDesc"));
	 
 } else if (request.getParameter("itemCode") != null)
 {
	 //Insert an Item
 stsMsg = itemService.insertItem(request.getParameter("itemCode"),
 request.getParameter("itemName"),
 request.getParameter("itemPrice"),
 request.getParameter("itemDesc"));
 }
 
 session.setAttribute("statusMsg", stsMsg);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Items Management</h1>
<form method="post" action="index.jsp">
 <%if(!update){ %>
 Item code: <input name="itemCode" type="text" required><br> 
 Item name: <input name="itemName" type="text" required><br> 
 Item price: <input name="itemPrice" type="text" required><br> 
 Item description: <input name="itemDesc" type="text" required><br> 
 
 <input name="btnSubmit" type="submit" value="Save">
 <%} else { %>
 <input name="itemId" value="<%=itemModel.getItemID()%>"hidden>
 Item code: <input name="itemCode" type="text" value="<%=itemModel.getItemCode()%>" required><br> 
 Item name: <input name="itemName" type="text" value="<%=itemModel.getItemName()%>" required><br> 
 Item price: <input name="itemPrice" type="text" value="<%=itemModel.getItemPrice()%>" required><br> 
 Item description: <input name="itemDesc" type="text" value="<%=itemModel.getItemDesc()%>" required><br> 
 <input name="btnSubmit" type="submit" value="Update">
 <%} %>
</form>

<br>
<%
 out.print(session.getAttribute("statusMsg"));
%>
<br>

<% ArrayList<Item> items = itemService.getItems(); 
if(items.size() > 0) {%>
<table border="1">
<tr>
<td>Item Code</td>
<td>Item Name</td>
<td>Price</td>
<td>Description</td>
</tr>

<%
 for(Item item : items) {
%>
<tr>
<td><%=item.getItemCode() %></td>
<td><%=item.getItemName() %></td>
<td><%=item.getItemPrice() %></td>
<td><%=item.getItemDesc() %></td>
<td><form action="index.jsp"><input name="dltId" value="<%=item.getItemID()%>"hidden><input type="submit" value="Delete"></form></td>
<td><form action="index.jsp"><input name="updateId" value="<%=item.getItemID()%>"hidden><input type="submit" value="Update"></form></td>
</tr>
<%} %>
</table>
<%} %>
<br>

</body>
</html>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Data</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<header class="bg-success text-white text-center py-3 mb-4">
    <h1 class="text-center">Submitted Data</h1>
</header>
<div class="container">

    <!-- Search Form -->
    <form class="mt-3" method="get" action="viewData.jsp">
        <div class="form-group d-flex justify-content-center">
            <input type="text" name="searchQuery" class="form-control w-100 mr-2" placeholder="Search by Name or Email"
                   value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>


    <table class="table table-bordered mt-3">
        <thead class="bg-secondary text-white">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Email</th>
            <th colspan="2">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            Logger logger = Logger.getLogger("MyLogger");

            try {
                // Path to the xml file
                String xmlFilePath = application.getRealPath("/") + "data.xml";

                // Parse the xml file
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                Document doc = builder.parse(new java.io.File(xmlFilePath));

                // Normalize xml structure
                doc.getDocumentElement().normalize();

                // Get all <user> elements
                NodeList nodeList = doc.getElementsByTagName("user");

                // Search query
                String searchQuery = request.getParameter("searchQuery");
                searchQuery = searchQuery != null ? searchQuery.trim().toLowerCase() : "";

                // Loop through and display each user
                boolean dataFound = false;
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Element user = (Element) nodeList.item(i);

                    String id = user.getElementsByTagName("id").item(0).getTextContent();
                    String name = user.getElementsByTagName("name").item(0).getTextContent();
                    String age = user.getElementsByTagName("age").item(0).getTextContent();
                    String email = user.getElementsByTagName("email").item(0).getTextContent();

                    // Check if the record matches the search query
                    if (searchQuery.isEmpty() || name.toLowerCase().contains(searchQuery) || email.toLowerCase().contains(searchQuery)) {
                        dataFound = true;
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= age %></td>
            <td><%= email %></td>
            <td><a href="updateForm.jsp?id=<%= id %>" class="btn btn-warning btn-sm">Edit</a></td>
            <td><a href="delete-servlet?id=<%= id %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this entry?');">Delete</a></td>
        </tr>
        <%
                }
            }

            if (!dataFound) {
        %>
        <tr>
            <td colspan="6" class="text-center">No matching records found.</td>
        </tr>
        <%
                }
            } catch (Exception e) {
//                throw new RuntimeException(e);
                    logger.log(Level.SEVERE, "Error reading data", e);
                    out.println("<tr><td colspan='6'>An error occurred while reading data. Please try again.</td></tr>");
            }
        %>
        </tbody>
    </table>
    <a href="form.jsp" class="btn btn-primary btn-block">Submit New Data</a>
</div>
</body>
</html>
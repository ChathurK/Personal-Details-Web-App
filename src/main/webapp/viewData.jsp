<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %><%--
  Created by IntelliJ IDEA.
  User: kumar
  Date: 18-Nov-24
  Time: 12:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Data</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Submitted Data</h1>
    <table class="table table-bordered mt-4">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Email</th>
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

                // Loop through and display each user
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Element user = (Element) nodeList.item(i);

                    String id = user.getElementsByTagName("id").item(0).getTextContent();
                    String name = user.getElementsByTagName("name").item(0).getTextContent();
                    String age = user.getElementsByTagName("age").item(0).getTextContent();
                    String email = user.getElementsByTagName("email").item(0).getTextContent();
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= age %></td>
            <td><%= email %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
//                throw new RuntimeException(e);
                    logger.log(Level.SEVERE, "Error reading data", e);
                    out.println("<tr><td colspan='4'>An error occurred while reading data. Please try again.</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Element" %>

<%
    /*This he scriptlet retrieves the id parameter from the request and initializes variables for name, age, and email.
    It then attempts to parse an XML file to find the user data corresponding to the provided id.*/
    String id = request.getParameter("id");
    String xmlFilePath = application.getRealPath("/") + "data.xml";
    String name = "", age = "", email = "";

    try {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(new java.io.File(xmlFilePath));
        doc.getDocumentElement().normalize();
        NodeList nodeList = doc.getElementsByTagName("user");

        for (int i = 0; i < nodeList.getLength(); i++) {
            Element user = (Element) nodeList.item(i);
            String userId = user.getElementsByTagName("id").item(0).getTextContent();
            if (userId.equals(id)) {
                name = user.getElementsByTagName("name").item(0).getTextContent();
                age = user.getElementsByTagName("age").item(0).getTextContent();
                email = user.getElementsByTagName("email").item(0).getTextContent();
                break;
            }
        }
    } catch (Exception e) {
        out.println("Error loading data: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Data</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <header class="bg-success text-white text-center py-3 mb-4">
        <h1 class="text-center">Update Data</h1>
    </header>
<div class="container" style="max-width: 600px;">
    <%--The form fields are pre-filled with the values retrieved from the XML file, allowing update its information.--%>
    <form action="update-servlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required>
        </div>
        <div class="form-group">
            <label for="age">Age</label>
            <input type="number" id="age" name="age" class="form-control" value="<%= age %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" class="form-control" value="<%= email %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>
</body>
</html>


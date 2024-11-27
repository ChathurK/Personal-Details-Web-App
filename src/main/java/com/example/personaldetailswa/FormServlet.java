package com.example.personaldetailswa;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "formServlet", value = "/form-servlet")
public class FormServlet extends HttpServlet {
    private static final String XML_File = "data.xml"; //XML file name

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1: Collect form data
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String email = request.getParameter("email");

        // Step 2: Server side validation
        if (name.isEmpty() || !name.matches("[a-zA-Z\\s]+") || age.isEmpty() || !age.matches("\\d+") || Integer.parseInt(age) < 1 || Integer.parseInt(age) > 120 || email.isEmpty()) {
            response.getWriter().println("Invalid data. Please try again.");    // IOException -> getWriter()
            return;
        }

        // Step 3: Write the data to XML
        try {
            File file = new File(getServletContext().getRealPath("/") + XML_File);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();  // ParserConfigurationException -> newDocumentBuilder()
            Document doc;

            // Check if the file exists
            if (file.exists()) {
                // Parse existing XML
                doc = dBuilder.parse(file); // SAXException -> parse()
                doc.getDocumentElement().normalize();
            } else {
                // Create new XML
                doc = dBuilder.newDocument();
                Element rootElement = doc.createElement("users");
                doc.appendChild(rootElement);
            }
            
            // Add new user entry
            Element root = doc.getDocumentElement();

            // Create new user element
            Element newUser = doc.createElement("user");

            // Create and append id element using current timestamp
            Element userId = doc.createElement("id");
            userId.appendChild(doc.createTextNode(String.valueOf(System.currentTimeMillis())));
            newUser.appendChild(userId);

            // Create and append name element
            Element newName = doc.createElement("name");
            newName.appendChild(doc.createTextNode(name));
            newUser.appendChild(newName);

            // Create and append age element
            Element newAge = doc.createElement("age");
            newAge.appendChild(doc.createTextNode(age));
            newUser.appendChild(newAge);

            // Create and append email element
            Element newEmail = doc.createElement("email");
            newEmail.appendChild(doc.createTextNode(email));
            newUser.appendChild(newEmail);

            // Append the new user to the root element
            root.appendChild(newUser);

            // Write the content into XML file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(file);
            transformer.transform(source, result);

            // Send success response
            response.getWriter().println("Data successfully saved.");
            response.sendRedirect("success.jsp");
        } catch (ParserConfigurationException | SAXException | TransformerException e) {
//            throw new RuntimeException(e);
            throw new ServletException("Error while processing XML", e);
        }
    }

}

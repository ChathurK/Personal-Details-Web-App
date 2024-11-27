package com.example.personaldetailswa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;

@WebServlet (name = "deleteServlet", value = ("/delete-servlet"))
public class DeleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieves the id of the record to be deleted.
        String id = request.getParameter("id");

        // Path to the XML file
        String xmlFilePath = getServletContext().getRealPath("/") + "data.xml";

        try {
            // Parse the XML file and normalize the structure to ensure consistent structure
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new File(xmlFilePath));
            doc.getDocumentElement().normalize();

            // Get all <user> elements
            NodeList nodeList = doc.getElementsByTagName("user");

            /*Loops through each <user> element, checking if the id matches the provided id.
            If a match is found, the corresponding user element is removed from the document.*/
            for (int i = 0; i < nodeList.getLength(); i++) {
                Element user = (Element) nodeList.item(i);
                String userId = user.getElementsByTagName("id").item(0).getTextContent();
                if (userId.equals(id)) {
                    user.getParentNode().removeChild(user);
                    break;
                }
            }

            // The updated XML document is saved back to the file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(xmlFilePath));
            transformer.transform(source, result);

            // Redirect to viewData.jsp to display the updated data
            response.sendRedirect("viewData.jsp");
        } catch (Exception e) {
            response.getWriter().println("Error deleting data: " + e.getMessage());
        }
    }
}


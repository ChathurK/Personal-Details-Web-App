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

@WebServlet (name = "UpdateServlet", value = ("/update-servlet"))
public class UpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String email = request.getParameter("email");

        String xmlFilePath = getServletContext().getRealPath("/") + "data.xml";

        try {
            // Parse the XML file
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new File(xmlFilePath));
            doc.getDocumentElement().normalize();

            // Find the record to update
            NodeList nodeList = doc.getElementsByTagName("user");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Element user = (Element) nodeList.item(i);
                String userId = user.getElementsByTagName("id").item(0).getTextContent();
                if (userId.equals(id)) {
                    user.getElementsByTagName("name").item(0).setTextContent(name);
                    user.getElementsByTagName("age").item(0).setTextContent(age);
                    user.getElementsByTagName("email").item(0).setTextContent(email);
                    break;
                }
            }

            // Save changes back to XML file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(xmlFilePath));
            transformer.transform(source, result);

            response.sendRedirect("viewData.jsp");
        } catch (Exception e) {
            response.getWriter().println("Error updating data: " + e.getMessage());
        }
    }
}

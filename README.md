# Web Application for Data Management with JSP, Servlets, and XML

---

## Objective  
The purpose of this project is to create a web application that demonstrates the usage of JSP, Servlets, XML processing, and file handling. The application provides a comprehensive solution for managing personal details by storing them in XML files and allowing users to view, update, delete, and search through the data.

---

## Features and Functionality  
1. **Form Submission**  
   - Users can input data (Name, Age, and Email) using an interactive form built with JSP.  
   - Server-side validation ensures input integrity.  

2. **Data Storage**  
   - Each form submission is stored in an XML file.  
   - Unique identifiers (timestamps) are assigned to each record.  

3. **Data Management**  
   - Users can view all stored data in a tabular format.  
   - Integrated search functionality allows filtering by name or email.  
   - Users can update existing records via a pre-filled form.  
   - Records can be deleted with confirmation prompts.  

4. **User Interface**  
   - Designed using Bootstrap for a responsive and user-friendly interface.  

---

## Technologies Used  
- **Backend**: Java Servlets  
- **Frontend**: JSP, HTML, CSS (Bootstrap)  
- **Data Storage**: XML processing with DOM (Document Object Model)  
- **Web Server**: Apache Tomcat  

---

## Key Files  

### **JSP Files**  
- `index.jsp`: Landing page with a welcome message and navigation options.  
- `form.jsp`: Data collection form with fields for Name, Age, and Email.  
- `viewData.jsp`: Displays all records in a table format, includes search functionality.  
- `success.jsp`: Confirmation page displayed after successful form submission.  
- `updateForm.jsp`: Form for updating existing records, pre-filled with current data.

### **Servlet Files**  
- **FormServlet** (`form-servlet`):  
  Handles form submission, validates inputs, and writes data to the XML file.  

- **UpdateServlet** (`update-servlet`):  
  Updates specific entries in the XML file based on a unique ID.  

- **DeleteServlet** (`delete-servlet`):  
  Deletes specific entries from the XML file based on a unique ID.  

### **XML File**  
- `data.xml`: Stores user data in a structured format.  

### **Configuration File**  
- `web.xml`: Maps servlets to specific URL patterns.  

---

## Setup and Deployment  

### **Prerequisites**  
- Java Development Kit (JDK) installed.  
- Apache Tomcat installed and configured in IntelliJ IDEA.  

### **Steps to Run the Application**  
1. Import the project into IntelliJ IDEA.  
2. Configure the Tomcat server in the project settings.  
3. Deploy the application on the Tomcat server.  
4. Access the application in a web browser at `http://localhost:8080/{application_name}`.  

### **Directory Structure**  
```plaintext
WebContent/
├── WEB-INF/
│   ├── web.xml
├── index.jsp
├── form.jsp
├── viewData.jsp
├── success.jsp
├── updateForm.jsp
├── styles.css
└── data.xml
src/
├── com.example.personaldetailswa/
│   ├── FormServlet.java
│   ├── UpdateServlet.java
│   └── DeleteServlet.java

P.S.: Using seperate servlet is not a good practice. Use a single servlet ('personaldetails.java' or something) and define CRUD methods.
      Use doPut and doDelete methods in addition to doPost and doGet.

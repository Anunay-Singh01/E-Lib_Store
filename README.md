# E-Lib_Store
A web application that allows users to buy and sell books online. It is built upon Java servlets, JSP, HTML and SQL. Users can create accounts, manage their listings, browse available books, and perform book operations through an intuitive interface. 

# User Features
- User Registration and Login
- Secure Authentication
- View Available Books
- Buy Books
- Rent Books
- View Profile
- Update Profile Information

# Seller Features
- Add New Books
- Update Book Details
- Delete Book Listings
- Upload Book Images
- Manage Listed Books

# Admin Features
- Manage Users
- Manage Books
- View Platform Data

# Tech Stack Used
- Java 8
- JSP
- Servlets
- JDBC
- MySQL
- Apache Tomcat 8.0.27
- HTML
- CSS
- JavaScript
- NetBeans IDE 8.2


# PROJECT STRUCTURE
E-lib Store
├───src
│   ├───conf
│   │       MANIFEST.MF
│   │
│   └───java
│       ├───controller
│       │       AddBook.java
│       │       AddToCart.java
│       │       BookCoverDisplay.java
│       │       BookDescription.java
│       │       BookDetails.java
│       │       DeleteFromCart.java
│       │       DeleteProfile.java
│       │       DeleteSellerBooks.java
│       │       EditBookServlet.java
│       │       LoginChecker.java
│       │       RegistrationChecker.java
│       │       SearchBook.java
│       │       UpdateProfile.java
│       │       UpdateSellerBooks.java
│       │       UserHome.java
│       │       ViewCart.java
│       │
│       ├───db
│       │       DBConnector.java
│       │
│       ├───dto
│       │       BookDTO.java
│       │       UserDTO.java
│       │
│       └───model
│               BookDetailsDAO.java
│               BookDisplayDAO.java
│               CartDAO.java
│               LoginAuthenticator.java
│               RegistrationAuthenticator.java
│               UpdateDeleteProfileDAO.java
│
├───test
└───web
    │   adminPanel.jsp
    │   bookdesc.jsp
    │   index.html
    │   login.html
    │   loginFail.html
    │   logout.jsp
    │   registration.html
    │   reg_success.html
    │   sellerDashboard.jsp
    │   updateBook.jsp
    │   userHomePage.jsp
    │   viewcart.jsp
    │   welcomePage.jsp
    │
    ├───META-INF
    │       context.xml
    │
    └───WEB-INF
            web.xml

  ## Database Setup

1. Install MySQL.
2. Create a new database:
CREATE DATABASE e-libstore;

3. Import the SQL file:
e-libstore.sql;

4. Update database credentials as in your username and password in DBConnector.java
   
# How to Run

1. Clone the repository:
git clone https://github.com/Anunay-Singh01/E-Lib_Store

2. Open the project in NetBeans 8.2 (Developed and tested using only JDK 1.8)

3. Add the MySQL JDBC Driver JAR to project libraries.

4. Configure Apache Tomcat Server.

5. Build and Run the project.

6. Open in browser:
http://localhost:8080/E-lib_Store

# Author
Anunay Singh




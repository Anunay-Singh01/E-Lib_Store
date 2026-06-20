/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.BookDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.BookDetailsDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "AddBook", urlPatterns = {"/AddBook"})
@MultipartConfig
public class AddBook extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
            String booktitle = request.getParameter("booktitle");
            String bookauthor = request.getParameter("bookauthor");
            String bookprice = request.getParameter("bookprice");
            String bookcondition = request.getParameter("bookcondition");
            
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO)session.getAttribute("user");
            if(user==null)
            {
                response.sendRedirect("login.jsp");
            }
            int userid = user.getUserid();
            
            Part image = request.getPart("bookcover");
            InputStream is = image.getInputStream();
            
            BookDTO book = new BookDTO();
            book.setBookauthor(bookauthor);
            book.setBooktitle(booktitle);
            book.setBookprice(Double.valueOf(bookprice));
            book.setBookcondition(bookcondition);
            book.setUserid(userid);
            Boolean bool = BookDetailsDAO.addBook(book,is);
            
            if(bool)
            {
                response.sendRedirect("AddBook");
            }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO)session.getAttribute("user");
            if(user==null)
            {
               response.sendRedirect("login.jsp");
            }
            int userid = user.getUserid();
            List<BookDTO> books = BookDetailsDAO.getSellerListedBooks(userid);
            request.setAttribute("books", books);
            RequestDispatcher rd = request.getRequestDispatcher("sellerDashboard.jsp");
            rd.forward(request, response);
    }

    
}

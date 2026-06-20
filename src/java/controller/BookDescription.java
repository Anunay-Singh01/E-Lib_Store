/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.BookDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BookDetailsDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "BookDescription", urlPatterns = {"/BookDescription"})
public class BookDescription extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        int bookid = Integer.parseInt(request.getParameter("bookid"));
        
        BookDTO book = BookDetailsDAO.getBookDetails(bookid);
        request.setAttribute("book", book);
        RequestDispatcher rd = request.getRequestDispatcher("bookdesc.jsp");
        rd.forward(request, response);
    }

    
    
}

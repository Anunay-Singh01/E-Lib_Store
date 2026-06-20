/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.BookDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "SearchBook", urlPatterns = {"/SearchBook"})
public class SearchBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        if(keyword==null||keyword.trim().isEmpty())
        {
            response.sendRedirect("userHomepage.jsp");
            return;
        }
        List<BookDTO> books = BookDetailsDAO.SearchBooks(keyword);
        request.setAttribute("books", books);
        RequestDispatcher rd = request.getRequestDispatcher("userHomePage.jsp");
        rd.forward(request, response);
    }

}

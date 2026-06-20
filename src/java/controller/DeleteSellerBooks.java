/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookDetailsDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "DeleteSellerBooks", urlPatterns = {"/DeleteSellerBooks"})
public class DeleteSellerBooks extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");
        int userid = user.getUserid();
        
        int bookid = Integer.parseInt(request.getParameter("bookid"));
        boolean bool = BookDetailsDAO.deleteSellerBook(userid, bookid);
        if(bool)
        {
       response.sendRedirect("AddBook");
        }
        else 
        {
            response.sendRedirect("login.html");
        }
    }
}

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
import model.CartDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");
        if(user==null)
        {
            response.sendRedirect("login.html"); //sends the user to login page if they are not logged in 
            return;
        }
        int userid = user.getUserid();
         
       int bookid = Integer.parseInt(request.getParameter("bookid"));
       boolean status = CartDAO.addToCart(userid, bookid);
         if(status)
         {
             response.sendRedirect("BookDescription?bookid="+bookid+"&msg=added"); //we redirect servlet to reactivate the request, otherwise directly redirecting to jsp will lead to not having any data in the request object since the previous request has already been fulfilled and this may break the page
         }
         else 
         {
             response.sendRedirect("BookDescription?bookid="+bookid+"&msg=exists");
         }
    }

   
}

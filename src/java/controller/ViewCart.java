/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.BookDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "ViewCart", urlPatterns = {"/ViewCart"})
public class ViewCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");
        if(user==null)
        {
            response.sendRedirect("login.html");
            return;
        }
        int userid = user.getUserid();
        List<BookDTO> books = CartDAO.getCartBooks(userid);
        request.setAttribute("books", books);
        RequestDispatcher rd = request.getRequestDispatcher("viewcart.jsp");
        rd.forward(request, response);
    }

}

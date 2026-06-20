/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BookDisplayDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "BookCoverDisplay", urlPatterns = {"/BookCoverDisplay"})
public class BookCoverDisplay extends HttpServlet 
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        int bookid = Integer.parseInt(request.getParameter("bookid"));
        System.out.println(bookid);
       byte[] imageBytes = BookDisplayDAO.getBookImage(bookid);
       response.setContentType("image/jpeg");
       OutputStream os = response.getOutputStream();
       os.write(imageBytes);
       os.close();
       
    }

  
    
}

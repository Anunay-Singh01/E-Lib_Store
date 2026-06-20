/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.BookDTO;
import dto.UserDTO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
@WebServlet(name = "UpdateSellerBooks", urlPatterns = {"/UpdateSellerBooks"})
@MultipartConfig
public class UpdateSellerBooks extends HttpServlet {

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        BookDTO book = new BookDTO();
        int bookid = Integer.parseInt(request.getParameter("bookid"));

        book.setBookid(bookid);
        book.setBooktitle(request.getParameter("booktitle"));
        book.setBookauthor(request.getParameter("bookauthor"));
        book.setBookprice(Double.parseDouble(request.getParameter("bookprice")));
        book.setBookcondition(request.getParameter("bookcondition"));

        Part imagePart = request.getPart("bookcover");

        if (imagePart != null && imagePart.getSize() > 0) {

            InputStream is = imagePart.getInputStream();

            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            byte[] data = new byte[1024];
            int nRead;

            while ((nRead = is.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }

            book.setBookcover(buffer.toByteArray());
        }

        boolean bool = BookDetailsDAO.updateSellerBook(book);
        if(bool)
        {
       response.sendRedirect("AddBook");
        }
        else 
        {
            response.sendRedirect("EditBookServlet");
        }
}
}

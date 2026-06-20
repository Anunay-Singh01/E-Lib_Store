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
import model.UpdateDeleteProfileDAO;

/**
 *
 * @author Anunay
 */
@WebServlet(name = "DeleteProfile", urlPatterns = {"/DeleteProfile"})
public class DeleteProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String current_password = request.getParameter("current_password");
       
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO)session.getAttribute("user");
        
       if(current_password!=null&&current_password.equals(user.getUserpassword()))
       {
          
          boolean delete = UpdateDeleteProfileDAO.deleteProfile(user);
          if(delete)
          {  
              session.invalidate();
              response.sendRedirect("BookDetails");
          }
       }
       else 
       {
           response.sendRedirect("adminPanel.jsp");
       }
    }

    
}

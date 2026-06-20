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
@WebServlet(name = "UpdateProfile", urlPatterns = {"/UpdateProfile"})
public class UpdateProfile extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
          HttpSession session = request.getSession();
          UserDTO user = (UserDTO)session.getAttribute("user");
          
        String current_password = request.getParameter("current_password");
        
           if (current_password != null && current_password.equals(user.getUserpassword())) 
           {
            String username = request.getParameter("username");

             if (username != null && !username.trim().isEmpty()) 
             {
             user.setUsername(username.trim());
             }
             String userpassword = request.getParameter("userpassword");

             if(userpassword != null && !userpassword.trim().isEmpty()) 
              {
              user.setUserpassword(userpassword);
              }
             String usermail = request.getParameter("usermail");

              if (usermail!= null && !usermail.trim().isEmpty()) 
              {
                user.setUsermail(usermail);
              }
             String usercontact = request.getParameter("usercontact");

             if (usercontact != null && !usercontact.trim().isEmpty()) 
             {
              user.setUsercontact(usercontact.trim());
             }
            
               UpdateDeleteProfileDAO.updateProfile(user);
        
            response.sendRedirect("adminPanel.jsp");
           } 
        else 
        {
           response.sendRedirect("adminPanel.jsp");
        }

        
   }

    
}

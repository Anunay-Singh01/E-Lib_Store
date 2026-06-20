/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.RegistrationAuthenticator;

/**
 *
 * @author Anunay
 */
@WebServlet("/RegistrationChecker")
public class RegistrationChecker extends HttpServlet
{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        response.sendRedirect("registration.html");
    }

    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String username = request.getParameter("username");
        String userpassword = request.getParameter("userpassword");
        String usermail = request.getParameter("usermail");
        String usercontact = request.getParameter("usercontact");
        
        if(username==null||username.isEmpty()||userpassword==null||userpassword.isEmpty()||usermail==null||usermail.isEmpty()||usercontact==null||usercontact.isEmpty())
        {
          response.sendRedirect("registration.html");
          return;
        }
        if(!usermail.matches("^[A-Za-z0-9+_.-]+@(.+)$"))
        {
        request.setAttribute("msg", "Invalid Email");
        request.getRequestDispatcher("registration.html").forward(request,response);
        return;
        }
        if(!usercontact.matches("\\d{10}"))
        {
        request.setAttribute("msg", "Invalid Phone Number");
        request.getRequestDispatcher("register.jsp").forward(request,response);
        return;
        }
        UserDTO user = new UserDTO();
        user.setUsername(username);
        user.setUserpassword(userpassword);
        user.setUsermail(usermail);
        user.setUsercontact(usercontact);
        
       RegistrationAuthenticator r1=new RegistrationAuthenticator();
       boolean register = r1.isRegistration(user);
       if(register)
        {
           response.sendRedirect("reg_success.html");
        }
        
                
    }
    
 
}

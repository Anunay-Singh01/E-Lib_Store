/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import db.DBConnector;
import dto.UserDTO;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Anunay
 */
public class RegistrationAuthenticator 
{
    public boolean isRegistration(UserDTO user)
    {
        String username= user.getUsername();
        String userpassword = user.getUserpassword();
        String usermail = user.getUsermail();
        String usercontact = user.getUsercontact();
        
        try
        {
        String query = "INSERT INTO users(username,userpassword,usermail,usercontact) VALUES (?,?,?,?)";
        PreparedStatement pst=DBConnector.getConnection().prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, userpassword);
            pst.setString(3, usermail);
            pst.setString(4, usercontact);
            
            int i=pst.executeUpdate();       
           
        }
         catch(SQLException e)
            {
                System.out.println(e);
            }
        
         return true; 
    }
    
}

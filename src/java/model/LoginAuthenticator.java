/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import db.DBConnector;
import dto.UserDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Anunay
 */
public class LoginAuthenticator {
    
    public boolean isLogin(UserDTO user)
    {
        String username = user.getUsername();
        String password = user.getUserpassword();
        String tablePassword="";
        try
        {
            
            String query="SELECT userid,userpassword,usermail,usercontact from users WHERE username=?";
            PreparedStatement pst=DBConnector.getConnection().prepareStatement(query);
            pst.setString(1,username);
            
            System.out.println(query);
            ResultSet rs=pst.executeQuery();
            if(rs.next())
            {
             tablePassword=rs.getString(2);
             
              if(username!=null&& password!=null && !username.trim().equals("")&& password.equals(tablePassword))
               {
                  user.setUserid(rs.getInt(1));
                  user.setUsermail(rs.getString(3));
                  user.setUsercontact(rs.getString(4));
                  return true;
               }
            
            } 
         
        }
       catch(SQLException e)
        {
            System.out.println(e);
        }
       
       return false;
    }
}

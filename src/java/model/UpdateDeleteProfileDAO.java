
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
public class UpdateDeleteProfileDAO {
    
    public static boolean updateProfile(UserDTO user)
    {
        String username= user.getUsername();
        String userpassword = user.getUserpassword();
        String usermail = user.getUsermail();
        String usercontact = user.getUsercontact();
        int userid = user.getUserid();
       
        try
        {
        String query = "UPDATE users SET username=?, userpassword=?, usermail=?, usercontact=? WHERE userid=?";
        PreparedStatement pst = DBConnector.getConnection().prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, userpassword);
            pst.setString(3, usermail);
            pst.setString(4, usercontact);
            pst.setInt(5,userid);               
            return pst.executeUpdate()>0;
          
        }
         catch(SQLException e)
            {
                System.out.println(e);
            }
        return false;
         }
           
    public static boolean deleteProfile(UserDTO user)
    {
        int userid = user.getUserid();
        try
        {
        String query = "DELETE FROM users WHERE userid=?";
        PreparedStatement pst = DBConnector.getConnection().prepareStatement(query);
        pst.setInt(1, userid);
                     
        return pst.executeUpdate()>0;
          
        }
         catch(SQLException e)
            {
                System.out.println(e);
            }
        return false;
         }
    }

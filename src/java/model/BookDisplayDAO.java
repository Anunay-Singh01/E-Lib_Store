/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import db.DBConnector;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Anunay
 */
public class BookDisplayDAO {
    public static byte[] getBookImage(int bookid)
    {
        byte[] imageBytes=null;
        try
        {
           String query = "SELECT bookcover FROM books WHERE bookid = ?";
           PreparedStatement pst = DBConnector.getConnection().prepareStatement(query);
           pst.setInt(1, bookid);
           ResultSet rs =pst.executeQuery();
            if(rs.next())
            {
              Blob blob = rs.getBlob("bookcover");
              imageBytes = blob.getBytes(1, (int)blob.length());
            }
        }
        catch(SQLException e)
        {
               System.out.println(e);     
        }
        return imageBytes;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import db.DBConnector;
import dto.BookDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Anunay
 */
public class CartDAO {
    
    public static boolean addToCart(int userid, int bookid)
    {
        try 
        {
            Connection con = DBConnector.getConnection();
            String query = "INSERT INTO cart(userid,bookid)VALUES(?,?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, userid);
            pst.setInt(2,bookid);
            
            return pst.executeUpdate()>0; //if record is inserted successfully, then 1>0 will yield true
        }
        catch(SQLException e)
        {
            System.out.println(e);
           
        }
        return false;
    }
    public static List<BookDTO> getCartBooks(int userid)
    {
        List<BookDTO> books = new ArrayList<>();
        try
        {
           Connection con = DBConnector.getConnection();
           String query = "SELECT books.* FROM books JOIN cart ON books.bookid=cart.bookid WHERE cart.userid=?";
           PreparedStatement pst = con.prepareStatement(query);
           pst.setInt(1,userid);
           ResultSet rs = pst.executeQuery();
            
           while(rs.next())
           {
               BookDTO book = new BookDTO();
               book.setBookid(rs.getInt("bookid"));
               book.setBooktitle(rs.getString("booktitle"));
               book.setBookauthor(rs.getString("bookauthor"));
               book.setBookprice(rs.getDouble("bookprice"));
               book.setBookcondition(rs.getString("bookcondition"));
               books.add(book);
           }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return books;
    }
    
    public static boolean deleteFromCart(int userid, int bookid)
    {
        try 
        {
          Connection con = DBConnector.getConnection();
          String query = "DELETE FROM cart WHERE userid = ? and bookid = ?";
          PreparedStatement pst = con.prepareStatement(query);
          pst.setInt(1, userid);
          pst.setInt(2, bookid);
         return pst.executeUpdate()>0;
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
                
        return false;
    }
}

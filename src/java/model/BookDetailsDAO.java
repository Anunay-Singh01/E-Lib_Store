/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import db.DBConnector;
import dto.BookDTO;
import java.io.InputStream;
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
public class BookDetailsDAO {
    
    public static List<BookDTO> getAllBookDetails()
    {
      List<BookDTO> books = new ArrayList<>();
        try
        {
            
            String query="SELECT bookid,booktitle,bookauthor,bookprice from books";
            PreparedStatement pst=DBConnector.getConnection().prepareStatement(query);
            
            System.out.println(query);
            ResultSet rs=pst.executeQuery();
            while(rs.next())
            {
             BookDTO book = new BookDTO();
             book.setBookid(rs.getInt("bookid"));
             book.setBooktitle(rs.getString("booktitle"));
             book.setBookauthor(rs.getString("bookauthor"));
             book.setBookprice(rs.getDouble("bookprice"));
             books.add(book);
            }
            
         } 
        
       catch(SQLException e)
        {
            System.out.println(e);
        }
        
        return books;
    }

    public static BookDTO getBookDetails(int bookid)
    {
        BookDTO book = new BookDTO();
        try
        {
            
            String query="SELECT bookid,booktitle,bookauthor,bookprice,bookcondition from books WHERE bookid = ?";
            PreparedStatement pst=DBConnector.getConnection().prepareStatement(query);
            pst.setInt(1, bookid);
            
            System.out.println(query);
            ResultSet rs=pst.executeQuery();
            if(rs.next())
            {
             book.setBookid(rs.getInt("bookid"));
             book.setBooktitle(rs.getString("booktitle"));
             book.setBookauthor(rs.getString("bookauthor"));
             book.setBookprice(rs.getDouble("bookprice"));
             book.setBookcondition(rs.getString("bookcondition"));
            
            }
            
         } 
        
       catch(SQLException e)
        {
            System.out.println(e);
        }
        
        return book;
    }
    
   public static List<BookDTO> SearchBooks(String keyword)
   {
       List<BookDTO> books = new ArrayList<>();
       
       try 
       {
           Connection con = DBConnector.getConnection();
           String query = "SELECT * FROM books WHERE booktitle LIKE ? OR bookauthor LIKE ?";
           PreparedStatement pst = con.prepareStatement(query);
           pst.setString(1,"%"+keyword+"%");
           pst.setString(2,"%"+keyword+"%");
           
           System.out.println(query);
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
   
   public static List<BookDTO> getSellerListedBooks(int userid)
   {
       List<BookDTO> books = new ArrayList<>();
       try
       {
           String query = "SELECT * FROM books WHERE userid = ?";
           PreparedStatement pst = DBConnector.getConnection().prepareStatement(query);
           pst.setInt(1, userid);
           System.out.println(query);
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
       
       return books ;
   }
   
   public static boolean addBook(BookDTO book, InputStream is)
   {
      
       try 
        {
            Connection con = DBConnector.getConnection();
            String query = "INSERT INTO books(booktitle,bookauthor,bookprice,bookcondition,bookcover,userid)VALUES(?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1,book.getBooktitle());
            pst.setString(2,book.getBookauthor());
            pst.setDouble(3,book.getBookprice());
            pst.setString(4,book.getBookcondition());
            pst.setBinaryStream(5,is);
            pst.setInt(6,book.getUserid());
            
            
            return pst.executeUpdate()>0; //if record is inserted successfully, then 1>0 will yield true
        }
        catch(SQLException e)
        {
            System.out.println(e);
           
        }
        return false;
       
   }
   
   public static boolean deleteSellerBook(int userid,int bookid)
   {
       try 
        {
          Connection con = DBConnector.getConnection();
          String query = "DELETE FROM books WHERE userid = ? and bookid = ?";
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
   
   public static boolean updateSellerBook(BookDTO book)
   {
       try 
        {
          PreparedStatement pst;
          if(book.getBookcover()!=null)
          {
            Connection con = DBConnector.getConnection();
            String query = "UPDATE books SET booktitle = ? , bookauthor = ? , bookprice = ? , bookcondition = ? , bookcover= ? WHERE bookid = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, book.getBooktitle());
            pst.setString(2, book.getBookauthor());
            pst.setDouble(3, book.getBookprice());
            pst.setString(4, book.getBookcondition());
            pst.setBytes(5, book.getBookcover());
            pst.setInt(6, book.getBookid());
          }
          else 
          {
            Connection con = DBConnector.getConnection();
            String query = "UPDATE books SET booktitle = ? , bookauthor = ? , bookprice = ? , bookcondition = ? WHERE bookid = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, book.getBooktitle());
            pst.setString(2, book.getBookauthor());
            pst.setDouble(3, book.getBookprice());
            pst.setString(4, book.getBookcondition());
            pst.setInt(5, book.getBookid());
          }
          return pst.executeUpdate()>0;
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
                
        return false;
   }
}

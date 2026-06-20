/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author Anunay
 */
public class BookDTO 
{
    private String booktitle,bookauthor,bookcondition;
    private int bookid,userid;
    private double bookprice;
    private byte[] bookcover;

    public String getBooktitle() {
        return booktitle;
    }

    public void setBooktitle(String booktitle) {
        this.booktitle = booktitle;
    }

    public String getBookauthor() {
        return bookauthor;
    }

    public void setBookauthor(String bookauthor) {
        this.bookauthor = bookauthor;
    }

    public String getBookcondition() {
        return bookcondition;
    }

    public void setBookcondition(String bookcondition) {
        this.bookcondition = bookcondition;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public double getBookprice() {
        return bookprice;
    }

    public void setBookprice(double bookprice) {
        this.bookprice = bookprice;
    }

    public byte[] getBookcover() {
        return bookcover;
    }

    public void setBookcover(byte[] bookcover) {
        this.bookcover = bookcover;
    }

    
}
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import dbconnection.DBConnection;
import java.sql.*;

/**
 *
 * @author Ishan
 */
public class TestDBConnection {
    public static void main(String[] args) {
        DBConnection dbconnect = DBConnection.getInstance();
        Connection con = dbconnect.getCon();
        
        if (con != null) {
            System.out.println("successfully connected");
        }
        else {
            System.out.println("something wrong");
        }
    }
}

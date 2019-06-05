/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbconnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class DBConnection {
    private static DBConnection dbconnection;
    private Connection con = null;
    
    private DBConnection() {
        try {
            setConnection();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static DBConnection getInstance() {
        if (dbconnection == null) {
            synchronized(DBConnection.class) {
                if (dbconnection == null) {
                    dbconnection = new DBConnection();
                }
            }
        }
        return dbconnection;
    }
    
    public void setConnection() throws ClassNotFoundException, SQLException {
        String url = "jdbc:mysql://localhost:3306/school_management";
        String user = "root";
        String pass = "";
        
        Class.forName("com.mysql.jdbc.Driver");
        
        con = DriverManager.getConnection(url, user, pass);
        
    }
    
    public Connection getCon() {
        return con;
    }
}

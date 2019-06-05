/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;
import java.sql.*;
import dbconnection.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import student.*;
import teacher.*;
import subjects.*;

/**
 *
 * @author DELL
 */
public class Admin {
    private String username;
    private String password;

    public Admin(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    public boolean validLogin() {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM admin WHERE username = '" +this.username+ "' AND password = '" +this.password+ "'";
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) 
                return true;
            else
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
}

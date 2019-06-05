/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import teacher.*;

/**
 *
 * @author DELL
 */
@WebServlet(name = "TeacherRegistrationServelet", urlPatterns = {"/TeacherRegistrationServelet"})
public class TeacherRegistrationServelet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TeacherRegistrationServelet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TeacherRegistrationServelet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            int age = Integer.parseInt(request.getParameter("age"));
            int years_of_experience = Integer.parseInt(request.getParameter("YOE"));
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            out.println(fname);
            out.println(lname);
            out.println(age);
            out.println(years_of_experience);
            out.println(gender);
            out.println(address);
            out.println(email);
            out.println(username);
            out.println(password);
            
            Teacher teacher = new Teacher(fname,lname,address,gender,age,years_of_experience,email,username,password);
            
            if (teacher.registerTeacher()) {
                response.sendRedirect(request.getContextPath() + "/Admin/teacher.jsp");
            }
            else {
                out.println("Teacher not registered");
            }
            
            
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

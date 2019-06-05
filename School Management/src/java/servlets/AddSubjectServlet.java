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
import subjects.*;

/**
 *
 * @author DELL
 */
@WebServlet(name = "AddSubjectServlet", urlPatterns = {"/AddSubjectServlet"})
public class AddSubjectServlet extends HttpServlet {

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
            out.println("<title>Servlet AddSubjectServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSubjectServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            int grade = 0;
            int al_grade = 0;
            
            String sub_type = request.getParameter("sub_type");
            String subject_name = request.getParameter("subject_name");
            String strGrade = request.getParameter("grade");
            String strAlGrade = request.getParameter("al_grade");
            
            if (!strGrade.equals(""))
                grade = Integer.parseInt(request.getParameter("grade"));
            if (!strAlGrade.equals(""))
                al_grade = Integer.parseInt(request.getParameter("al_grade"));
            
            String al_section = request.getParameter("al_section");
            String category = request.getParameter("category");
            String al_category = request.getParameter("al_category");
            double credits = Double.parseDouble(request.getParameter("credits"));
            Subject newSubject = null;
            
            out.println(sub_type);
            out.println(subject_name);
            out.println(grade);
            out.println(al_grade);
            out.println(al_section);
            out.println(category);
            out.println(al_category);
            out.println(credits);
            
            if (al_grade == 0 && al_section.equals("") && al_category.equals("")) {
                newSubject = new Subject(subject_name,sub_type,grade,credits,category);
            }
            else if (grade == 0 && category.equals("")) {
                newSubject = new Subject(subject_name,sub_type,al_grade,al_section,credits,al_category);
            }
            
            if (newSubject.addSubject()) {
                response.sendRedirect(request.getContextPath() + "/Admin/admin_profile.jsp");
            }
            else {
                out.println("not added");
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

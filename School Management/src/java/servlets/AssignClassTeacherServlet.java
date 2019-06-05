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
@WebServlet(name = "AssignClassTeacherServlet", urlPatterns = {"/AssignClassTeacherServlet"})
public class AssignClassTeacherServlet extends HttpServlet {

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
            out.println("<title>Servlet AssignClassTeacherServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AssignClassTeacherServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            int grade = 0;
            String Class = null;
            String section = null;
            String teacher_ID = request.getParameter("teacher");
            String category = request.getParameter("category");
            
            if (category.equalsIgnoreCase("non_al")) {
                grade = Integer.parseInt(request.getParameter("regular_grade"));
                
                if (grade >= 1 && grade < 10) {
                    Class = request.getParameter("regular_classes");
                }
                else if (grade >= 10 && grade < 12) {
                    Class = request.getParameter("ol_classes");
                }
            }
            else if (category.equalsIgnoreCase("al")) {
                grade = Integer.parseInt(request.getParameter("al_grade"));
                section = request.getParameter("al_sections");
                
                if (section.equalsIgnoreCase("SE004")) {
                    Class = request.getParameter("art_classes");
                }
                else if (section.equalsIgnoreCase("SE005")) {
                    Class = request.getParameter("maths_classes");
                }
                else if (section.equalsIgnoreCase("SE006")) {
                    Class = request.getParameter("science_classes");
                }
                else if (section.equalsIgnoreCase("SE007")) {
                    Class = request.getParameter("commerce_classes");
                }
                else if (section.equalsIgnoreCase("SE008")) {
                    Class = request.getParameter("tech_classes");
                }
            }
            
            if (Teacher.assignClassTeachers(teacher_ID, category, grade, Class)) {
                response.sendRedirect(request.getContextPath() + "/Admin/teacher.jsp");
            }
            else {
                out.println("class teacher is not assigned");
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

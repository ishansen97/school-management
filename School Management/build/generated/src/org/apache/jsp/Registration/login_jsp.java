package org.apache.jsp.Registration;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/Registration/../layouts/Navigation.jsp");
    _jspx_dependants.add("/Registration/../layouts/Styles.jsp");
    _jspx_dependants.add("/Registration/../layouts/Scripts.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Login Page</title> \n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("        ");
      out.write("<link href=\"../External/w3/all.css\" rel=\"stylesheet\">\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.css\" rel=\"stylesheet\" type=\"text/css\"/>\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.css\" rel=\"stylesheet\">\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("<!-- Custom fonts for this template-->\n");
      out.write("<link href=\"../External/Font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("<link href=\"../External/Font-awesome/css/all.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("<!-- Page level plugin CSS-->\n");
      out.write("<link href=\"../External/Datatables/dataTables.bootstrap4.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Raleway\">\n");
      out.write("\n");
      out.write("<style>\n");
      out.write("html,body,h1,h2,h3,h4,h5 {font-family: \"Raleway\", sans-serif}\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <style>\n");
      out.write("/*        .nav-item:hover {\n");
      out.write("            background-color: lightgray;\n");
      out.write("            color: green;\n");
      out.write("        }*/\n");
      out.write("        #header {\n");
      out.write("            background-color: lightgrey;\n");
      out.write("            height: 100px;\n");
      out.write("            color: white;\n");
      out.write("            margin-left: 0;\n");
      out.write("            margin-right: 0;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("    </style>\n");
      out.write("    \n");
      out.write("    <body class=\"w3-main\">\n");
      out.write("        \n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <div class=\"row\" style=\"margin-left: 0px; margin-right: 0px\">\n");
      out.write("                <div class=\"col-12\" id=\"header\">\n");
      out.write("                    <h1 class=\"modal-title\" style=\"margin-top: 30px; margin-left: 500px\">International Educational Institute</h1>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-12\">\n");
      out.write("                    <nav class=\"navbar navbar-expand-sm bg-primary navbar-dark\">\n");
      out.write("                        <ul class=\"navbar-nav\">\n");
      out.write("                            <li class=\"nav-item active\">\n");
      out.write("                                <a href=\"#\" class=\"navbar-brand\">Home</a>\n");
      out.write("                            </li>\n");
      out.write("                            <li class=\"nav-item\">\n");
      out.write("                                <a href=\"#\" class=\"nav-link\">Students</a>\n");
      out.write("                            </li>\n");
      out.write("                            <li class=\"nav-item\">\n");
      out.write("                                <a href=\"#\" class=\"nav-link\">Teachers</a>\n");
      out.write("                            </li>\n");
      out.write("                        </ul>\n");
      out.write("                    </nav>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        ");
      out.write("<!-- Bootstrap core JavaScript-->\n");
      out.write("<script src=\"../External/Jquery/jquery.min.js\"></script>\n");
      out.write("<script src=\"../External/Bootstrap/js/bootstrap.bundle.js\"></script>\n");
      out.write("<script src=\"../External/Bootstrap/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("<!-- Core plugin JavaScript-->\n");
      out.write("<script src=\"../External/Jquery/jquery.easing.min.js\"></script>\n");
      out.write("<!-- Page level plugin JavaScript-->\n");
      out.write("<script src=\"../External/Datatables/jquery.dataTables.js\"></script>\n");
      out.write("<script src=\"../External/Datatables/dataTables.bootstrap4.js\"></script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("// Get the Sidebar\n");
      out.write("var mySidebar = document.getElementById(\"mySidebar\");\n");
      out.write("\n");
      out.write("// Get the DIV with overlay effect\n");
      out.write("var overlayBg = document.getElementById(\"myOverlay\");\n");
      out.write("\n");
      out.write("// Toggle between showing and hiding the sidebar, and add overlay effect\n");
      out.write("function w3_open() {\n");
      out.write("    if (mySidebar.style.display === 'block') {\n");
      out.write("        mySidebar.style.display = 'none';\n");
      out.write("        overlayBg.style.display = \"none\";\n");
      out.write("    } else {\n");
      out.write("        mySidebar.style.display = 'block';\n");
      out.write("        overlayBg.style.display = \"block\";\n");
      out.write("    }\n");
      out.write("}\n");
      out.write("\n");
      out.write("// Close the sidebar with the close button\n");
      out.write("function w3_close() {\n");
      out.write("    mySidebar.style.display = \"none\";\n");
      out.write("    overlayBg.style.display = \"none\";\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("        ");
      out.write("<!-- Bootstrap core JavaScript-->\n");
      out.write("<script src=\"../External/Jquery/jquery.min.js\"></script>\n");
      out.write("<script src=\"../External/Bootstrap/js/bootstrap.bundle.js\"></script>\n");
      out.write("<script src=\"../External/Bootstrap/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("<!-- Core plugin JavaScript-->\n");
      out.write("<script src=\"../External/Jquery/jquery.easing.min.js\"></script>\n");
      out.write("<!-- Page level plugin JavaScript-->\n");
      out.write("<script src=\"../External/Datatables/jquery.dataTables.js\"></script>\n");
      out.write("<script src=\"../External/Datatables/dataTables.bootstrap4.js\"></script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("// Get the Sidebar\n");
      out.write("var mySidebar = document.getElementById(\"mySidebar\");\n");
      out.write("\n");
      out.write("// Get the DIV with overlay effect\n");
      out.write("var overlayBg = document.getElementById(\"myOverlay\");\n");
      out.write("\n");
      out.write("// Toggle between showing and hiding the sidebar, and add overlay effect\n");
      out.write("function w3_open() {\n");
      out.write("    if (mySidebar.style.display === 'block') {\n");
      out.write("        mySidebar.style.display = 'none';\n");
      out.write("        overlayBg.style.display = \"none\";\n");
      out.write("    } else {\n");
      out.write("        mySidebar.style.display = 'block';\n");
      out.write("        overlayBg.style.display = \"block\";\n");
      out.write("    }\n");
      out.write("}\n");
      out.write("\n");
      out.write("// Close the sidebar with the close button\n");
      out.write("function w3_close() {\n");
      out.write("    mySidebar.style.display = \"none\";\n");
      out.write("    overlayBg.style.display = \"none\";\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("        ");
      out.write("<link href=\"../External/w3/all.css\" rel=\"stylesheet\">\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.css\" rel=\"stylesheet\" type=\"text/css\"/>\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.css\" rel=\"stylesheet\">\n");
      out.write("<link href=\"../External/Bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("<!-- Custom fonts for this template-->\n");
      out.write("<link href=\"../External/Font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("<link href=\"../External/Font-awesome/css/all.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("<!-- Page level plugin CSS-->\n");
      out.write("<link href=\"../External/Datatables/dataTables.bootstrap4.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Raleway\">\n");
      out.write("\n");
      out.write("<style>\n");
      out.write("html,body,h1,h2,h3,h4,h5 {font-family: \"Raleway\", sans-serif}\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("        \n");
      out.write("        <style>\n");
      out.write("        .card {\n");
      out.write("            margin: auto; \n");
      out.write("            height: 500px; \n");
      out.write("            width: 500px; \n");
      out.write("            border: 1px solid blue; \n");
      out.write("            margin-top: 100px;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        input[type=text], input[type=password] {\n");
      out.write("            height: 40px;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-group {\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("    </head>\n");
      out.write("    \n");
      out.write("    <body class=\"w3-main\">\n");
      out.write("        <script>\n");
      out.write("            function showPassword() {\n");
      out.write("                var pass = document.getElementById(\"pass\");\n");
      out.write("                \n");
      out.write("                if (pass.type === \"password\") {\n");
      out.write("                    pass.type = \"text\";\n");
      out.write("                }\n");
      out.write("                else {\n");
      out.write("                    pass.type = \"password\";\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("        \n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"card\">\n");
      out.write("                    <div class=\"card-header\">\n");
      out.write("                        <h1 class=\"modal-title\">Start from here!!!</h1>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"card-body bg-primary\">\n");
      out.write("                        <form action=\"");
      out.print(request.getContextPath() );
      out.write("/LoginServlet\" name=\"loginForm\" class=\"form-control\">\n");
      out.write("                            <label><b>Select User Type</b></label>\n");
      out.write("                            <div class=\"form-check\">\n");
      out.write("                                <label class=\"form-check-label\">\n");
      out.write("                                    <input type=\"radio\" class=\"form-check-input\" name=\"userType\" value=\"student\">Student\n");
      out.write("                                </label>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-check\">\n");
      out.write("                                <label class=\"form-check-label\">\n");
      out.write("                                    <input type=\"radio\" class=\"form-check-input\" name=\"userType\" value=\"teacher\">Teacher\n");
      out.write("                                </label>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <label for=\"username\"><b>Username</b></label>\n");
      out.write("                                <input type=\"text\" class=\"form-control\" name=\"username\" required>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <label for=\"password\"><b>Password</b></label>\n");
      out.write("                                <input type=\"password\" class=\"form-control\" name=\"password\" id=\"pass\" required>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-check-inline\">\n");
      out.write("                                <input type=\"checkbox\" class=\"form-check-input\" onclick=\"showPassword()\">\n");
      out.write("                                <label class=\"form-check-label\">Show password</label>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <button type=\"submit\" class=\"btn btn-success form-control\">Login</button>\n");
      out.write("                                <p>Not a member? <a href=\"registration.jsp\">Register</a></p>\n");
      out.write("                            </div>\n");
      out.write("                        </form>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

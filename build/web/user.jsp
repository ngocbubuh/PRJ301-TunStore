<%-- 
    Document   : user
    Created on : May 31, 2023, 4:58:07 PM
    Author     : 1005h
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="Assets/css/user-jsp.css">
        <link rel="icon" type="image/x-icon" href="Assets/img/logo/Tủn Store.png">
        <title>User Page</title>
    </head>
    <body>
        <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.roleID ne 'US'}">
            <c:redirect url="login.html"></c:redirect>
        </c:if>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-md navbar-dark sticky-top" style="background-color: rgb(175, 35, 82);"> <!-- Xài thẻ <nav> hoặc xài thẻ <div role="navigation"> -->
            <!-- Navigation bar -->
            <div class="container-fluid">
                <a class="navbar-brand" href="MainController?action=ShoppingPage"> <!-- navbar-brand sẽ tự style logo để vừa với navbar theo chiều dọc-->
                    <img src="Assets/img/logo/Tủn Store.jpg" alt="Logo" style="width:70px;" class="rounded-pill"> 
                </a>
                <span class="navbar-text" style="color: white; font-weight: bold; padding: 0px 30px 0px 0px;">Tủn Store</span>
                <!-- Navbar items -->
                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav">
                        <li class="nav-item nav-item-IDSL">
                            <a class="nav-link active" href="MainController?action=ShoppingPage">Home</a>
                        </li>
                        <li class="nav-item nav-item-IDSL" >
                            <a class="nav-link active" href="#" onclick="alert('Tính năng chưa được hỗ trợ, hoặc sẽ không bao giờ được hỗ trợ ::33');">News</a>
                        </li>
                        <li class="nav-item nav-item-IDSL">
                            <a class="nav-link active" href="#" onclick="alert('Tính năng chưa được hỗ trợ, hoặc sẽ không bao giờ được hỗ trợ ::33');">About Tủn Store</a>
                        </li>
                        <c:if test="${sessionScope.LOGIN_USER.roleID == 'AD'}">
                            <li class="nav-item nav-item-IDSL">
                                <a class="nav-link active" href="admin.jsp" style="font-weight: bold;">Welcome: ${sessionScope.LOGIN_USER.fullName}</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.LOGIN_USER.roleID == 'US'}">
                            <li class="nav-item nav-item-IDSL">
                                <a class="nav-link active" href="user.jsp" style="font-weight: bold;">Welcome: ${sessionScope.LOGIN_USER.fullName}</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <span class="navbar-text" style="color: yellow; font-weight: bold; padding: 0px 30px 0px 0px; font-size: 15px;">${requestScope.MESSAGE}</span>
                <c:url var="logoutLink" value="MainController">
                    <c:param name="action" value="Logout"></c:param>
                </c:url>
                <a href="${logoutLink}" class="shopping-button" style="color: white; font-weight: bold;" >Logout</a>
            </div>
        </nav>
        <!-- Gioi Thieu 1 -->
        <div class="container-fluid" style="padding: 0;">
            <img src="Assets/img/content/Tủn Store Flower Garden US.png" alt="Header" style="width: 100%; margin-bottom: 30px;">
        </div>
        <!-- content -->
        <div class="container">
            <h1 style="margin-bottom: 30px; margin-top: 30px;">User's information:</h1>
            <h3>UserID: ${sessionScope.LOGIN_USER.userID}</h3>
            <h3>Full name: ${sessionScope.LOGIN_USER.fullName}</h3>
            <h3>RoleID: ${sessionScope.LOGIN_USER.roleID}</h3>
        </div>
        <!-- Footer -->
        <footer style="padding-top: 30px; background-color: rgb(175, 35, 82); margin-top: 100px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 col-6">
                        <div>
                            <h3 style="color: white;">Tủn Store</h3>
                            <p class="mb-30 footer-desc" style="color: white;">We have the perfect floral arrangements to brighten someone’s day.<br>All you need is love and a flower shop.</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="">
                            <h4 style="color: white;">Services</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="MainController?action=ShoppingPage" class="text-decoration-none" style="color: white;">Home</a>
                                </li>
                                <li>
                                    <a href="#" class="text-decoration-none" style="color: white;" onclick="alert('Tính năng chưa được hỗ trợ, hoặc sẽ không bao giờ được hỗ trợ ::33');">News</a>
                                </li>
                                <li>
                                    <a href="#" class="text-decoration-none" style="color: white;" onclick="alert('Tính năng chưa được hỗ trợ, hoặc sẽ không bao giờ được hỗ trợ ::33');">About Tủn Store</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 col-12">
                        <div>
                            <h4 style="color: white;">Address</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <p style="color: white;">0949805542</p>
                                </li>
                                <li>
                                    <p><a href="#" onclick="alert('Thank you for your supporting :3!');" style="color: yellow;">baopnse171066@fpt.edu.vn</a>
                                    </p>
                                </li>
                                <li>
                                    <p style="color: white;">Ho Chi Minh City,
                                        Viet Nam</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <div class="copyright">
                        <p style="color: white;">Developed and maintained by <a href="#" onclick="alert('Thank you for your supporting :3!');" style="color: yellow;">Phạm Ngọc Bảo</a></p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- End of footer -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            document.addEventListener("DOMContentLoaded", function (event) {
                                var scrollpos = localStorage.getItem("scrollpos");
                                if (scrollpos)
                                    window.scrollTo(0, scrollpos);
                            });

                            window.onscroll = function (e) {
                                localStorage.setItem("scrollpos", window.scrollY);
                            };
        </script>
    </body>
</html>

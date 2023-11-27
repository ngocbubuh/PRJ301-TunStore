<%-- 
    Document   : shopping
    Created on : Jun 17, 2023, 3:58:08 PM
    Author     : 1005h
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="sample.product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="Assets/css/shopping-html.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="Assets/img/logo/Tủn Store.png">
        <title>Tủn's Store</title>
    </head>
    <body>
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
                                <a class="nav-link active" href="admin.jsp" style="font-weight: bold;">Account: ${sessionScope.LOGIN_USER.fullName}</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.LOGIN_USER.roleID == 'US'}">
                            <li class="nav-item nav-item-IDSL">
                                <a class="nav-link active" href="user.jsp" style="font-weight: bold;">Account: ${sessionScope.LOGIN_USER.fullName}</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.LOGIN_USER == null}">
                            <li class="nav-item nav-item-IDSL">
                                <a class="nav-link active" href="login.html" style="font-weight: bold;">Login</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <span class="navbar-text" style="color: yellow; font-weight: bold; padding: 0px 30px 0px 0px; font-size: 15px;">${requestScope.MESSAGE}</span>
                <a href="MainController?action=View" class="shopping-button" style="color: white; font-weight: bold;" >View Cart</a>
            </div>
        </nav>
        <!-- Gioi Thieu 1 -->
        <div class="container-fluid" style="padding: 0;">
            <img src="Assets/img/content/Tủn Store Flower Garden.png" alt="Header" style="width: 100%; margin-bottom: 30px;">
        </div>
        <!-- Gioi thieu 2 -->
        <!-- Content -->
        <div class="container">
            <div class="table-responsive">
                <c:if test="${sessionScope.LIST_P != null}">
                    <c:if test="${not empty sessionScope.LIST_P}">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th style="text-align: center;">Image</th>
                                    <th style="text-align: center;">Name</th>
                                    <th style="text-align: center;">Price</th>
                                    <th style="text-align: center;">Quantity</th>
                                    <th style="text-align: center;">Qty. Available</th>
                                    <th style="text-align: center;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" varStatus="counter" items="${sessionScope.LIST_P}">
                                <form action="MainController" method="POST">
                                    <tr>
                                        <td style="text-align: center;">
                                            <img src="Assets/img/product/${product.productImage}" alt="alt" width="150px" height="150px" style="border-radius: 10px;"/> 
                                        </td>
                                        <td style="padding-top: 60px; text-align: center;">
                                            <input type="text" name="productName" value="${product.productName}" readonly="" style="border: none; background: none; font-size: 20px; text-align: center; max-width: 200px;"/>
                                        </td>
                                        <td style="padding-top: 60px; text-align: center;">
                                            <input type="text" name="productPrice" value="${product.productPrice}" readonly="" style="border: none; background: none; font-size: 20px; text-align: center; max-width: 150px;"/>
                                        </td>
                                        <td style="padding-top: 60px; text-align: center;">
                                            <input type="number" name="quantity" value="1" min="1" style="font-size: 20px; border-radius: 10px; text-align: center; max-width: 150px; "/>
                                        </td>
                                        <td style="padding-top: 60px; text-align: center;">
                                            <input type="text" name="quanityAvailable" value="${product.productQuantity}" readonly="" style="border: none; background: none; font-size: 20px; text-align: center; max-width: 150px;"/>
                                        </td>
                                        <td style="padding-top: 60px; text-align: center;">
                                            <input type="hidden" name="productID" value="${product.productID}"/>
                                            <input type="hidden" name="productImage" value="${product.productImage}"/>
                                            <input type="hidden" name="action" value="Add"/>
                                            <input type="submit" value="Add to Cart" class="btn btn-success" style="margin: 0px 10px;"/>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </c:if>
            </div>
        </div>
        <!-- Footer -->
        <footer style="padding-top: 30px; background-color: rgb(175, 35, 82); margin-top: 30px;">
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

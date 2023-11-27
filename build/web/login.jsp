<%-- 
    Document   : login
    Created on : May 31, 2023, 4:50:08 PM
    Author     : 1005h
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="Assets/css/login-html.css">
        <link rel="icon" type="image/x-icon" href="Assets/img/logo/Tủn Store.jpg">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <h1 style="font-weight: bolder;">Tủn Store</h1>
            </div>
            <div class="row">
                <form action="MainController" method="POST" class="Login_Form">
                    <div class="Login_Form_Row">
                        <p>UserID</p>
                        <input type="text" name="userID" required=""/>
                    </div>
                    <div class="Login_Form_Row">
                        <p>Password</p>
                        <input type="password" name="password" required=""/>
                    </div>
                    <div style="color: red;">${requestScope.ERROR}</div>
                    <div style="color: red;">${requestScope.MESSAGE_CHECKOUT}</div>
                    <a href="MainController?action=CreatePage" style="margin-bottom: 20px; margin-top: 0px;">Create Account?</a>
                    <div class="button" style="display: flex; justify-content: center;">
                        <input type="submit" name="action" value="Login"/>
                        <input type="reset" value="Reset"/>
                    </div>
                </form>
            </div>
            <div class="row shopping-button">
                <a href="https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:8080/PRJ301_Assignment_TunStore/LoginGoogleController&response_type=code
                   &client_id=291476931915-ko5t92qurg5t0q2o7486n2ef1ocejert.apps.googleusercontent.com&approval_prompt=force" style="color: white; font-weight: bold;">Login With Google</a>
            </div><br>
            <div class="row shopping-button">
                <a href="MainController?action=ShoppingPage" style="color: white; font-weight: bold;">Tủn Store</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
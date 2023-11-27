<%-- 
    Document   : create
    Created on : Jun 10, 2023, 4:28:58 PM
    Author     : 1005h
--%>

<%@page import="sample.user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="Assets/css/create-jsp.css">
        <link rel="icon" type="image/x-icon" href="Assets/img/logo/Tủn Store.jpg">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <h1 style="font-weight: bolder;">Create Account</h1>
            </div>
            <div class="row">
                <form action="MainController" method="POST" class="Create_Form" id="CreateFrom">
                    <div class="Create_Form_Row">
                        <p>UserID</p>
                        <input type="text" name="userID" required=""/>
                    </div>
                    <div style="color: red; margin-bottom: 10px;">${requestScope.USER_ERROR.userIDError}</div>
                    <div class="Create_Form_Row">
                        <p>Full Name</p>
                        <input type="text" name="fullName" required=""/>
                    </div>
                    <div style="color: red; margin-bottom: 10px;">${requestScope.USER_ERROR.fullNameError}</div>
                    <div class="Create_Form_Row">
                        <p>Role ID</p>
                        <input type="text" name="roleID" readonly="" value="US"/>
                    </div>
                    <div class="Create_Form_Row">
                        <p>Password</p>
                        <input type="password" name="password" required=""/>
                    </div>
                    <div class="Create_Form_Row">
                        <p>Confirm Password</p>
                        <input type="password" name="confirm" required=""/>
                    </div>
                    <div style="color: red; margin-bottom: 10px;">${requestScope.USER_ERROR.confirmError}</div>
                    <a href="MainController" style="margin-bottom: 20px; margin-top: 0px;">Already have an account? Login here!</a>
                    <div style="display: flex; justify-content: center">
                        <div id="html_element"></div>
                    </div>
                    <div id="error" style="color : red; text-align: center; padding-bottom: 15px"></div>
                    <div class="button" style="display: flex; justify-content: center;">
                        <input type="hidden" name="action" value="Create"/>
                        <input type="submit" value="Create"/>
                        <input type="reset" value="Reset"/>
                    </div>
                </form>
            </div>
            <div class="row" style="margin-top: 8%;"></div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
                async defer>
        </script>
        <script type="text/javascript">
            var onloadCallback = function () {
                grecaptcha.render('html_element', {
                    'sitekey': '6LcwrccmAAAAAL-6CMoaecZJUwy0wXjNlKzts2jl'
                });
            };
        </script>
        <script>
            window.onload = function () {
                let isValid = false;
                const form = document.getElementById("CreateFrom");
                const error = document.getElementById("error");

                form.addEventListener("submit", function (event) {
                    event.preventDefault();
                    const response = grecaptcha.getResponse();
                    if (response) {
                        form.submit();
                    } else {
                        error.innerHTML = "Please check reCAPTCHA.";
                    }
                });
            }
        </script>
    </body>
</html>

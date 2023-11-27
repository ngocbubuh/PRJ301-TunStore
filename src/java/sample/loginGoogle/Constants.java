/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.loginGoogle;

/**
 *
 * @author giadu
 */
public class Constants {

    public static String GOOGLE_CLIENT_ID = "291476931915-ko5t92qurg5t0q2o7486n2ef1ocejert.apps.googleusercontent.com";

    public static String GOOGLE_CLIENT_SECRET = "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";

    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/PRJ301_Assignment_TunStore/LoginGoogleController";

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}

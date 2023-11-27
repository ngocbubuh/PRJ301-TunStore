/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

/**
 *
 * @author 1005h
 */
public class UserDTO {

    private String userID;
    private String fullName;
    private String email;
    private String roleID;
    private String password;
    private String googleID;

    public UserDTO() {
        this.userID = "";
        this.fullName = "";
        this.roleID = "";
        this.password = "";
    }
    
    public UserDTO(String userID, String fullName, String roleID, String password){
        this.userID = userID;
        this.fullName = fullName;
        this.email = "";
        this.roleID = roleID;
        this.password = password;
        this.googleID = "";
    }

    public UserDTO(String userID, String fullName, String email, String roleID, String password, String googleID) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.roleID = roleID;
        this.password = password;
        this.googleID = googleID;
    }

    public String getGoogleID() {
        return googleID;
    }

    public void setGoogleID(String googleID) {
        this.googleID = googleID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
}

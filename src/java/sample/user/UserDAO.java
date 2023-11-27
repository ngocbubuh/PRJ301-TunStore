/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sample.utils.DBUtils;

/**
 *
 * @author 1005h
 */
public class UserDAO {
    private static final String LOGIN="SELECT fullName, roleID FROM tblUsers  WHERE userID=? AND password=?";
    private static final String SEARCH="SELECT userID, fullName, roleID FROM tblUsers WHERE fullname like ?";
    private static final String DELETE="DELETE tblUsers WHERE userID= ?";
    private static final String UPDATE="UPDATE tblUsers SET fullName=?, roleID=? WHERE userID=?";
    private static final String CHECK_DUPLICATE="SELECT roleID FROM tblUsers WHERE userID = ?";
    private static final String INSERT="INSERT INTO tblUsers(userID, fullName, roleID, password) VALUES(?,?,?,?)";
    private static final String LOGIN_GOOGLE = "SELECT userID, fullName, roleID FROM tblUsers WHERE googleId=? AND email=?";
    private static final String INSERT_GOOGLE="INSERT INTO tblUsers(userID, fullName, roleID, password, email, googleId) VALUES(?,?,?,?,?,?)";
    public UserDTO checkLogin(String userID, String password) throws SQLException{
        UserDTO user=null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LOGIN);
            ptm.setString(1, userID);
            ptm.setString(2, password);
            rs = ptm.executeQuery();
            if(rs.next()){
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                user = new UserDTO(userID, fullName, roleID, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs!=null) rs.close();
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();  
        }
        return user;
    }
    
    public List<UserDTO> getListUser(String search) throws SQLException{
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!= null){
                ptm= conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" +  search + "%");
                rs = ptm.executeQuery();
                while(rs.next()){
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String password = "***";
                    list.add(new UserDTO(userID, fullName, roleID, password));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs!=null) rs.close();
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
        return list;
    }
    
    public boolean delete(String userID) throws SQLException{
        boolean check = false;
        Connection conn= null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null){
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, userID);
                check = ptm.executeUpdate()>0?true:false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
        return check;
    }

    public boolean update(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn= null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null){
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, user.getFullName());
                ptm.setString(2, user.getRoleID());
                ptm.setString(3, user.getUserID());
                check = ptm.executeUpdate()>0?true:false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
        return check;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn!=null) {
                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs!=null) rs.close();
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();   
        }
        return check;
    }

    public boolean insert(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn= null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null){
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, user.getUserID());
                ptm.setString(2, user.getFullName());
                ptm.setString(3, user.getRoleID());
                ptm.setString(4, user.getPassword());
                check = ptm.executeUpdate()>0?true:false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
        return check;
    }

    public boolean insertV2(UserDTO user) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn= null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null){
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, user.getUserID());
                ptm.setString(2, user.getFullName());
                ptm.setString(3, user.getRoleID());
                ptm.setString(4, user.getPassword());
                check = ptm.executeUpdate()>0?true:false;
            }
        } finally {
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
        return check;  
    }

    public UserDTO checkLoginGoogle(String email, String googleId) throws SQLException {
        UserDTO user=null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LOGIN_GOOGLE);
            ptm.setString(1, googleId);
            ptm.setString(2, email);
            rs = ptm.executeQuery();
            if(rs.next()){
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                user = new UserDTO(userID, fullName, email, roleID, "123iausgfkjzxbfieryqoqwlkkzdfn883401", googleId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs!=null) rs.close();
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();  
        }
        return user;
    }

    public void checkInsertGoogle(UserDTO newUser) throws SQLException {
        Connection conn= null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null){
                ptm = conn.prepareStatement(INSERT_GOOGLE);
                ptm.setString(1, newUser.getUserID());
                ptm.setString(2, newUser.getFullName());
                ptm.setString(3, newUser.getRoleID());
                ptm.setString(4, newUser.getPassword());
                ptm.setString(5, newUser.getEmail());
                ptm.setString(6, newUser.getGoogleID());
                ptm.executeQuery();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm!=null) ptm.close();
            if (conn!=null) conn.close();
        }
    }
    
    
}

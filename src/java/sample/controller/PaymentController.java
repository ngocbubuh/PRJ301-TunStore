/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.vnpay.common.Config;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.order.OrderDAO;
import sample.order.OrderDTO;
import sample.order.OrderDetailsDAO;
import sample.payment.ReceiverDTO;
import sample.product.ProductDTO;
import sample.shopping.Cart;
import sample.user.UserDTO;

/**
 *
 * @author 1005h
 */
public class PaymentController extends HttpServlet {

    private static final String ERROR = "checkOut.jsp";
    private static final String SUCCESS_COD = "PaymentResultController";

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String url = ERROR;
        try {
            String payType = req.getParameter("payType");
            String email = req.getParameter("email");
            String fullName = req.getParameter("fullName");
            HttpSession session = req.getSession();
//            //Luu email nguoi nhan
//            session.setAttribute("EMAIL", email);
//            //Luu ten nguoi nhan
//            session.setAttribute("NAME", fullName);
            ReceiverDTO receiver = new ReceiverDTO(fullName, email);
            session.setAttribute("RECEIVER", receiver);
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            OrderDAO dao = new OrderDAO();
            
            //Tao Order
            //OrderCode
            String orderCode = Config.getRandomNumber(8);
            //UserID
            String userID = user.getUserID();
            //Date
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
            String date = formatter.format(cld.getTime());
            //Total
            double total = Double.parseDouble(req.getParameter("total"));
            //Status
            boolean status = false;
            OrderDTO order = new OrderDTO(orderCode, userID, date, total, status);
            OrderDAO odao = new OrderDAO();
            int lastInsertID = odao.AddOrder(order);
            boolean checkInsert = false;
            //Tao orderdetails
            if (lastInsertID > 0) {
                Cart cart = (Cart) session.getAttribute("CART");
                OrderDetailsDAO oddao = new OrderDetailsDAO();
                if (cart != null) {
                    for (ProductDTO product : cart.getCart().values()) {
                        checkInsert = oddao.insert(product, lastInsertID);
                    }
                }
            }

            if ("VNPAY".equals(payType)) {
//                Cap nhat payment method
                order.setPaymentMethod("VNPAY");
                dao.updateOrderMethod(order);
                orderCode = order.getOrderCode();
                long price = (long) Double.parseDouble(req.getParameter("amount"));
                url = vnpay_Pay(orderCode, price, req, resp);
                session.setAttribute("ORDER", order);
            }
            if ("COD".equals(payType)) {
                order.setPaymentMethod("COD");
                dao.updateOrderMethod(order);
                url = SUCCESS_COD;
                session.setAttribute("ORDER", order);
            }
        } catch (Exception e) {
            log("Error at PaymentController: " + e.toString());
        } finally {
            resp.sendRedirect(url);
        }

    }

    private String vnpay_Pay(String orderCode, long price, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
//        String orderType = req.getParameter("ordertype");
        String orderType = "110000";
        long amount = price * 100;
//        String bankCode = req.getParameter("bankCode");
        String bankCode = "NCB";

//        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_TxnRef = orderCode;
        String vnp_IpAddr = Config.getIpAddress(req);
        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef + "; Phuong thuc thanh toan VNPAY");
        vnp_Params.put("vnp_OrderType", orderType);

//        String locate = req.getParameter("language");
        String locate = "vn";
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_Returnurl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        com.google.gson.JsonObject job = new JsonObject();
        job.addProperty("code", "00");
        job.addProperty("message", "success");
        job.addProperty("data", paymentUrl);
        Gson gson = new Gson();
        resp.getWriter().write(gson.toJson(job));
        return paymentUrl;
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

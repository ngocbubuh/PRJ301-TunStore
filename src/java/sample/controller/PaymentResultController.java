/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.Mail.Email;
import sample.order.OrderDAO;
import sample.order.OrderDTO;
import sample.payment.Payment_COD_DTO;
import sample.payment.Payment_VNP_DTO;
import sample.payment.ReceiverDTO;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.shopping.Cart;
import sample.user.UserDTO;

/**
 *
 * @author 1005h
 */
public class PaymentResultController extends HttpServlet {

    private static final String ERROR = "shopping.jsp";
    private static final String VNP = "paymentResultVNP.jsp";
    private static final String COD = "paymentResultCOD.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            //Cap nhat quantity san pham va tinh trang thanh toan o day
            HttpSession session = request.getSession();
            ProductDAO pDao = new ProductDAO();
            OrderDAO odao = new OrderDAO();
            Cart cart = (Cart) session.getAttribute("CART");
            OrderDTO order = (OrderDTO) session.getAttribute("ORDER");
            ReceiverDTO receiver = (ReceiverDTO) session.getAttribute("RECEIVER");

            if ("VNPAY".equals(order.getPaymentMethod())) {
                long vnp_Amount = Integer.parseInt(request.getParameter("vnp_Amount"));
                String vnp_BankCode = request.getParameter("vnp_BankCode");
                String vnp_BankTranNo = request.getParameter("vnp_BankTranNo");
                String vnp_CardType = request.getParameter("vnp_CardType");
                String vnp_PayDate = request.getParameter("vnp_PayDate");
                String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
                String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
                String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
                String vnp_TxnRef = request.getParameter("vnp_TxnRef");
                Payment_VNP_DTO payment = new Payment_VNP_DTO(vnp_Amount, vnp_BankCode, vnp_BankTranNo, vnp_CardType, vnp_PayDate, vnp_OrderInfo, vnp_TransactionNo, vnp_ResponseCode, vnp_TxnRef);
                if (vnp_ResponseCode.equals("00")) {
                    boolean checkQuantity = false;
                    if (cart != null) {
                        for (ProductDTO product : cart.getCart().values()) {
                            checkQuantity = pDao.updateQuantity(product);
                        }
                        order.setPaymentStatus(true);
                        odao.updateStatus(order);
                        if (order.getPaymentStatus()) {
                            payment.setVnp_Status("SUCCESS");
                        }
                        session.setAttribute("PAYMENT", payment);
                        session.setAttribute("RECEIVER", receiver);
                        sendMail_Method(order, receiver);
                        session.setAttribute("CART", null);
                        session.setAttribute("ORDER", null);
                        session.setAttribute("EMAIL", null);
                        url = VNP;
                    }
                } else {
                    payment.setVnp_Status("FAILED");
                    session.setAttribute("ORDER", null);
                    session.setAttribute("EMAIL", null);
                    url = VNP;
                }
            } else if ("COD".equals(order.getPaymentMethod())) {
                double amount = order.getOrderTotal();
                String date = order.getOrderDate();
                String orderInfo = "Thanh toan don hang: " + order.getOrderCode() + "; Phuong thuc thanh toan COD";
                String orderCode = order.getOrderCode();
                Payment_COD_DTO payment = new Payment_COD_DTO(amount, date, orderInfo, orderCode);
                //COD cung cap nhat quantity va tinh trang thanh toan, va gui mail
                boolean checkQuantity = false;
                if (cart != null) {
                    for (ProductDTO product : cart.getCart().values()) {
                        checkQuantity = pDao.updateQuantity(product);
                    }
                    order.setPaymentStatus(true);
                    odao.updateStatus(order);
                    if (order.getPaymentStatus()) {
                        payment.setStatus("SUCCESS");
                    }
                    session.setAttribute("PAYMENT", payment);
                    session.setAttribute("RECEIVER", receiver);
                    sendMail_Method(order, receiver);
                    session.setAttribute("CART", null);
                    session.setAttribute("ORDER", null);
                    session.setAttribute("EMAIL", null);
                    url = COD;
                } else {
                    payment.setStatus("FAILED");
                    session.setAttribute("ORDER", null);
                    session.setAttribute("EMAIL", null);
                    url = COD;
                }
            } else {
                request.setAttribute("MESSAGE", "Something went wrong! Any changed has been rolled back!");
                session.setAttribute("EMAIL", null);
                session.setAttribute("ORDER", null);
                url = ERROR;
            }
        } catch (Exception e) {
            log("Error at PaymentResultController: " + e.toString());
        } finally {
            response.sendRedirect(url);
        }
    }

    private void sendMail_Method(OrderDTO order, ReceiverDTO receiver) {
        String email = receiver.getEmail();
        String bill = "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <title>Order Invoice</title>\n"
                + "    <style>\n"
                + "        .line {\n"
                + "            border-top: 2px solid black;\n"
                + "            margin: 20px 0;\n"
                + "        }\n"
                + "        body {\n"
                + "            font-family: Arial, sans-serif;\n"
                + "            margin: 0;\n"
                + "            padding: 20px;\n"
                + "            background-color: #f2f2f2;\n"
                + "        }\n"
                + "        .header {\n"
                + "            text-align: center;\n"
                + "            margin-bottom: 20px;\n"
                + "            background-color: white;\n"
                + "            padding: 10px;\n"
                + "        }\n"
                + "        .title {\n"
                + "            margin-bottom: 20px;"
                + "        }\n"
                + "        .UserInfo, .paymentMethod, .OrderInfo {\n"
                + "            margin-bottom: 20px;\n"
                + "        }\n"
                + "        .UserInfo h4, .paymentMethod h4, .OrderInfo h4 {\n"
                + "            margin-bottom: 10px;\n"
                + "        }\n"
                + "        .Total {\n"
                + "            text-align: left;\n"
                + "            font-weight: bold;\n"
                + "            font-size: 18px;\n"
                + "        }\n"
                + "        img {\n"
                + "            max-width: 200px;\n"
                + "            height: auto;\n"
                + "        }\n"
                + "    </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"header\">\n"
                + "        <img src=\"https://cdn.discordapp.com/attachments/1090646946127036508/1125092227857784964/Tun_Store.png\" alt=\"Tủn Store Logo\" style=\"width: 200px;\">\n"
                + "    </div>\n"
                + "    <div class=\"title\">\n"
                + "        <p>Greetings " + receiver.getName() + ",</p>\n"
                + "        <p>Thank you for your ordering at Tủn Store!</p>\n"
                + "        <p>Your order " + order.getOrderCode() + " has been successfully paid on " + order.getOrderDate() + "</p>\n"
                + "    </div>\n"
                + "    <div class=\"line\"></div>\n"
                + "    <div class=\"content\">\n"
                + "        <div class=\"UserInfo\">\n"
                + "            <h4>Receiver's Information:</h4>\n"
                + "            <p>Full Name: " + receiver.getName() + "</p>\n"
                + "            <p>Email: " + receiver.getEmail() + "</p>\n"
                + "        </div>\n"
                + "        <div class=\"paymentMethod\">\n"
                + "            <h4>Payment Method:</h4>\n"
                + "            <p>" + order.getPaymentMethod() + "</p>\n"
                + "        </div>\n"
                + "        <div class=\"OrderInfo\">\n"
                + "            <h4>Order's Information:</h4>\n"
                + "            <p>Invoice: " + order.getOrderCode() + "</p>\n"
                + "            <p>Order date: " + order.getOrderDate() + "</p>\n"
                + "        </div>\n"
                + "        <div class=\"line\"></div>\n"
                + "        <div class=\"Total\">\n"
                + "            <p>Total: " + order.getOrderTotal() + " VNĐ</p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>\n";
        Email.sendEmail(email, "Tun Store Order Invoice", bill);
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

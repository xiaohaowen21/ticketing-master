package com.cn.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.cn.domain.Prep;

/**
 * 
 * @ClassName: AlipayServlet 
 * @Description: 支付宝支付接口 PC端
 * @author: ljy
 * @date: 2019年11月14日 上午1:10:23
 */
public class AlipayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String URL = "https://openapi.alipaydev.com/gateway.do";	//沙箱环境使用
		//String URL = "https://openapi.alipay.com/gateway.do"; 	//外网真实环境使用
		String APP_ID = config("ALIPAY_APP_ID");  // 从环境变量读取，不再写入源码
		String APP_PRIVATE_KEY = config("ALIPAY_APP_PRIVATE_KEY");
		String FORMAT = "json"; // 参数返回格式，只支持 json
		String CHARSET = "UTF-8"; // 编码集，支持 GBK/UTF-8
		String ALIPAY_PUBLIC_KEY = config("ALIPAY_PUBLIC_KEY");
		String SIGN_TYPE = "RSA2"; // 商户生成签名字符串所使用的签名算法类型，目前支持 RSA2 和 RSA，推荐使用 RSA2

		if (APP_ID == null || APP_PRIVATE_KEY == null || ALIPAY_PUBLIC_KEY == null) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("支付未配置：请设置环境变量 ALIPAY_APP_ID、ALIPAY_APP_PRIVATE_KEY、ALIPAY_PUBLIC_KEY");
			return;
		}

		// 从PayServlet获取的订单信息
		Prep prep = (Prep) request.getAttribute("prep");
		
		
		
        String out_trade_no = String.valueOf(new Date()) + String.valueOf(prep.getPrepId());  // 商户订单号，商户网站订单系统中唯一订单号，必填
        String total_amount = String.valueOf(prep.getPrice())+".00";  // 付款金额，必填
        String subject = prep.getStartStation()+"站 - "+prep.getEndStation() + "站    火车票";  // 商品名称
        //String returnUrl = "http://localhost:8080/ticketing/PayServlet?temp=1&prepId="+prep.getPrepId()+""; // 回跳地址
        String returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/ticketing/PayServlet?temp=1&prepId="+prep.getPrepId()+"";
        
		AlipayClient alipayClient = new DefaultAlipayClient(URL, APP_ID, APP_PRIVATE_KEY, FORMAT, CHARSET, ALIPAY_PUBLIC_KEY, SIGN_TYPE); // 获得初始化的AlipayClient
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();// 创建API对应的request
		alipayRequest.setReturnUrl(returnUrl);
		alipayRequest.setNotifyUrl("http://domain.com/CallBack/notify_url.jsp");// 在公共参数中设置回跳和通知地址
		alipayRequest.setBizContent("{" + "    \"out_trade_no\":\""+out_trade_no+"\","
				+ "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," + "    \"total_amount\":"+total_amount+","
				+ "    \"subject\":\""+subject+"\"," + "    \"body\":\""+subject+"\","
				+ "    \"passback_params\":\"merchantBizType%3d3C%26merchantBizNo%3d2016010101111\","
				+ "    \"extend_params\":{" + "    \"sys_service_provider_id\":\"2088511833207846\"" + "    }" + "  }");// 填充业务参数
		String form = "";
		try {
			form = alipayClient.pageExecute(alipayRequest).getBody(); // 调用SDK生成表单
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=" + CHARSET);
		response.getWriter().write(form);// 直接将完整的表单html输出到页面
		response.getWriter().flush();
		response.getWriter().close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}


	/** 读取支付配置：优先环境变量，其次 JVM 系统属性（-DALIPAY_APP_ID=...）。 */
	private static String config(String name) {
		String value = System.getenv(name);
		if (value == null || value.trim().isEmpty()) {
			value = System.getProperty(name);
		}
		return (value == null || value.trim().isEmpty()) ? null : value.trim();
	}
}

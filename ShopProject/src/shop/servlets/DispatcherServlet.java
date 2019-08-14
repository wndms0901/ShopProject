package shop.servlets;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import shop.bind.DataBinding;
import shop.bind.ServletMultipartRequestDataBinder;
import shop.bind.ServletRequestDataBinder;
import shop.context.ApplicationContext;
import shop.controls.Controller;
import shop.controls.VoidController;
import shop.listeners.ContextLoaderListener;

@WebServlet("*.do")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String servletPath = request.getServletPath();
		System.out.println(servletPath);
		try {
			/* ServletContext sc = this.getServletContext(); */
			ApplicationContext ctx = ContextLoaderListener.getApplicationContext();
			HashMap<String, Object> model = new HashMap<String, Object>();
			model.put("session", request.getSession()); // 로그인, 로그아웃에서 사용
			model.put("request", request); // 장바구니에서 사용
			model.put("response", response); // ajax 출력할때 사용
			String check = servletPath.substring(servletPath.length() - 4, servletPath.length() - 3);
			System.out.println(check);
			if (check.equals("A")) { // 페이지 이동을 하지않을때
				VoidController pageController = (VoidController) ctx.getBean(servletPath);
				System.out.println("ajaxController...............");
				if (pageController == null) {
					throw new Exception("요청한 서비스를 찾을 수 없습니다.");
				}

				if (pageController instanceof DataBinding) {
					prepareRequestData(request, model, (DataBinding) pageController);
				}
				pageController.execute(model);
			} else { // 페이지 이동할 때
				Controller pageController = (Controller) ctx.getBean(servletPath);
				if (pageController == null) {
					throw new Exception("요청한 서비스를 찾을 수 없습니다.");
				}

				if (pageController instanceof DataBinding) {
					if (request.getMethod().equals("POST") && servletPath.equals("/admin/product.do")) {
						System.out.println("상품 이미지 등록................................");
						String fileurl = "/wndms0901/tomcat/webapps/ROOT/images/product"; // 업로드된 파일이 저장될 파일경로
						String encType = "UTF-8"; // 인코딩 타입
						int Maxsize = 5 * 1024 * 1024; // 업로드할 파일의 최대크기
						// 업로드 파일명이 중복 될 경우 (n)이 파일명 뒤에 붙어서 업로드됨
						DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
						MultipartRequest multi = new MultipartRequest(request, fileurl, Maxsize, encType, policy);
						prepareRequestData(multi, model, (DataBinding) pageController);
					}else if(request.getMethod().equals("POST") && servletPath.equals("/admin/board.do")) {
						System.out.println("게시판 이미지 등록................................");
						int Maxsize = 5 * 1024 * 1024; // 업로드할 파일의 최대크기
						String fileurl = "/wndms0901/tomcat/webapps/ROOT/images/board"; // 업로드된 파일이 저장될 파일경로
						String encType = "UTF-8"; // 인코딩 타입
						// 업로드 파일명이 중복 될 경우 (n)이 파일명 뒤에 붙어서 업로드됨
						DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
						MultipartRequest multi = new MultipartRequest(request, fileurl, Maxsize, encType, policy);
						prepareRequestData(multi, model, (DataBinding) pageController);
					}else {
						prepareRequestData(request, model, (DataBinding) pageController);
					}
				}

				String viewUrl = pageController.execute(model);

				for (String key : model.keySet()) {

					request.setAttribute(key, model.get(key));
				}
				if (viewUrl.startsWith("redirect:")) {
					response.sendRedirect(viewUrl.substring(9));
				} else {
					RequestDispatcher rd = request.getRequestDispatcher(viewUrl);
					rd.include(request, response);
				}
			}
		} catch (Exception e) {
			request.setAttribute("error", e);
			RequestDispatcher rd = request.getRequestDispatcher("../Error.html");
			rd.forward(request, response);
		}
	}

	private void prepareRequestData(HttpServletRequest request, HashMap<String, Object> model, DataBinding dataBinding)
			throws Exception {
		Object[] dataBinders = dataBinding.getDataBinders();
		String dataName = null;
		Class<?> dataType = null;
		Object dataObj = null;
		for (int i = 0; i < dataBinders.length; i += 2) {
			dataName = (String) dataBinders[i];
			dataType = (Class<?>) dataBinders[i + 1];
			dataObj = ServletRequestDataBinder.bind(request, dataType, dataName);
			model.put(dataName, dataObj);
		}
	}

	private void prepareRequestData(MultipartRequest multi, HashMap<String, Object> model, DataBinding dataBinding)
			throws Exception {
		Object[] dataBinders = dataBinding.getDataBinders();
		String dataName = null;
		Class<?> dataType = null;
		Object dataObj = null;

		for (int i = 0; i < dataBinders.length; i += 2) {
			dataName = (String) dataBinders[i];
			dataType = (Class<?>) dataBinders[i + 1];
			dataObj = ServletMultipartRequestDataBinder.bind(multi, dataType, dataName);
			model.put(dataName, dataObj);
		}
	}
}

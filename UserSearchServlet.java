package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); //JSP에서 UTF-8로 설정했기 때문에
		response.setContentType("text/html; charset=UTF-8");
		String userName = request.getParameter("userName");
		//마지막으로 json 으로 출력 할 수 있도록 getWriter 함수 써주기
		response.getWriter().write(getJSON(userName));
	}
	
	public String getJSON(String userName) {
		if(userName ==null ) userName="";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":["); //결과를 담는다
		UserDAO userDAO = new UserDAO(); 
		ArrayList<User> userList = userDAO.search(userName); //userName으로 검색
		
		for(int i=0; i<userList.size(); i++) {
			result.append("[{\"value\":\""+userList.get(i).getUserName()+"\"},");
			result.append("[\"value\":\""+userList.get(i).getUserAge()+"\"},");
			result.append("[\"value\":\""+userList.get(i).getUserGender()+"\"},");
			result.append("[\"value\":\""+userList.get(i).getUserEmail()+"\"}],");
		}
		result.append("]}");
		return result.toString(); //json으로 출력
		
		
	}
}

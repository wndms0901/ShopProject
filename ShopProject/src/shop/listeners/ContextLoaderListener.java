package shop.listeners;

import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import shop.context.ApplicationContext;

@WebListener
public class ContextLoaderListener implements ServletContextListener {
	static ApplicationContext applicationContext;
	
	
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		try {
			applicationContext = new ApplicationContext();
			
			String resource ="shop/dao/mybatis-config.xml";
	    	InputStream inputStream = Resources.getResourceAsStream(resource);
	    	SqlSessionFactory sqlSessionFactory = 
	    			new SqlSessionFactoryBuilder().build(inputStream);
			
	    	applicationContext.addBean("sqlSessionFactory", sqlSessionFactory);
	    	
			ServletContext sc = event.getServletContext();
			String propertiesPath= sc.getRealPath(
					sc.getInitParameter("contextConfigLocation"));
			
			applicationContext.prepareObjectsByProperties(propertiesPath);
			applicationContext.prepareObjectsByAnnotation("");
			applicationContext.injectDependency();
			
			/*InitialContext initialContext = new InitialContext();
			 ds = (DataSource)initialContext.lookup(
					"java:comp/env/jdbc/shopdb");*/
/*			MySqlProductDao productDao = new MySqlProductDao();
			productDao.setSqlSessionFactory(sqlSessionFactory);
			sc.setAttribute("/main/list.do", new MainListController().setProductDao(productDao));*/
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

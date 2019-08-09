package shop.bind;

import java.lang.reflect.Method;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Enumeration;
import java.util.NoSuchElementException;

import com.oreilly.servlet.MultipartRequest;

public class ServletMultipartRequestDataBinder {
	public static Object bind(MultipartRequest multi, Class<?> dataType, String dataName) throws Exception {
		if (isPrimitiveType(dataType)) {
			return createValueObject(dataType, multi.getParameter(dataName));
		}
		Enumeration<?> paramNames = multi.getParameterNames();
		Enumeration<?> fileNames = multi.getFileNames();
		Object dataObject = dataType.newInstance();
		Method m = null;
		while(paramNames.hasMoreElements()) {
			String paramName = (String)paramNames.nextElement();
			System.out.println("paramName: "+paramName);
			m=findSetter(dataType, paramName); // paramName과 일치하는 셋터메서드를 찾음
			System.out.println("m= "+m);
			if(m!= null) {
				//해당 메서드 호출
				System.out.println("dataObject: "+dataObject);
				System.out.println("create: "+createValueObject(m.getParameterTypes()[0], multi.getParameter(paramName)));
				m.invoke(dataObject, createValueObject(m.getParameterTypes()[0], multi.getParameter(paramName)));
			}
		}
		if(fileNames.hasMoreElements()) {
			String file1 =fileNames.nextElement().toString();
			try {
				String file2 = fileNames.nextElement().toString();
				String fileName1 = multi.getFilesystemName(file1);
				String fileName2 = multi.getFilesystemName(file2);
				/*if(fileName2 == null)
				fileName2 = fileName1;
			if(fileName1 == null) 
				fileName1 = fileName2;*/
				fileFindSetter( dataType , dataObject, file1 ,fileName1);
				fileFindSetter( dataType , dataObject, file2 ,fileName2);
			} catch (NoSuchElementException e) {
				String fileName1 = multi.getFilesystemName(file1);
				fileFindSetter( dataType , dataObject, file1 ,fileName1);
			}
		}
		 return dataObject;
	}
	
	private static void fileFindSetter(Class<?> dataType, Object dataObject , String file ,String fileName) throws Exception {
		Method m= null;
		m=findSetter(dataType, file); // fileName과 일치하는 셋터메서드를 찾음
		if(m!= null) {
			//해당 메서드 호출
			m.invoke(dataObject, createValueObject(m.getParameterTypes()[0], fileName));
		}
	}
	
	private static boolean isPrimitiveType(Class<?> type) {
		if (type.getName().equals("int") || type == Integer.class || type.getName().equals("long") || type == Long.class
				|| type.getName().equals("float") || type == Float.class || type.getName().equals("double")
				|| type == Double.class || type.getName().equals("boolean") || type == Boolean.class
				|| type == Date.class || type == String.class) {
			return true;
		}
		return false;
	}

	private static Object createValueObject(Class<?> type, String value) {
		System.out.println("type: "+type+", value : "+value);
		if (type.getName().equals("int") || type == Integer.class) {
			return new Integer(value);
		} else if (type.getName().equals("float") || type == Float.class) {
			return new Float(value);
		} else if (type.getName().equals("double") || type == Double.class) {
			return new Double(value);
		} else if (type.getName().equals("long") || type == Long.class) {
			return new Long(value);
		} else if (type.getName().equals("boolean") || type == Boolean.class) {
			return new Boolean(value);
		} else if (type == Date.class) {
			return java.sql.Date.valueOf(value);
		} else if(type == Timestamp.class){
			return java.sql.Timestamp.valueOf(value);
		}else {
			return value;
		}
	}

	private static Method findSetter(Class<?> type, String name) {

		Method[] methods = type.getMethods();
		String propName = null;
		for (Method m : methods) {
			if (!m.getName().startsWith("set"))
				continue;
			propName = m.getName().substring(3);
			if (propName.toLowerCase().equals(name.toLowerCase())) {
				return m;
			}
		}
		return null;
	}
}
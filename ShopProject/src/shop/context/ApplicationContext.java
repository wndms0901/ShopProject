package shop.context;

import java.io.FileReader;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.Properties;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.reflections.Reflections;

import shop.annotation.Component;


public class ApplicationContext {
Hashtable<String, Object> objTable =new Hashtable<String, Object>();

public Object getBean(String key) {
	System.out.println("getBean(key) : "+key);
	return objTable.get(key);
}

public void addBean(String name, Object obj) { //외부에서 생성한 SqlSessionFactory를 등록
	objTable.put(name, obj);
	}

/*public ApplicationContext (String propertiesPath) throws Exception{ //생성자
	System.out.println("생성자 ------------------");
	System.out.println("propertiesPath : "+propertiesPath);
	Properties props =new Properties();
	props.load(new FileReader(propertiesPath));
	System.out.println("props : "+props);
	prepareObjects(props);
	prepareAnnotationObjects();
	injectDependency();
}*/
public void prepareObjectsByAnnotation(String basePackage) throws Exception{
	Reflections reflector= new Reflections(basePackage);
	
	Set<Class<?>> list = reflector.getTypesAnnotatedWith(Component.class);
	String key = null;
	for(Class<?> clazz : list) {
		key = clazz.getAnnotation(Component.class).value();
		objTable.put(key, clazz.newInstance());
	}
}

public void prepareObjectsByProperties(String propertiesPath) throws Exception{
	Properties props = new Properties();
	props.load(new FileReader(propertiesPath));
	
	Context ctx =new InitialContext();
	String key = null;
	String value = null;
	
	System.out.println("props.keySet : "+props.keySet());
	for(Object item : props.keySet()) {
		key = (String)item;
		System.out.println("key : "+key);
		value= props.getProperty(key);
		System.out.println("value : "+value);
		if(key.startsWith("jndi.")) {
			objTable.put(key, ctx.lookup(value));
			System.out.println("ctx.lookup(value) : "+ctx.lookup(value));
		}else {
			objTable.put(key, Class.forName(value).newInstance());
			System.out.println("Class.forName(value) : " + Class.forName(value));
		}
	}
}
public void injectDependency() throws Exception{
	//생성한 각 객체가 필요로 하는 의존 객체를 할당해줌
	System.out.println("---------------injection");
	System.out.println("objTable.keySet : "+objTable.keySet());
	for(String key : objTable.keySet()) {
		System.out.println("key : "+key );
		if(!key.startsWith("jndi.")) {
			System.out.println("objTable의 key"+key+"객체를 가져옴");
			callSetter(objTable.get(key));
		}
	}
}

private void callSetter(Object obj)throws Exception{
	System.out.println("------------------setter");
	Object dependency = null;
	System.out.println("obj.getClass.getMethods : "+obj.getClass().getMethods());
	for (Method m : obj.getClass().getMethods()) {
		System.out.println("m.getName() : "+m.getName());
		if(m.getName().startsWith("set")) {
			System.out.println("m.getName()메서드의 매개변수타입: "+m.getParameterTypes()[0]);
			dependency = findObjectByType(m.getParameterTypes()[0]);
			if(dependency !=null) {
				m.invoke(obj, dependency);
				System.out.println("set메서드 호출");
			}
		}
	}
}

private Object findObjectByType(Class<?> type) {
	System.out.println("-------------------------findObjectByType");
	System.out.println("type의 class타입 : "+type.getName());
	for(Object obj : objTable.values()) {
		System.out.println("obj의 class타입 : "+obj.getClass().getName());
		if(type.isInstance(obj)) {
			System.out.println("findObjectByType : null값아님");
			return obj;
		}
	}
	System.out.println("findObjectByType : null값");
	return null;
}
}

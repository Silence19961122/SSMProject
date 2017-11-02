/**
 * Created by losil_000 on 2017/10/22.
 * 测试dao层的工作
 * 使用spring的test
 * 1.导入spirng-test
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.
 */

import com.nwx.bean.Department;
import com.nwx.bean.Employee;
import com.nwx.dao.DepartmentMapper;
import com.nwx.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {

/*
* 测试department
*
*
* */
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
//        //1.创建SpringIOC容器
//       ApplicationContext ioc =new ClassPathXmlApplicationContext("applicationContext.xml");
//
//        //从容器中获取bean
//        ioc.getBean(DepartmentMapper.class);
//
//        System.out.println(departmentMapper);

//        1.插入几个部门

//            departmentMapper.insertSelective(new Department(null,"开发部"));
//            departmentMapper.insertSelective(new Department(null,"测试部"));

//        2.插入员工
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@163.com",1));
//        3.批量插入,使用执行批量的sqlSession

        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
         String uid=   UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));
        }
        System.out.println("批量完成");

    }
}

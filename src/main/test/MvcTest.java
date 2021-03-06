import com.github.pagehelper.PageInfo;
import com.nwx.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created by losil_000 on 2017/10/24.
 * 使用spring测试模块测试crud功能
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-mvc.xml"})
public class MvcTest {

    //获取springmvc的ioc容器(需要类加WebAppConfiguration注解)
    @Autowired
    WebApplicationContext context;
    //虚拟Mvc请求
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
       mockMvc= MockMvcBuilders.webAppContextSetup(context).build();

    }

         @Test
        public void testPage() throws Exception {
        //模拟请求拿到返回值
       MvcResult result= mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();

        //请求成功后，请求域中有pageInfo,我们可以取出pageInfo进行验证
            MockHttpServletRequest req=result.getRequest();
           PageInfo attribute= (PageInfo) req.getAttribute("pageInfo");
            System.out.println("当前页码"+attribute.getPageNum());
            System.out.println("总页码: "+attribute.getPages());
            System.out.println("总记录数"+attribute.getTotal());
            System.out.println("在页面需要连续显示的页码 ");
            int[] nums=attribute.getNavigatepageNums();
            for (int i:nums){
                System.out.println(" "+i);
            }


            //获取员工数据
            List<Employee> list = attribute.getList();
            for (Employee e:list){
                System.out.println("ID"+e.getEmpId()+"====>"+e.getEmpName());
            }
        }

}

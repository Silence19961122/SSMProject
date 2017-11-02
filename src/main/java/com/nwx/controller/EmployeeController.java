package com.nwx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.nwx.bean.Employee;
import com.nwx.bean.Msg;
import com.nwx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by losil_000 on 2017/10/23.
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn, HttpServletRequest request, Model model){
        //        引入Page,在查询之前传入页码，以及每页的大小
        PageHelper.startPage(pn,8);
        //startPage后面紧跟的就是分页查询
        List<Employee> emps= employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
        //封装了详细的分页信息，包括我们查询的数据,连续传入5页
        PageInfo pageInfo=new PageInfo(emps,5);
        //model.addAttribute("pageInfo",pageInfo);
      // Cookie cookie= request.getCookies()
        return Msg.success().add("pageInfo",pageInfo);


    }

    /*
   * 查询员工数据(分页查询)
   * @return
   * */
//    //@RequestMapping("/emps")
//    public String  getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
//
//
////        引入Page,在查询之前传入页码，以及每页的大小
//        PageHelper.startPage(pn,8);
//        //startPage后面紧跟的就是分页查询
//      List<Employee> emps= employeeService.getAll();
//      //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
//        //封装了详细的分页信息，包括我们查询的数据,连续传入5页
//        PageInfo pageInfo=new PageInfo(emps,5);
//        model.addAttribute("pageInfo",pageInfo);
//
//        return  "list";
//    }
}

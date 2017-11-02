<%--
  Created by IntelliJ IDEA.
  User: losil_000
  Date: 2017/10/23
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path=request.getContextPath();
%>
<html>
<head>


    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"  rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js" ></script>
    <title>员工列表</title>
</head>
<body>

<div class="container">
    <%--标题--%>
    <div class="row"></div>
        <div class="col-md-12"></div>
        <h1>SSM-CURD</h1>
        <%--按钮--%>
    <div class="row" ></div>
        <div   class="col-md-4 col-md-offset-8">
        <button type="button" class="btn btn-primary ">新增</button>
        <button type="button" class="btn btn-warning " >删除</button>
</div>
        <div class=""></div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" >
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button type="button" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>

                            <button type="button" class="btn btn-warning btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>

                    </tr>

                </c:forEach>


            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前记录数${pageInfo.pageNum}页，总共${pageInfo.pages}页，总共${pageInfo.total}记录数
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                    <a href="/SSM/emps?pn=1">首页</a>
                    </li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${path}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                        <li class="active"><a href="#">${page_Num}</a></li>
                    </c:if>
                        <c:if test="${page_Num!=pageInfo.pageNum}">
                            <li ><a href="/SSM/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>

                    </c:forEach>
                 <c:if test="${pageInfo.hasNextPage}" >
                     <li>
                         <a href="/SSM/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                             <span aria-hidden="true">&raquo;</span>
                         </a>
                     </li>
                 </c:if>

                    <li>
                        <a href="/SSM/emps?pn=${pageInfo.pages}">尾页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>

<%@page pageEncoding="utf-8" %>
<html>
<head>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>


<!-- 添加员工的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--标题--%>
    <div class="row"></div>
    <div class="col-md-12"></div>
    <h1>SSM</h1>
    <%--按钮--%>
    <div class="row" ></div>
    <div   class="col-md-4 col-md-offset-8">
        <button type="button" class="btn btn-primary " id="emp_add_modal_btn">新增</button>
        <button type="button" class="btn btn-warning " >删除</button>
    </div>
    <div class=""></div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>




                </tbody>


            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
        <script type="text/javascript">
            //1页面加载完成后，直接发送ajax请求，要
            //到分页数据
            $(function () {

                to_page(1);
                });


                function build_emps_table(result) {
                //清空table表格
                    $("#emps_table tbody").empty();
                    $("#emp_add_modal_btn").click(function () {
                        $("#empAddModal").modal();

                    });

                    var emps=result.returnMsg.pageInfo.list;
                    $.each(emps,function (index,item) {

                        var empIdTd=$("<td></td>").append(item.empId);
                        var empNameTd=$("<td></td>").append(item.empName);

                        var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
                        var emailTd =$("<td></td>").append(item.email);
                        var deptNameTd=$("<td></td>").append(item.department.deptName);
                        var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm").
                        append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                        .append("编辑");
                        var delBtn=$("<button></button>").addClass("btn btn-warning btn-sm").
                        append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                            .append("删除");
                        var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                      /*  <button type="button" class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                            </button>

                            <button type="button" class="btn btn-warning btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                            </button>  */
                        $("<tr></tr>").append(empIdTd).append(empNameTd)
                            .append(genderTd).append(emailTd).append(deptNameTd)
                            .append(btnTd)
                            .appendTo("#emps_table tbody");
                    })
                }
//                解析显示分页信息
                function build_page_info(result) {
                    $("#page_info_area").empty();
                $("#page_info_area").append("当前记录数 "+result.returnMsg.pageInfo.pageNum+"页，总共"+result.returnMsg.pageInfo.pages+"页，总共"+result.returnMsg.pageInfo.total+"记录数");

                }
//                解析显示分页条数据
                function build_page_nav(result) {
                $("#page_nav_area").empty();
                var ul=$("<ul></ul>").addClass("pagination");

                var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));



                    var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

                if (result.returnMsg.pageInfo.hasPreviousPage==false){
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                }
                else {
                    firstPageLi.click(function () {
                        to_page(1);

                    })
                    prePageLi.click(function () {
                        to_page(result.returnMsg.pageInfo.pageNum -1);

                    })
                }

                var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));

                var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

                if (result.returnMsg.pageInfo.hasNextPage==false){
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                }else {
                    nextPageLi.click(function () {
                        to_page(result.returnMsg.pageInfo.pageNum +1);

                    })
                    lastPageLi.click(function () {
                        to_page(result.returnMsg.pageInfo.pages);

                    })
                }


                    ul.append(firstPageLi).append(prePageLi);
                    $.each(result.returnMsg.pageInfo.navigatepageNums,function (index,item){
                    var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                    if (result.returnMsg.pageInfo.pageNum==item){
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_page(item);
                        }

                    );
                      ul.append(numLi);


                    });
                    ul.append(nextPageLi).append(lastPageLi);
                    var navEle=$("<nav></nav>").append(ul);
                    navEle.appendTo("#page_nav_area");
                }


                function to_page(pn) {
                    $.ajax({
                        url: "/SSM/emps",
                        data: "pn=" + pn,
                        type: "GET",
                        success: function (result) {
                            build_emps_table(result);

                            //1解析员工信息
                            //2解析显示分页信息
                            build_page_info(result);
                            build_page_nav(result);
                        }

                    });
                }






        </script>


    </div>
</div>
</body>


</html>

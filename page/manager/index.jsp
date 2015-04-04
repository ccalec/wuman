<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="bgPower.jsp"/>
<jsp:include page="../allhead.jsp"/>
<jsp:include page="lang.jsp"/>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <meta name="description" content="User login page" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <base target="myframe"></base>
  <!-- cssAssets -->
  <jsp:include page="cssAssets.jsp"/>
  <!-- /cssAssets -->
</head>
<body class="skin-1">

<!-- header -->
<jsp:include page="header.jsp"/>
<!-- /header -->

<div class="navbar">
  <div class="navbar-inner">
    <div class="container-fluid">
      <a href="#" class="brand">
        <small> <i class="icon-flag"></i>
          ${title}
        </small>
      </a>
      <!--/.brand-->
      <ul class="nav ace-nav pull-right">
        <li class="light-blue">
          <a href="../adminUserPage/logout.jsp"> <i class="icon-exclamation-sign"></i>
            ${logout}
          </a>
        </li>
      </ul>
      <!--/.ace-nav-->
    </div>
    <!--/.container-fluid-->
  </div>
  <!--/.navbar-inner-->
</div>

<div class="main-container container-fluid">
  <!-- leftMenu -->
  <jsp:include page="leftMenu.jsp"/>
  <!-- /leftMenu -->

  <!--PAGE CONTENT BEGINS HERE-->
  <!-- ====================== -->
  <div class="main-content">
    <div id="breadcrumbs" class="breadcrumbs">
      <ul class="breadcrumb">
        <li> <i class="icon-home home-icon"></i>
          <a href="javascript:void(0);">${pre_welcome}</a>
          <span class="divider"> <i class="icon-angle-right arrow-icon"></i>
          </span>
        </li>
        <li class="active">
          ${welcome}
        </li>
      </ul>
      <!--.breadcrumb-->

      <div id="nav-search" class="nav-search">
        <form class="form-search">
          <span class="input-icon">
            <input type="text" autocomplete="off" id="nav-search-input" class="input-small nav-search-input" placeholder="Search ...">
            <i class="icon-search nav-search-icon"></i>
          </span>
        </form>
      </div>
      <!--#nav-search-->
    </div>

    <div class="page-content clearfix">
      <iframe name="myframe" id="ifr" src="CMSMgr.jsp?alias=administrator&norole=true" width="100%" height="400" scrolling-y="yes" frameborder="0"></iframe>
    </div>
  </div>
  <!-- ====================== -->
  <!--PAGE CONTENT ENDS HERE-->

</div>
<!--/.main-container-->

<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-small btn-inverse">
<i class="icon-double-angle-up icon-only bigger-110"></i>
</a>

<!-- footer -->
<jsp:include page="footer.jsp"/>
<!-- /footer -->

<!-- wgfly breeze -->
<script type="text/javascript">
  // 计算页面的实际高度，iframe自适应会用到
  var height = $(window).height();
  $('#ifr').height(height-117);
  // hash初始化
  var hash = document.location.hash.replace('#','');
  if(hash){
    $('#ifr').attr('src',hash);
  }
  // 点击带hash
  $("a").on('click',function(){
    var href = $(this).attr('href');
    document.location.hash = href;
  })
  //高亮展开显示当前菜单
  $("#sidebar").find("li a").each(function(){
    if($(this).attr("href")===hash){
      $(this).parent().addClass("open");
      $(this).parents("li").addClass("active");
    }
  });
  $("#sidebar li a").not('.dropdown-toggle').click(function(){
    $("#sidebar li, #sidebar li a").removeClass('active').removeClass('open');
    $(this).parent().addClass("open");
    $(this).parents("li").addClass("active").remove("open");
  })

</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<a class="menu-toggler" id="menu-toggler" href="#">
	<span class="menu-text"></span>
</a>
<div class="sidebar" id="sidebar">
	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
			<button class="btn btn-small btn-success"> <i class="icon-signal"></i>
			</button>

			<button class="btn btn-small btn-info"> <i class="icon-pencil"></i>
			</button>

			<button class="btn btn-small btn-warning">
				<i class="icon-group"></i>
			</button>

			<button class="btn btn-small btn-danger">
				<i class="icon-cogs"></i>
			</button>
		</div>

		<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span>

			<span class="btn btn-info"></span>

			<span class="btn btn-warning"></span>

			<span class="btn btn-danger"></span>
		</div>
	</div>
	<!--#sidebar-shortcuts-->

	<ul class="nav nav-list">
		<li>
			<a href="${B}page/manager/channelMgr.jsp?norole=true&nodeid=3">
				<i class="icon-bar-chart"></i>
				<span class="menu-text">数据模型管理</span>
			</a>
		</li>
		<!-- <li>
			<a href="${B}page/manager/system.jsp?norole=true">
				<i class="icon-cogs"></i>
				<span class="menu-text">未用</span>
			</a>
		</li> -->
		<li>
			<a href="${B}page/manager/CMSMgr.jsp?alias=administrator&norole=true">
				<i class="icon-user"></i>
				<span class="menu-text">管理员管理<span class="badge badge-primary ">4</span></span>
			</a>
		</li>
		<li>
			<a href="${B}page/manager/CMSMgr.jsp?alias=user&norole=true">
				<i class="icon-group"></i>
				<span class="menu-text">会员管理<span class="badge badge-primary ">4</span></span>
			</a>
		</li>


		<li actionNamea="查询类目管理@cms.queryContent" style="display:none~;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-dashboard"></i>
				<span class="menu-text">类目管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li  actionNamea="查询类目管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=category&norole=true">
						<i class="icon-double-angle-right"></i>
						类目列表
					</a>
				</li>
				<li actionNamea="查询商品管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=category_properties&norole=true">
						<i class="icon-double-angle-right"></i>
						类目属性设置
					</a>
				</li>
			</ul>
		</li>

		<li actionNamea="查询商品管理@cms.queryContent" style="display:none~;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-gift"></i>
				<span class="menu-text">宝贝管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li  actionNamea="查询商品类目管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/goods_mgr.jsp?norole=true">
						<i class="icon-double-angle-right"></i>
						宝贝入库
					</a>
				</li>
				<li actionNamea="查询商品管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/goods_list.jsp?norole=true">
						<i class="icon-double-angle-right"></i>
						仓库中的宝贝
					</a>
				</li>
			</ul>
		</li>

		<!-- <li actionNamea="查询订单管理@cms.queryContent" style="display:none~;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-gift"></i>
				<span class="menu-text">订单管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li  actionNamea="查询订单类目管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/orders_list.jsp?norole=true">
						<i class="icon-double-angle-right"></i>
						订单列表
					</a>
				</li>
				<li actionNamea="查询订单管理@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/orders_list.jsp?norole=true">
						<i class="icon-double-angle-right"></i>
						退款申请
					</a>
				</li>
			</ul>
		</li> -->

		<li>
			<a href="${B}page/manager/orders_list.jsp?norole=true">
				<i class="icon-gift"></i>
				<span class="menu-text">
					订单管理
				</span>
			</a>
		</li>
		<li>
			<a href="${B}page/manager/CMSMgr.jsp?alias=feedback&norole=true">
				<i class="icon-comments"></i>
				<span class="menu-text">
					用户反馈管理
				</span>
			</a>
		</li>
		<li>
			<a href="${B}page/manager/activities_mgr.jsp?norole=true">
				<i class="icon-flag"></i>
				<span class="menu-text">
					活动管理
				</span>
			</a>
		</li>
		<li>
			<a href="${B}page/manager/CMSMgr.jsp?alias=activities&norole=true">
				<i class="icon-flag"></i>
				<span class="menu-text">
					活动列表
				</span>
			</a>
		</li>
		<li actionNamea="查询角色权限@cms.queryContent" style="display:none~;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-puzzle-piece"></i>
				<span class="menu-text">权限设置管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li actionNamea="查询角色权限@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=roles&norole=true">
						<i class="icon-double-angle-right"></i>
						角色权限管理
					</a>
				</li>
				<li  actionNamea="查询权限定义@cms.queryContent" style="display:none~;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=action&norole=true">
						<i class="icon-double-angle-right"></i>
						权限定义管理
					</a>
				</li>
			</ul>
		</li>
	</ul>
	<!--/.nav-list-->

	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left"></i>
	</div>
</div>
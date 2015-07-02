
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<a class="menu-toggler" id="menu-toggler" href="#">
	<span class="menu-text"></span>
</a>
<div class="sidebar" id="sidebar">
	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
			<button class="btn btn-small btn-success"> <i class="icon-signal"></i></button>
			<button class="btn btn-small btn-info"> <i class="icon-pencil"></i></button>
			<button class="btn btn-small btn-warning"> <i class="icon-group"></i></button>
			<button class="btn btn-small btn-danger"> <i class="icon-cogs"></i></button>
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
			<a href="${B}page/manager/total.jsp">
				<i class="icon-dashboard"></i>
				数据统计
			</a>
		</li>
		<li actionName="查询数据模型@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/channelMgr.jsp?nodeid=3">
				<i class="icon-inbox"></i>
				<span class="menu-text">模型管理</span>
			</a>
		</li>
		<li actionName="查询管理员管理@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/CMSMgr.jsp?alias=administrator">
				<i class="icon-group"></i>
				<span class="menu-text">管理员管理<!-- <span class="badge badge-primary">4</span> --></span>
			</a>
		</li>
		<li actionName="查询会员管理@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/CMSMgr.jsp?alias=user">
				<i class="icon-user"></i>
				<span class="menu-text">会员管理<!-- <span class="badge badge-primary">4</span> --></span>
			</a>
		</li>
		<li actionName="查询商品类目管理@cms.queryContent" style="display:none;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-list"></i>
				<span class="menu-text">类目管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li actionName="查询商品类目管理@cms.queryContent" style="display:none;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=category">
						<i class="icon-double-angle-right"></i>
						类目列表
					</a>
				</li>
				<li actionName="查询类目属性管理@cms.queryContent" style="display:none;">
					<a href="${B}page/manager/CMSMgr.jsp?alias=category_properties">
						<i class="icon-double-angle-right"></i>
						类目属性设置
					</a>
				</li>
			</ul>
		</li>

		<li actionName="查询商品管理@cms.queryContent" style="display:none;">
			<a href="#" class="dropdown-toggle">
				<i class="icon-gift"></i>
				<span class="menu-text">宝贝管理</span>
				<b class="arrow icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li  actionName="查询商品管理@cms.queryContent" style="display:none;">
					<a href="${B}page/manager/goods_mgr.jsp">
						<i class="icon-double-angle-right"></i>
						宝贝入库
					</a>
				</li>
				<li actionName="查询商品管理@cms.queryContent" style="display:none;">
					<a href="${B}page/manager/goods_list.jsp">
						<i class="icon-double-angle-right"></i>
						仓库中的宝贝
					</a>
				</li>
			</ul>
		</li>
		<li actionName="查询订单管理@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/orders_list.jsp">
				<i class="icon-file-alt"></i>
				<span class="menu-text">
					订单管理
				</span>
			</a>
		</li>
		<li actionName="查询活动管理@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/CMSMgr.jsp?alias=activities">
				<i class="icon-flag"></i>
				<span class="menu-text">
					活动管理
				</span>
			</a>
		</li>
		<li actionName="查询用户反馈管理@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/CMSMgr.jsp?alias=feedback">
				<i class="icon-comments"></i>
				<span class="menu-text">
					反馈管理
				</span>
			</a>
		</li>
		<li actionName="查询角色权限@cms.queryContent" style="display:none;">
			<a href="${B}page/manager/CMSMgr.jsp?alias=roles">
				<i class="icon-puzzle-piece"></i>
				权限管理
			</a>
		</li>
	</ul>
	<!--/.nav-list-->

	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left"></i>
	</div>
</div>
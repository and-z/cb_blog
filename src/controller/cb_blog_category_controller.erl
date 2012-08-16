-module(cb_blog_category_controller, [Req]).
-compile(export_all).

view('GET', []) ->
	Categories = boss_db:find(category, []),
	{ok, [{categories, Categories}]}.

create('GET', []) ->
	ok;
create('POST', []) ->
	CategoryName = Req:post_param("category_name"),
	Category = category:new('id', CategoryName),
	Category:save(),
	{redirect, [{action, "view"}]}.
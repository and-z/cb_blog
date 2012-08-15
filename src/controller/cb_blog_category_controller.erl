-module(cb_blog_category_controller, [Req]).
-compile(export_all).

list('GET', []) ->
	Categories = boss_db:find(category, []),
	{ok, [{categories, Categories}]}.

create('GET', []) ->
	ok;
create('POST', []) ->
	Name = Req:post_param("category_name"),
	Category = category:new('id', Name),
	Category:save(),
	{redirect, [{action, "list"}]}.
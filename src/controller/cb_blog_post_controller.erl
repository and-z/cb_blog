-module(cb_blog_post_controller, [Req]).
-compile(export_all).

view('GET', []) ->
	Posts = boss_db:find(post, []),
	{ok, [{posts, Posts}]};
view('GET', [Id]) ->
	case boss_db:find(Id) of
		Post ->
	 		{ok, [{posts, [Post|[]]}]};
	 	{error, Reason} ->
	 		error
	 end.

create('GET', []) ->
	Categories = boss_db:find(category, []),
	{ok, [{categories, Categories}]};
create('POST', []) ->
	PostTitle = Req:post_param("post_title"),
	PostText = Req:post_param("post_text"),
	PostAuthor = Req:post_param("post_author"),
	CategoryId = Req:post_param("category_id"),
	Post = post:new(id, CategoryId, PostTitle, PostText, PostAuthor, erlang:now()),
	case Post:save() of
		{ok, SavedPost} ->
			{redirect, [{action, "view"}]};
		{error, ErrorList} ->
			error
	end.

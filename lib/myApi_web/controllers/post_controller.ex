defmodule MyApiWeb.PostController do
  use MyApiWeb, :controller

  alias MyApi.Posts
  alias MyApi.Posts.Post
  alias MyApi.Guardian

  action_fallback MyApiWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  defp get_post_params_with_user(conn, post_params) do
    user = Guardian.Plug.current_resource(conn)
    %{:id => id} = user
    Map.put(post_params, "user_id", id)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Posts.create_post(get_post_params_with_user(conn, post_params)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = post} <- Posts.update_post(post, get_post_params_with_user(conn, post_params)) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end

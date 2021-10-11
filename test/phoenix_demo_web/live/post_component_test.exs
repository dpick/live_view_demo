defmodule PhoenixDemoWeb.PostLive.PostComponentTest do
  use PhoenixDemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixDemo.TimelineFixtures

  alias PhoenixDemo.Timeline

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end

  describe "Post Component" do
    setup [:create_post]

    test "liking a post", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, Routes.post_index_path(conn, :index))

      index_live |> element("#post-#{post.id} a", "💟") |> render_click()

      post = Timeline.get_post!(post.id)

      assert post.likes_count == 1
    end

    test "reposting a post", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, Routes.post_index_path(conn, :index))

      index_live |> element("#post-#{post.id} a", "🔄") |> render_click()

      post = Timeline.get_post!(post.id)

      assert post.reposts_count == 1
    end

    test "deleting a post", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, Routes.post_index_path(conn, :index))

      index_live |> element("#post-#{post.id} a", "❌") |> render_click()

      assert Timeline.get_post(post.id) == nil
    end
  end
end

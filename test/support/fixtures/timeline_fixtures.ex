defmodule PhoenixDemo.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixDemo.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        likes_count: 0,
        reposts_count: 0,
        username: "some username"
      })
      |> PhoenixDemo.Timeline.create_post()

    post
  end
end

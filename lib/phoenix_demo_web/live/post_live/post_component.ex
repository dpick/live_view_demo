defmodule PhoenixDemoWeb.PostLive.PostComponent do
  use PhoenixDemoWeb, :live_component

  def render(assigns) do
    deleted =
      if assigns.post.__meta__.state == :deleted do
        "hidden"
      else
        ""
      end

    ~H"""
      <div id={"post-#{@post.id}"} class={"post #{deleted}"}>
        <div class="row">
          <div class="column column-10">
            <div class="post-avatar"></div>
          </div>
          <div class="column column-90 post-body">
            <b>@<%= @post.username %></b>
            <br/>
            <%= @post.body %>
          </div>
        </div>

        <div class="row actions_bar">
          <div class="column column-33 text-center">
            <a href="#" phx-click="like" phx-target={@myself}>
              <span>💟</span> <%= @post.likes_count %>
            </a>
          </div>
          <div class="column column-33 text-center">
            <a href="#" phx-click="repost" phx-target={@myself}>
              <span>🔄</span> <%= @post.reposts_count %>
            </a>
          </div>
          <div class="column column-33 text-center">
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
              <span>✏️</span>
            <% end %>
            <span>&nbsp;&nbsp;</span>
            <a href="#" phx-click="delete" phx-target={@myself}>
              <span>❌</span>
            </a>
          </div>
        </div>
      </div>
    """
  end

  def handle_event("like", _, socket) do
    PhoenixDemo.Timeline.increment_likes(socket.assigns.post)

    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    PhoenixDemo.Timeline.increment_reposts(socket.assigns.post)

    {:noreply, socket}
  end

  def handle_event("delete", _, socket) do
    {:ok, _} = PhoenixDemo.Timeline.delete_post(socket.assigns.post)

    {:noreply, socket}
  end
end

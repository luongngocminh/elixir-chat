defmodule ChatWeb.PageController do
  use ChatWeb, :controller

  alias Chat.Chats

  def index(conn, _params) do
    # changeset = User.changeset(%User{})
    render(conn, "landing.html")
  end

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    messages = Chats.list_messages()
    render(conn, "index.html", messages: messages, current_user: user)
  end
end

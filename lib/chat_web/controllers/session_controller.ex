defmodule ChatWeb.SessionController do
  use ChatWeb, :controller
  require Logger
  alias Chat.{Accounts, Accounts.User, Accounts.Guardian}

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    Logger.debug("Function #{inspect(maybe_user)}")
    if maybe_user do
      redirect(conn, to: "/protected")
    else
      render(conn, "login.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  @spec login(Plug.Conn.t(), map) :: Plug.Conn.t()
  def login(conn, %{"user" => %{"name" => name, "password" => password}}) do
    Accounts.authenticate_user(name, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out() #This module's full name is Auth.Accounts.Guardian.Plug,
    |> redirect(to: "/login")   #and the arguments specfied in the Guardian.Plug.sign_out()
  end                           #docs are not applicable here

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)   #This module's full name is Auth.Accounts.Guardian.Plug,
    |> redirect(to: "/protected")    #and the arguments specified in the Guardian.Plug.sign_in()
  end                                #docs are not applicable here.

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end

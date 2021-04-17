defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               address: "Rua Endereço, 25",
               age: 30,
               cep: "18080800",
               cpf: "00987654321",
               email: "person@person.com",
               id: "a6e2b0ff-3f64-44d7-bbbc-5364e6612980",
               inserted_at: nil,
               name: "Person",
               password: "personword",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end

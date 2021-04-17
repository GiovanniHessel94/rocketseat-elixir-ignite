defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      address: "Rua Endereço, 25",
      age: 30,
      cep: "18080800",
      cpf: "00987654321",
      email: "person@person.com",
      password: "personword",
      name: "Person"
    }
  end

  def user_factory do
    %User{
      id: "a6e2b0ff-3f64-44d7-bbbc-5364e6612980",
      address: "Rua Endereço, 25",
      age: 30,
      cep: "18080800",
      cpf: "00987654321",
      email: "person@person.com",
      password: "personword",
      name: "Person"
    }
  end
end

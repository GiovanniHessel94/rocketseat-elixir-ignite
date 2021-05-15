defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Rua Endereço, 25",
      "age" => 30,
      "cep" => "01001000",
      "cpf" => "00987654321",
      "email" => "person@person.com",
      "password" => "personword",
      "name" => "Person"
    }
  end

  def user_factory do
    %User{
      id: "a6e2b0ff-3f64-44d7-bbbc-5364e6612980",
      address: "Rua Endereço, 25",
      age: 30,
      cep: "01001000",
      cpf: "00987654321",
      email: "person@person.com",
      password: "personword",
      name: "Person"
    }
  end

  def cpf_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end

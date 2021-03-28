defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{name: name, cpf: cpf, email: email, address: address, age: age}) do
    name
    |> User.build(cpf, email, address, age)
    |> save_user()
  end

  def call(_params), do: {:error, "Invalid parameters"}

  defp save_user({:ok, user}) do
    UserAgent.save(user)

    {:ok, "User created or updated successfully"}
  end

  defp save_user({:error, _reason} = error), do: error
end

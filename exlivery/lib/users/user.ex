defmodule Exlivery.Users.User do
  @keys [:name, :cpf, :email, :address, :age]

  @enforce_keys @keys

  defstruct @keys

  def build(name, cpf, email, address, age) when age >= 18 and is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       name: name,
       cpf: cpf,
       email: email,
       address: address,
       age: age
     }}
  end

  def build(_name, _cpf, _email, _address, _age), do: {:error, "Invalid parameters"}
end

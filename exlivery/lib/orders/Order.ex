defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: user_cpf, address: delivery_address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: user_cpf,
       delivery_address: delivery_address,
       items: items,
       total_price: calculate_price(items)
     }}
  end

  def build(_users, _items), do: {:error, "Invalid parameters"}

  defp calculate_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_values/2)
  end

  defp sum_values(%Item{unity_price: unity_price, quantity: quantity}, acc) do
    unity_price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end

defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Rua das Bananeiras",
      age: 27,
      cpf: "12345678900",
      email: "Hessel@Hessel.com",
      name: "Hessel"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperoni",
      category: :pizza,
      unity_price: Decimal.new("50.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua das Bananeiras",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("25.5")
        )
      ],
      total_price: Decimal.new("101.50"),
      user_cpf: "12345678900"
    }
  end
end

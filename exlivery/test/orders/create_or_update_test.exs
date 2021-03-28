defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      user = build(:user)

      Exlivery.start_links()

      UserAgent.save(user)

      item1 = %{
        description: "Panda Supreme",
        category: :hamburguer,
        unity_price: 35.99,
        quantity: 1
      }

      item2 = %{
        description: "Panda Onion",
        category: :hamburguer,
        unity_price: 30.99,
        quantity: 1
      }

      item3 = %{
        description: "Pizza de peperoni",
        category: :pizza,
        unity_price: 48.50,
        quantity: 1
      }

      {:ok, cpf: user.cpf, item1: item1, item2: item2, item3: item3}
    end

    test "when all params are valid, saves the order", %{
      cpf: cpf,
      item1: item1,
      item2: item2,
      item3: item3
    } do
      response = CreateOrUpdate.call(%{user_cpf: cpf, items: [item1, item2, item3]})

      assert {:ok, _uuid} = response
    end

    test "when the user is not found, returns an error", %{
      item1: item1,
      item2: item2,
      item3: item3
    } do
      response = CreateOrUpdate.call(%{user_cpf: "11111111111", items: [item1, item2, item3]})

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when there is an invalid item, returns an error", %{
      cpf: cpf,
      item1: item1,
      item2: item2,
      item3: item3
    } do
      response =
        CreateOrUpdate.call(%{user_cpf: cpf, items: [item1, item2, %{item3 | quantity: 0}]})

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "when there is no items, returns an error", %{
      cpf: cpf
    } do
      response = CreateOrUpdate.call(%{user_cpf: cpf, items: []})

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end

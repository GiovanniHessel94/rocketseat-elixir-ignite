defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      user_params = %{
        name: "Hessel",
        cpf: "12345678900",
        email: "hessel@hessel.com",
        address: "Rua Hessel",
        age: 35
      }

      response = CreateOrUpdate.call(user_params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      user_params = %{
        name: "Hessel",
        cpf: "12345678900",
        email: "hessel@hessel.com",
        address: "Rua Hessel",
        age: 10
      }

      response = CreateOrUpdate.call(user_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there are missing params, returns an error" do
      user_params = %{
        cpf: "12345678900",
        email: "hessel@hessel.com",
        address: "Rua Hessel",
        age: 35
      }

      response = CreateOrUpdate.call(user_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end

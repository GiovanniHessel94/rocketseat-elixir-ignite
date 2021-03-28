defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns an user" do
      response =
        User.build(
          "Hessel",
          "12345678900",
          "Hessel@Hessel.com",
          "Rua das Bananeiras",
          27
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "Hessel Jr",
          "12345678900",
          "Hessel@Hessel.com",
          "Rua das Bananeiras",
          15
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end

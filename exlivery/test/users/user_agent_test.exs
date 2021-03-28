defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  describe "save/1" do
    test "when receive an user, saves it in the agent" do
      user = build(:user)

      UserAgent.start_link(%{})

      response = UserAgent.save(user)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      user = build(:user)

      UserAgent.start_link(%{})

      UserAgent.save(user)

      {:ok, user: user}
    end

    test "when the user is found, returns the user", %{user: user} do
      response = UserAgent.get(user.cpf)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("11111111111")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end

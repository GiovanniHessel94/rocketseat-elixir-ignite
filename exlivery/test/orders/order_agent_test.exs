defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  describe "save/1" do
    test "when receive an order, saves it in the agent" do
      order = build(:order)

      OrderAgent.start_link(%{})

      response = OrderAgent.save(order)

      assert {:ok, _uuid} = response
    end
  end

  describe "get/1" do
    setup do
      order = build(:order)

      OrderAgent.start_link(%{})

      {:ok, uuid} = OrderAgent.save(order)

      {:ok, uuid: uuid, order: order}
    end

    test "when the order is found, returns the order", %{uuid: uuid, order: order} do
      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("11111111111")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end

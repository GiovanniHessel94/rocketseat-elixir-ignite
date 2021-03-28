defmodule Exlivery.Orders.Agent do
  use Agent

  alias Exlivery.Orders.Order

  def start_link(__initial_state), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, uuid, order))

    {:ok, uuid}
  end

  def get(uudi), do: Agent.get(__MODULE__, &get_order(&1, uudi))

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp get_order(state, uudi) do
    case Map.get(state, uudi) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  defp update_state(state, uudi, %Order{} = order), do: Map.put(state, uudi, order)
end

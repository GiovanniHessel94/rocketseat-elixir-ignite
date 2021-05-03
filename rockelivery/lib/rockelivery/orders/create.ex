defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  def call(%{"items" => items_params} = params) do
    items_ids = Enum.map(items_params, & &1["id"])

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
    |> handle_items(params)
  end

  defp handle_items({:error, reason}, _params), do: {:error, Error.build(:bad_request, reason)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result
  defp handle_insert({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end

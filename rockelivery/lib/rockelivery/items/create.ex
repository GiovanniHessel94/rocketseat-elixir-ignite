defmodule Rockelivery.Items.Create do
  alias Ecto.Changeset
  alias Rockelivery.{Error, Item}
  alias Rockelivery.Repo

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:error, %Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end

  defp handle_insert({:ok, %Item{}} = result), do: result
end

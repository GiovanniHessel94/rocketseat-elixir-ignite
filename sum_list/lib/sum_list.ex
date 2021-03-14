defmodule SumList do
  def call(list) when is_list(list) do
    result =
      list
      |> sum(0)

    {:ok, result}
  end

  def call(_list), do: {:error, "Please provide a list of integers"}

  defp sum([], acc), do: acc

  defp sum([head | tail], acc), do: sum(tail, acc + head)
end

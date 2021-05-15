defmodule Rockelivery.ViaCep.Behavior do
  alias Rockelivery.Error

  @callback get_cep_info(String.t()) :: {:ok, Map.t()} | {:error, Error.t()}
end

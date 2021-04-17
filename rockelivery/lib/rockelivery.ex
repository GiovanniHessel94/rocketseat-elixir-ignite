defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: CreateUser
  alias Rockelivery.Users.Delete, as: DeleteUser
  alias Rockelivery.Users.Get, as: GetUser
  alias Rockelivery.Users.Update, as: UpdateUser

  defdelegate create_user(param), to: CreateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate update_user(params), to: UpdateUser, as: :call
end

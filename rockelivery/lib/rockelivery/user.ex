defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @required_params [
    :password,
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :name
  ]

  @update_required_params @required_params -- [:password]

  @derive {Jason.Encoder, only: [:id, :address, :age, :cpf, :email]}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    has_many :orders, Order

    timestamps()
  end

  def build(%Changeset{} = changeset), do: apply_action(changeset, :create)

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> do_changeset(@required_params)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @required_params)
    |> do_changeset(@update_required_params)
  end

  defp do_changeset(changeset, required_params) do
    changeset
    |> validate_required(required_params)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_password_length()
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:cpf])
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp validate_password_length(%Changeset{changes: %{password: _password}} = changeset) do
    validate_length(changeset, :password, min: 6)
  end

  defp validate_password_length(changeset), do: changeset

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end

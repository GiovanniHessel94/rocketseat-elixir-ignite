defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Person"}, valid?: true} = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params =
        build(:user_params, %{
          "age" => 11,
          "cep" => "1808080000",
          "cpf" => "987654321",
          "password" => "word"
        })

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      update_params = %{
        email: "personjr@person.com",
        name: "Person Jr"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{
               changes: %{
                 name: "Person Jr",
                 email: "personjr@person.com"
               },
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = build(:user_params)

      update_params = %{
        email: "personjr@person.com",
        name: "Person Jr",
        password: "123"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      expected_response = %{password: ["should be at least 6 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end
end

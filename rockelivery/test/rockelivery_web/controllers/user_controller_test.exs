defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock

  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates an user", %{conn: conn} do
      params = %{
        "address" => "Rua Endereço, 25",
        "age" => 30,
        "cep" => "18080800",
        "cpf" => "00987654321",
        "email" => "person@person.com",
        "password" => "personword",
        "name" => "Person"
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cpf_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua Endereço, 25",
                 "age" => 30,
                 "cpf" => "00987654321",
                 "email" => "person@person.com",
                 "id" => _id
               }
             } = response
    end

    test "when there are some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "personword",
        "name" => "Person"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "bearer #{token}")

      {:ok, conn: conn}
    end

    test "when there is an user with the given id, deletes the user", %{conn: conn} do
      id = "a6e2b0ff-3f64-44d7-bbbc-5364e6612980"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end
  end
end

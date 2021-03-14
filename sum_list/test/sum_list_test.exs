defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "when a list of integers is provided, it must return the sum of its values" do
      list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

      response =
        list
        |> SumList.call()

      expected_response = {:ok, 55}

      assert response == expected_response
    end

    test "when a list is not provided, it must return an error" do
      not_a_list = "OPS"

      response =
        not_a_list
        |> SumList.call()

      expected_response = {:error, "Please provide a list of integers"}

      assert response == expected_response
    end
  end
end

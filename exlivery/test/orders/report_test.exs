defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      {:ok, response} = File.read("report_test.csv")

      expected_response =
        "12345678900,Pizza de peperoni,pizza,50.5,1Temaki de atum,japonesa,25.5,2,101.50\n" <>
          "12345678900,Pizza de peperoni,pizza,50.5,1Temaki de atum,japonesa,25.5,2,101.50\n"

      assert response == expected_response
    end
  end
end

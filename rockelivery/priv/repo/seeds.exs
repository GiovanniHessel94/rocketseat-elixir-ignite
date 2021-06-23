# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

user = %User{
  address: "Rua dos limões, 999",
  age: 45,
  cep: "18075480",
  cpf: "91335800069",
  email: "pessoasr@email.com",
  password: "bananeiras",
  name: "Pessoa Sr."
}

%User{id: user_id} = Repo.insert!(user)

item1 = %Item{
  category: :food,
  description: "banana frita",
  price: Decimal.new("14.99"),
  photo: "/priv/photos/banana_frita.png"
}

item2 = %Item{
  category: :food,
  description: "banana cozida",
  price: Decimal.new("9.99"),
  photo: "/priv/photos/banana_cozida.png"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item2, item2],
  address: "Rua dos limões, 999",
  comments: "sem canela",
  payment_method: :money
}

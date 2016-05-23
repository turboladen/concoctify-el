ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Concoctify.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Concoctify.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Concoctify.Repo)


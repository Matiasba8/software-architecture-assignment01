defmodule Assignment01.Repo do
  use Ecto.Repo,
    otp_app: :assignment_01,
    adapter: Ecto.Adapters.Postgres
end

defmodule Assignment01.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Assignment01Web.Telemetry,
      # Start the Ecto repository
      Assignment01.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Assignment01.PubSub},
      # Start Finch
      {Finch, name: Assignment01.Finch},
      # Start the Endpoint (http/https)
      Assignment01Web.Endpoint
      # Start a worker by calling: Assignment01.Worker.start_link(arg)
      # {Assignment01.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Assignment01.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Assignment01Web.Endpoint.config_change(changed, removed)
    :ok
  end
end

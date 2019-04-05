defmodule Scraper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp poolboy_config do
    [{:name, {:local, :worker}}, {:worker_module, Scraper.Worker}, {:size, 5}, {:max_overflow, 0}]
  end

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Scraper.Repo,
      # Start the endpoint when the application starts
      ScraperWeb.Endpoint,
      # Starts a worker by calling: Scraper.Worker.start_link(arg)
      # {Scraper.Worker, arg},
      :poolboy.child_spec(:worker, poolboy_config, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ScraperWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

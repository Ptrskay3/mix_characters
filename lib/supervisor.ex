defmodule Csv.Supervisor do
  use Supervisor

  @impl true
  def init(_state) do
    children = [
      Csv.Server
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule Csv.Server do
  use GenServer

  # Client API

  def start_link(file \\ "./static/characters.csv") do
    state = Csv.get_file(file) |> Csv.parse()
    GenServer.start_link(__MODULE__, state)
  end

  def heaviest(pid) do
    GenServer.call(pid, :heaviest)
  end

  # Server API

  @impl true
  def init(rows) do
    {:ok, rows}
  end

  @impl true
  def handle_call(:heaviest, _from, state) do
    {:reply, state, state}
  end
end

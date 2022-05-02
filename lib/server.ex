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

  def average_height_by(pid, :female) do
    GenServer.call(pid, {:avg_height, :female})
  end

  def average_height_by(pid, :male) do
    GenServer.call(pid, {:avg_height, :male})
  end

  def distribution_by_age(pid) do
    GenServer.call(pid, :age_distribution)
  end

  # Server API

  @impl true
  def init(rows) do
    {:ok, rows}
  end

  @impl true
  def handle_call(:heaviest, _from, state) do
    {name, mass} = Csv.Math.heaviest(state)
    {:reply, "The heaviest is #{name}, with #{mass}!", state}
  end

  @impl true
  def handle_call({:avg_height, :female}, _from, state) do
    avg = Csv.Math.average_height_by_gender(state, "female")
    {:reply, "The average height among females is #{avg}!", state}
  end

  @impl true
  def handle_call({:avg_height, :male}, _from, state) do
    avg = Csv.Math.average_height_by_gender(state, "male")
    {:reply, "The average height among males is #{avg}!", state}
  end

  @impl true
  def handle_call(:age_distribution, _from, state) do
    stats = Csv.Math.distribution_by_age(state)
    {:reply, stats, state}
  end
end

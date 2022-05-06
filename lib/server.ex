defmodule Csv.Server do
  use GenServer

  # Client API

  def heaviest() do
    GenServer.call(__MODULE__, :heaviest)
  end

  def average_height_by(:female) do
    GenServer.call(__MODULE__, {:avg_height, :female})
  end

  def average_height_by(:male) do
    GenServer.call(__MODULE__, {:avg_height, :male})
  end

  def distribution_by_age() do
    GenServer.call(__MODULE__, :age_distribution)
  end

  def rows() do
    GenServer.call(__MODULE__, :rows)
  end

  # Server API

  @impl true
  def init(rows) do
    {:ok, rows}
  end

  def start_link(args) do
    state = File.read!(args) |> Csv.Parse.parse()
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
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

  @impl true
  def handle_call(:rows, _from, state) do
    {:reply, state, state}
  end
end

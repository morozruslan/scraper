defmodule Scraper.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:scrape, url}, _from, state) do
    :io.format("Pid ~p processing ~p~n",[inspect(self), url])
    info = Scraper.scrap(url)
    :io.format("Page ~p info:~p~n",[url, info])
    {:reply, info, state}
  end

  def handle_call(call, _from, state) do
    :io.format("Undefined call:~p~n",[call])
    {:reply, :error, state}
  end
end

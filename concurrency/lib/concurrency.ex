defmodule Concurrency do
  def run_query(q) do
    :timer.sleep(2000)
    "Finished #{q}"
  end

  def async_query(q) do
    spawn(fn() -> IO.puts(run_query(q)) end)
  end

  def async_queries do
    Enum.each(1..5, &async_query(&1))
  end

  def async_query(q, caller) do
    spawn(fn() -> send(caller, {:query_result, run_query(q)}) end)
  end
end

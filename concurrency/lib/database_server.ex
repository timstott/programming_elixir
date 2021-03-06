defmodule DatabaseServer do
  def start do
    spawn(fn() ->
      connection = :rand.uniform(1000)
      loop(connection)
    end)
  end

  def loop(connection) do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(connection, query_def)})
    end
    loop(connection)
  end

  defp run_query(connection, query_def) do
    :timer.sleep(2000)
    "Connection #{connection} | Result #{query_def}"
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      {:query_result, result} -> IO.puts result
    after 5000 ->
        {:error, :timeout}
    end
  end
end

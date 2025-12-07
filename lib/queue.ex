defmodule AOC.Queue do
  def new(), do: :queue.new()
  def push(queue, item), do: :queue.in(item, queue)

  def pop(queue) do
    case :queue.out(queue) do
      {{:value, item}, new_queue} -> {item, new_queue}
      {:empty, _} -> nil
    end
  end
end

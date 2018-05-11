defmodule ConnectionPoolTest do
  use ExUnit.Case

  test "round robin" do
    pid = ConnectionPool.init(3)
    assert 1 == ConnectionPool.get_connection(pid)
    assert 2 == ConnectionPool.get_connection(pid)
    assert 3 == ConnectionPool.get_connection(pid)
    assert 1 == ConnectionPool.get_connection(pid)
    assert 2 == ConnectionPool.get_connection(pid)
  end
end
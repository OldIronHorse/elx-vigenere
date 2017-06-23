defmodule VigenereTest do
  use ExUnit.Case
  import Vigenere

  test "rotate" do
    assert rotate(alphabet()) == 'bcdefghijklmnopqrstuvwxyza'
  end

  test "enciphering" do
    assert encipher('lemon','attackatdawn') == 'lxfopvefrnhr'
  end

  test "deciphering" do
    assert decipher('lemon','lxfopvefrnhr') == 'attackatdawn'
  end
end

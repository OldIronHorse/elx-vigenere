defmodule Vigenere do
  import Enum
  @moduledoc """
  Documentation for Vigenere.
  """

  def alphabet, do: String.graphemes("abcdefghijklmnopqrstuvwxyz")

  def rotate([x|xs]) do
    reverse([x|reverse(xs)])
  end

  def vigenere_table do
    reverse(reduce(tl(alphabet()),[alphabet()],fn(_,[a|as]) -> [rotate(a)|[a|as]] end))
  end

  def encipher_map do
    Map.new(zip(alphabet(),map(vigenere_table(),&(Map.new(zip(alphabet(),&1))))))
  end

  def decipher_map do
    Map.new(zip(alphabet(),map(vigenere_table(),&(Map.new(zip(&1,alphabet()))))))
  end

  def strip(text) do
    text |>
    String.graphemes |>
    filter(&(MapSet.member?(MapSet.new(alphabet()),&1))) |>
    Enum.join
  end

  def encipher(key,plain_text) do
    process(key,plain_text,encipher_map())
  end

  def process(key,text,cipher_map) do
    join(map(zip(Stream.cycle(String.graphemes(key)),String.graphemes(text)),
             fn({k,t}) -> Map.fetch!(Map.fetch!(cipher_map,k),t) end))
  end

  def decipher(key,cipher_text) do
    process(key,cipher_text,decipher_map())
  end
end

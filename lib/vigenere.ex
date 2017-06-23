defmodule Vigenere do
  import Enum
  @moduledoc """
  Documentation for Vigenere.
  """

  def alphabet, do: 'abcdefghijklmnopqrstuvwxyz'

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

  def encipher(key,plain_text) do
    process(key,plain_text,encipher_map())
  end

  def process(key,text,cipher_map) do
    map(zip(Stream.cycle(key),text),
             fn({k,t}) -> Map.fetch!(Map.fetch!(cipher_map,k),t) end)
  end

  def decipher(key,cipher_text) do
    process(key,cipher_text,decipher_map())
  end
end

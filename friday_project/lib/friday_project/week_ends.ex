defmodule FridayProject.WeekEnds do
  @moduledoc """
  The WeekEnds context.
  """

  import Ecto.Query, warn: false
  alias FridayProject.Repo

  alias FridayProject.WeekEnds.Party

  @doc """
  Returns the list of parties.

  ## Examples

      iex> list_parties()
      [%Party{}, ...]

  """
  def list_parties do
    Repo.all(Party)
  end

  def list_parties_with_preload do
    Party
    |> Repo.all()
    |> Repo.preload(:first_dev_experience)
  end

  @doc """
  Gets a single party.

  Raises `Ecto.NoResultsError` if the Party does not exist.

  ## Examples

      iex> get_party!(123)
      %Party{}

      iex> get_party!(456)
      ** (Ecto.NoResultsError)

  """
  def get_party!(id), do: Repo.get!(Party, id)

  def get_party_with_preload!(id), do: Repo.get!(Party, id) |> Repo.preload(:first_dev_experience)

  @doc """
  Creates a party.

  ## Examples

      iex> create_party(%{field: value})
      {:ok, %Party{}}

      iex> create_party(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_party(attrs \\ %{}) do
    %Party{}
    |> Party.changeset(attrs)
    |> Repo.insert()
    |> party_broadcast(:new_party)
  end

  @doc """
  Updates a party.

  ## Examples

      iex> update_party(party, %{field: new_value})
      {:ok, %Party{}}

      iex> update_party(party, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_party(%Party{} = party, attrs) do
    party
    |> Party.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a party.

  ## Examples

      iex> delete_party(party)
      {:ok, %Party{}}

      iex> delete_party(party)
      {:error, %Ecto.Changeset{}}

  """
  def delete_party(%Party{} = party) do
    Repo.delete(party)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking party changes.

  ## Examples

      iex> change_party(party)
      %Ecto.Changeset{data: %Party{}}

  """
  def change_party(%Party{} = party, attrs \\ %{}) do
    Party.changeset(party, attrs)
  end

  @doc """
  Returns listener to Phoenix PubSub.

  ## Examples

      iex> blockchain_subscribe()
      :ok

  """
  def party_subscribe do
    Phoenix.PubSub.subscribe(FridayProject.PubSub, "weekend")
  end

  @doc """
  Broadcasts to the above PubSub.

  ## Examples

      iex> party_broadcast({:ok, %Party{}}, :specific_event)
      {:ok, %Party{}}

  """
  def party_broadcast({:error, _reason} = error, _event) do
    error
  end

  def party_broadcast({:ok, party}, event) do
    Phoenix.PubSub.broadcast(
      FridayProject.PubSub,
      "weekend",
      {event, party}
    )

    {:ok, party}
  end
end

defmodule FridayProjectWeb.FirstDevExperienceLive.Index do
  use FridayProjectWeb, :live_view

  alias FridayProject.Fridays
  alias FridayProject.Fridays.FirstDevExperience

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      FridayProject.WeekEnds.party_subscribe()
  end
    {:ok, stream(socket, :first_dev_experiences, Fridays.list_first_dev_experiences())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit First dev experience")
    |> assign(:first_dev_experience, Fridays.get_first_dev_experience!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New First dev experience")
    |> assign(:first_dev_experience, %FirstDevExperience{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing First dev experiences")
    |> assign(:first_dev_experience, nil)
  end

  @impl true
  def handle_info({FridayProjectWeb.FirstDevExperienceLive.FormComponent, {:saved, first_dev_experience}}, socket) do
    {:noreply, stream_insert(socket, :first_dev_experiences, first_dev_experience)}
  end

  def handle_info({:new_party, party}, socket) do
    {:noreply,
     socket
     |> put_flash(
       :info,
       "une nouvelle teuf !! => #{party.name}"
     )}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    first_dev_experience = Fridays.get_first_dev_experience!(id)
    {:ok, _} = Fridays.delete_first_dev_experience(first_dev_experience)

    {:noreply, stream_delete(socket, :first_dev_experiences, first_dev_experience)}
  end
end

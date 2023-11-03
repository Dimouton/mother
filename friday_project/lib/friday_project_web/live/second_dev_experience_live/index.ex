defmodule FridayProjectWeb.SecondDevExperienceLive.Index do
  use FridayProjectWeb, :live_view

  alias FridayProject.Fridays
  alias FridayProject.Fridays.SecondDevExperience

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :second_dev_experiences, Fridays.list_second_dev_experiences())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Second dev experience")
    |> assign(:second_dev_experience, Fridays.get_second_dev_experience!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Second dev experience")
    |> assign(:second_dev_experience, %SecondDevExperience{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Second dev experiences")
    |> assign(:second_dev_experience, nil)
  end

  @impl true
  def handle_info(
        {FridayProjectWeb.SecondDevExperienceLive.FormComponent, {:saved, second_dev_experience}},
        socket
      ) do
    {:noreply, stream_insert(socket, :second_dev_experiences, second_dev_experience)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    second_dev_experience = Fridays.get_second_dev_experience!(id)
    {:ok, _} = Fridays.delete_second_dev_experience(second_dev_experience)

    {:noreply, stream_delete(socket, :second_dev_experiences, second_dev_experience)}
  end
end

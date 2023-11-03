defmodule FridayProjectWeb.FirstDevExperienceLive.FormComponent do
  use FridayProjectWeb, :live_component

  alias FridayProject.Fridays

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage first_dev_experience records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="first_dev_experience-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:nb_thing]} type="number" label="Nb thing" />
        <:actions>
          <.button phx-disable-with="Saving...">Save First dev experience</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{first_dev_experience: first_dev_experience} = assigns, socket) do
    changeset = Fridays.change_first_dev_experience(first_dev_experience)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"first_dev_experience" => first_dev_experience_params}, socket) do
    changeset =
      socket.assigns.first_dev_experience
      |> Fridays.change_first_dev_experience(first_dev_experience_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"first_dev_experience" => first_dev_experience_params}, socket) do
    save_first_dev_experience(socket, socket.assigns.action, first_dev_experience_params)
  end

  defp save_first_dev_experience(socket, :edit, first_dev_experience_params) do
    case Fridays.update_first_dev_experience(
           socket.assigns.first_dev_experience,
           first_dev_experience_params
         ) do
      {:ok, first_dev_experience} ->
        notify_parent({:saved, first_dev_experience})

        {:noreply,
         socket
         |> put_flash(:info, "First dev experience updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_first_dev_experience(socket, :new, first_dev_experience_params) do
    case Fridays.create_first_dev_experience(first_dev_experience_params) do
      {:ok, first_dev_experience} ->
        notify_parent({:saved, first_dev_experience})

        {:noreply,
         socket
         |> put_flash(:info, "First dev experience created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

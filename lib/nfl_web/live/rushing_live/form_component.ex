defmodule NflWeb.RushingLive.FormComponent do
  use NflWeb, :live_component

  alias Nfl.Statistics

  @impl true
  def update(%{rushing: rushing} = assigns, socket) do
    changeset = Statistics.change_rushing(rushing)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"rushing" => rushing_params}, socket) do
    changeset =
      socket.assigns.rushing
      |> Statistics.change_rushing(rushing_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"rushing" => rushing_params}, socket) do
    save_rushing(socket, socket.assigns.action, rushing_params)
  end

  defp save_rushing(socket, :edit, rushing_params) do
    case Statistics.update_rushing(socket.assigns.rushing, rushing_params) do
      {:ok, _rushing} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rushing updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_rushing(socket, :new, rushing_params) do
    case Statistics.create_rushing(rushing_params) do
      {:ok, _rushing} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rushing created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

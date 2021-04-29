defmodule NflWeb.LiveHelpers do
  @moduledoc false
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `NflWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, NflWeb.RushingLive.FormComponent,
        id: @rushing.id || :new,
        action: @live_action,
        rushing: @rushing,
        return_to: Routes.rushing_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, NflWeb.ModalComponent, modal_opts)
  end
end

defmodule EcoService.EcoService.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcoService.EcoService.Community

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "schedules" do
    field :date, :date

    has_many :communities, Community
    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end

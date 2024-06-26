defmodule EcoService.EcoService.Community do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcoService.EcoService.Schedule

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "communities" do
    field :location_area_zone, :string
    field :name, :string
    field :lat, :decimal
    field :long, :decimal
    field :gate_photo_file_name, :string

    belongs_to :schedule, Schedule

    timestamps()
  end

  @doc false
  def changeset(community, attrs) do
    community
    |> cast(attrs, [:name, :location_area_zone, :lat, :long, :gate_photo_file_name])
    |> validate_required([:name, :location_area_zone])
  end

  def update_community_changeset(community, attrs) do
    community
    |> cast(attrs, [:schedule_id])
  end
end

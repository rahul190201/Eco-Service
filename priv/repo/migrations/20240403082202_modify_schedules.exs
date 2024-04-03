defmodule EcoService.Repo.Migrations.ModifySchedules do
  use Ecto.Migration

  def change do
    alter table(:schedules) do
      remove :date, :integer
      add :date, :date
    end
  end
end

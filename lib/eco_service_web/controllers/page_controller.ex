defmodule EcoServiceWeb.PageController do
  use EcoServiceWeb, :controller

  alias EcoService.EcoServiceContext
  alias EcoService.EcoService.Schedule
  alias EcoService.Repo

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def get_all_communities(conn, _params) do
    all_communities = EcoServiceContext.fetch_all_communities()

    all_communities =
      Enum.map(all_communities, fn community ->
        %{
          community_id: community.id,
          community_name: community.name,
          community_location: community.location_area_zone,
          latitude: community.lat,
          longtitude: community.long,
          gate_photo_file_name: community.gate_photo_file_name
        }
      end)

    json(conn, all_communities)
  end

  def add_waste(conn, params) do
    date = EcoServiceContext.convert_string_date_to_ecto_date(params["date"])
    params = Map.replace(params, "date", date)

    insert_waste = EcoServiceContext.insert_waste(params) |> IO.inspect(label: "Insert Waste")

    case insert_waste do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> text("Data Inserted Successfully")

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> text("Insertion Failed")
    end
  end

  def get_schedules_for_todate(conn, _params) do
    todate_schedules = EcoServiceContext.get_schedules_for_date(Date.utc_today()) == []

    case todate_schedules do
      true ->
        schedule =
          Repo.insert!(%Schedule{
            date: Date.utc_today()
          })

        json(conn, schedule.id)

      false ->
        todate_schedule = List.first(EcoServiceContext.get_schedules_for_date(Date.utc_today()))

        schedule_details =
          Enum.map(todate_schedule.communities, fn community ->
            %{
              community_name: community.name,
              community_location: community.location_area_zone,
              lat: community.lat,
              long: community.long,
              gate_photo_file_name: community.gate_photo_file_name,
              community_id: community.id,
              date: todate_schedule.date
            }
          end)

        json(conn, %{schedule_id: todate_schedule.id, communities: schedule_details})
    end
  end

  def insert_schedules(conn, params) do
    community = EcoServiceContext.get_community_by_id(params["community_id"])

    update_schedule =
      EcoServiceContext.update_schedule_id_in_community(community, params["schedule_id"])

    case update_schedule do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> text("Data Inserted Successfully")

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> text("Insertion Failed")
    end
  end

  def insert_schedules(conn, params) do
    date = EcoServiceContext.convert_string_date_to_ecto_date(params["date"])
    params = Map.replace(params, "date", date)

    community = EcoServiceContext.get_community_by_id(params["community_id"])

    schedule = EcoServiceContext.insert_schedule(params)
    update_schedule = EcoServiceContext.update_schedule_id_in_community(community, schedule.id)

    case update_schedule do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> text("Data Inserted Successfully")

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> text("Insertion Failed")
    end
  end

  def get_schedules_for_todate(conn, _params) do
    todate_schedules = EcoServiceContext.get_schedules_for_date(Date.utc_today()) == []

    case todate_schedules do
      true ->
        schedule =
          Repo.insert!(%Schedule{
            date: Date.utc_today()
          })

        json(conn, schedule.id)

      false ->
        todate_schedule = List.first(EcoServiceContext.get_schedules_for_date(Date.utc_today()))

        schedule_details =
          Enum.map(todate_schedule.communities, fn community ->
            %{
              community_name: community.name,
              location_area_zone: community.location_area_zone,
              lat: community.lat,
              long: community.long,
              gate_photo_file_name: community.gate_photo_file_name,
              community_id: community.id,
              date: todate_schedule.date
            }
          end)

        json(conn, %{schedule_id: todate_schedule.id, communities: schedule_details})
    end
  end

  def insert_schedules(conn, params) do
    community = EcoServiceContext.get_community_by_id(params["community_id"])

    update_schedule =
      EcoServiceContext.update_schedule_id_in_community(community, params["schedule_id"])

    case update_schedule do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> text("Data Inserted Successfully")

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> text("Insertion Failed")
    end
  end
end

alias NimbleCSV.RFC4180, as: CSV
alias EcoService.Repo
alias EcoService.EcoService.Waste
alias EcoService.EcoService.Community
alias EcoService.EcoServiceContext

:code.priv_dir(:eco_service)
|> Path.join("repo/details_of_waste.csv")
|> File.read!()
|> CSV.parse_string()
|> Enum.each(fn
  [
  name,
  location_area_zone,
  date,
  glass_bags,
  mixed_bags,
  plastic_bags,
  paper_bags,
  seg_lf_bags,
  sanitory_bags,
  comments
  ] ->

    community_list = Enum.map(EcoServiceContext.search_communities(%{"name" => name}), fn community -> community.name end)

    community =
    if (name in community_list) == false do
      Repo.insert!(
      %Community{
        name: String.trim(name),
        location_area_zone: location_area_zone
      })
    else
      List.first(EcoServiceContext.search_communities(%{"name" => name}))
    end

   Repo.insert!(
    %Waste{
    date: EcoServiceContext.convert_to_ecto_date(date),
    glass_bags: EcoServiceContext.convert_to_integer(glass_bags),
    mixed_bags: EcoServiceContext.convert_to_integer(mixed_bags),
    plastic_bags: EcoServiceContext.convert_to_integer(plastic_bags),
    paper_bags: EcoServiceContext.convert_to_integer(paper_bags),
    seg_lf_bags: EcoServiceContext.convert_to_integer(seg_lf_bags),
    sanitory_bags: EcoServiceContext.convert_to_integer(sanitory_bags),
    comments: comments,
    community_id: community.id
    })
  end
  )

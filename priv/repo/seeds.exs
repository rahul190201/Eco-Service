# Script for populating the database. You can run it as
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EcoService.Repo.insert!(%EcoService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EcoService.Repo
alias EcoService.EcoService.Community
alias EcoService.EcoService.Waste
alias EcoService.EcoService.Schedule

# list_of_numbers = 1..10

# for number <- list_of_numbers do

  demo_date =
  Repo.insert!(
    %Schedule{
      date: ~D[2024-04-02],
    }
  )


  demo_date_1 =
  Repo.insert!(
    %Schedule{
      date: ~D[2024-05-02],
    }
  )


  Repo.insert!(
    %Community{
      name: "Surrender",
      location_area_zone: "Surrender ",
      schedule_id: demo_date.id
    }
  )

  Repo.insert!(
    %Community{
      name: "New Creation",
      location_area_zone: "New Creation ",
      schedule_id: demo_date.id
    }
  )

  Repo.insert!(
    %Community{
      name: "Sacred Grooves",
      location_area_zone: "Sacred Grooves",
      schedule_id: demo_date.id
    }
  )

  Repo.insert!(
    %Community{
      name: "Aspiration",
      location_area_zone: "Aspiration",
      schedule_id: demo_date_1.id
    }
  )


  Repo.insert!(
    %Community{
      name: "Sadhana forest",
      location_area_zone: "Sadhana forest",
      schedule_id: demo_date_1.id
    }
  )


  # list_of_numbers = 1..100

  # for number <- list_of_numbers do

  #   community =  Repo.insert!(
  #     %Community{
  #       name: "Eco Service #{number}",
  #       location_area_zone: "Auroshilpam #{number}"
  #     }
  #   )

  #   Repo.insert!(
  #     %Waste{
  #       comments: "No comments #{number}",
  #       date: ~D[2024-01-29],
  #       glass_bags: 23,
  #       kg_of_glass: 12.99,
  #       kg_of_mixed: 25.77,
  #       kg_of_paper: 50.00,
  #       kg_of_plastic: 51.00,
  #       kg_of_sanitory: 19.00,
  #       kg_of_seg_lf: 13.44,
  #       mixed_bags: 12,
  #       paper_bags: 30,
  #       plastic_bags: 40,
  #       sanitory_bags: 50,
  #       seg_lf_bags: 10,
  #       community_id: community.id
  #     }
  #   )
  # end

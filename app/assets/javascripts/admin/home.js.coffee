home_dashboard = (data_for_charts) ->
  # status chart data
  statusData = data_for_charts.status_data
  # status dougnut chart
  statusDoughnutChart = new Chart(document.getElementById("statusDoughnutCanvas").getContext("2d")).Doughnut(statusData)
  # status polar chart
  statusPolarChart = new Chart(document.getElementById("statusPolarCanvas").getContext("2d")).PolarArea(statusData)

  # species chart data
  speciesData = data_for_charts.species_data
  # species dougnut chart
  speciesDoughnutChart = new Chart(document.getElementById("speciesDoughnutCanvas").getContext("2d")).Doughnut(speciesData)
  # species polar chart
  speciesPolarChart = new Chart(document.getElementById("speciesPolarCanvas").getContext("2d")).PolarArea(speciesData)

  # colros chart data
  colorsData = data_for_charts.colors_data
  # color dougnut chart
  colorsDoughnutChart = new Chart(document.getElementById("colorDoughnutCanvas").getContext("2d")).Doughnut(colorsData)
  # color polar chart
  colorsPolarChart = new Chart(document.getElementById("colorPolarCanvas").getContext("2d")).PolarArea(colorsData)

  # sexes chart data
  sexData = data_for_charts.sex_data
  # sex dougnut chart
  sexDoughnutChart = new Chart(document.getElementById("sexDoughnutCanvas").getContext("2d")).Doughnut(sexData)
  # sex polar chart
  sexPolarChart = new Chart(document.getElementById("sexPolarCanvas").getContext("2d")).PolarArea(sexData)

  # event sparklines
  event_spark_values = data_for_charts.event_spark_data
  $("#event_sparkline").sparkline event_spark_values,
    height: 32
    type: "bar"
    barColor: "#dddddd"


  # contact sparklines
  contact_spark_values = data_for_charts.contact_spark_data
  $("#contact_sparkline").sparkline contact_spark_values,
    height: 32
    type: "bar"
    barColor: "#dddddd"


  # species sparklines
  species_spark_values = data_for_charts.species_spark_data
  $("#species_sparkline").sparkline species_spark_values,
    height: 32
    type: "bar"
    barColor: "#dddddd"


  # animals sparklines
  animals_spark_values = data_for_charts.animals_spark_data
  $("#animals_sparkline").sparkline animals_spark_values,
    height: 32
    type: "bar"
    barColor: "#dddddd"

window.home_dashboard = home_dashboard
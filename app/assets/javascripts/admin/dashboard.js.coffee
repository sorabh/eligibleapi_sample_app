#= require lib/amcharts
$(document).ready ->
  if $("#recent_api_graph").size() > 0
    recentChartData = eval($("#recent_chart_data").html())
    clientChartData = eval($("#client_chart_data").html())

    AmCharts.ready ->

      chart1 = new AmCharts.AmSerialChart()

      chart1.pathToImages = "/assets/amcharts/"
      chart1.dataProvider = recentChartData
      chart1.categoryField = "requested_at"

      categoryAxis = chart1.categoryAxis
      categoryAxis.dashLength = 5
      categoryAxis.equalSpacing = true
      categoryAxis.startOnAxis = true
      categoryAxis.axisAlpha = 0

      valueAxis1 = new AmCharts.ValueAxis()
      valueAxis1.axisAlpha = 0
      valueAxis1.dashLength = 5
      valueAxis1.inside = true
      valueAxis1.axisAlpha = 1
      chart1.addValueAxis valueAxis1

      graph1 = new AmCharts.AmGraph()
      graph1.bullet = "round"
      graph1.bulletSize = 6
      graph1.valueField = "qty"
      graph1.bulletColor = "#2393F6"
      graph1.lineColor = "#2393F6"
      chart1.addGraph graph1
      chartCursor = new AmCharts.ChartCursor()
      chartCursor.zoomable = true
      chartCursor.cursorColor = "#2393F6"
      chart1.addChartCursor chartCursor
      chart1.write "recent_api_graph"



      chart2 = new AmCharts.AmSerialChart()

      chart2.pathToImages = "/assets/amcharts/"
      chart2.dataProvider = clientChartData
      chart2.categoryField = "client"
      #chart2.columnSpacing = 3
      chart2.depth3D = 20
      chart2.angle = 30

      categoryAxis2 = chart2.categoryAxis
      categoryAxis2.dashLength = 5
      categoryAxis2.axisAlpha = 0
      categoryAxis2.labelRotation = 90
      categoryAxis2.inside = true

      valueAxis2 = new AmCharts.ValueAxis()
      valueAxis2.axisAlpha = 0
      valueAxis2.dashLength = 5
      valueAxis2.inside = true
      chart2.addValueAxis(valueAxis2)

      graph3 = new AmCharts.AmGraph()
      graph3.type = "column"
      graph3.fillAlphas = 1
      graph3.lineColor = "#ff6600"
      graph3.valueField = "qty"
      graph3.lineAlpha = 0
      graph3.lineColor = "#2393F6"
      chart2.addGraph(graph3)

      chart2.write("client_api_graph")

  if $("#insurance_graph").size() > 0
    insuranceChartData = eval($("#insurance_chart_data").html())

    # PIE CHART
    chart = new AmCharts.AmPieChart()
    chart.dataProvider = insuranceChartData
    chart.titleField = "company"
    chart.valueField = "qty";
    chart.outlineColor = "#FFFFFF"
    chart.outlineAlpha = 0.8
    chart.outlineThickness = 2
    chart.marginBottom = 0
    # this makes the chart 3D
    chart.depth3D = 15
    chart.angle = 30

    # LEGEND
    legend = new AmCharts.AmLegend()
    legend.align = "center"
    legend.markerType = "circle"
    chart.addLegend(legend)

    # WRITE
    chart.write("insurance_graph")


  # Enrollments
  if $("#index_table_enrollment_npis").size() > 0
    $(".status select").change ->
      name = $(this).attr('name')
      val = $(this).val()
      $.post("/admin/enrollment_npis/update_status", {'name': name, 'val': val});

  # Cost - Revenue
  if $("#revenue_cost_graph").size() > 0
    reportChartData = eval($("#report_chart_data").html())

    parseDate = (str) ->
      dt = str.split("/")
      new Date(dt[2], dt[0] - 1, dt[1])

    parsedData = []
    for k, v of reportChartData
      parsedData.push {cost: v.cost, revenue: v.revenue, profit: v.profit, date: parseDate(v.date)}

    AmCharts.ready ->

      # SERIAL CHART
      chart = new AmCharts.AmSerialChart()
      chart.autoMarginOffset = 0
      chart.marginRight = 0
      chart.marginBottom = 5
      chart.dataProvider = parsedData
      chart.categoryField = "date"
      chart.startDuration = 1
      chart.plotAreaFillAlphas = 0.2
      chart.angle = 30
      chart.depth3D = 40

      # AXES
      # category
      categoryAxis = chart.categoryAxis
      categoryAxis.gridPosition = "start"
      categoryAxis.axisColor = "#DADADA"
      categoryAxis.dashLength = 5
      categoryAxis.parseDates = true

      # value
      valueAxis = new AmCharts.ValueAxis()
      valueAxis.stackType = "3d"
      valueAxis.gridAlpha = 0.2
      valueAxis.axisColor = "#DADADA"
      valueAxis.axisAlpha = 1
      valueAxis.dashLength = 5
      valueAxis.title = "USD"
      valueAxis.dashLength = 5
      valueAxis.position = "top"
      valueAxis.showLastLabel = false
      chart.addValueAxis valueAxis

      # GRAPHS
      # column graph
      graph1 = new AmCharts.AmGraph()
      graph1.type = "column"
      graph1.title = "Cost"
      graph1.valueField = "cost"
      graph1.lineAlpha = 0
      graph1.fillColors = "#FF3333"
      graph1.fillAlphas = 1
      chart.addGraph graph1

      # column graph
      graph2 = new AmCharts.AmGraph()
      graph2.type = "column"
      graph2.title = "Revenue"
      graph2.valueField = "revenue"
      graph2.lineAlpha = 0
      graph2.fillColors = "#7AF500"
      graph2.fillAlphas = 1
      chart.addGraph graph2


      # line graph
      graph3 = new AmCharts.AmGraph()
      graph3.type = "line"
      graph3.title = "Profit"
      graph3.valueField = "profit"
      graph3.lineThickness = 3
      graph3.bullet = "round"
      graph3.fillAlphas = 0
      graph3.lineColor = "#3399FF"
      chart.addGraph graph3

      # LEGEND
      legend = new AmCharts.AmLegend()
      chart.addLegend legend

      # WRITE
      chart.write "revenue_cost_graph"

  # Cost graph
  if $("#cost_graph").size() > 0
    AmCharts.ready ->

      reportChartData = eval($("#report_chart_data").html())

      # SERIAL CHART
      chart = new AmCharts.AmSerialChart()
      chart.autoMarginOffset = 0
      chart.dataProvider = reportChartData
      chart.categoryField = "payer_id"
      chart.startDuration = 1
      chart.depth3D = 1
      chart.angle = 30
      chart.depth3D = 40

      # AXES
      # category
      categoryAxis = chart.categoryAxis
      categoryAxis.labelRotation = 45 # this line makes category values to be rotated
      categoryAxis.gridAlpha = 0
      categoryAxis.fillAlpha = 1
      #categoryAxis.fillColor = "#FAFAFA"
      categoryAxis.gridPosition = "start"

      # value
      valueAxis = new AmCharts.ValueAxis()
      valueAxis.dashLength = 5
      valueAxis.title = "USD"
      valueAxis.axisAlpha = 0
      chart.addValueAxis valueAxis

      # GRAPH
      graph = new AmCharts.AmGraph()
      graph.valueField = "cost"
      graph.balloonText = "[[category]]: [[value]]"
      graph.type = "column"
      graph.lineAlpha = 0
      graph.fillAlphas = 1
      chart.addGraph graph

      # WRITE
      chart.write "cost_graph"

  # Cost graph by user
  if $("#cost_by_user_graph").size() > 0
    AmCharts.ready ->

      reportChartData = eval($("#report_chart_data").html())

      # SERIAL CHART
      chart = new AmCharts.AmSerialChart()
      chart.autoMarginOffset = 0
      chart.dataProvider = reportChartData
      chart.categoryField = "user"
      chart.startDuration = 1
      chart.depth3D = 1
      chart.angle = 30
      chart.depth3D = 40

      # AXES
      # category
      categoryAxis = chart.categoryAxis
      categoryAxis.labelRotation = 45 # this line makes category values to be rotated
      categoryAxis.gridAlpha = 0
      categoryAxis.fillAlpha = 1
      categoryAxis.gridPosition = "start"

      # value
      valueAxis = new AmCharts.ValueAxis()
      valueAxis.dashLength = 5
      valueAxis.title = "USD"
      valueAxis.axisAlpha = 0
      chart.addValueAxis valueAxis

      # GRAPH
      graph = new AmCharts.AmGraph()
      graph.valueField = "cost"
      graph.balloonText = "[[category]]: [[value]]"
      graph.type = "column"
      graph.lineAlpha = 0
      graph.fillAlphas = 1
      chart.addGraph graph

      # WRITE
      chart.write "cost_by_user_graph"


  if $("#user_transaction_graph").size() > 0
    reportChartData = eval($("#report_chart_data").html())
    chart = undefined
    legend = undefined
    chartData = [
      country: "Over 600"
      value: reportChartData[0]
    ,
      country: "Less than 600"
      value: reportChartData[1]
    ]
    AmCharts.ready ->

      # PIE CHART

      chart = new AmCharts.AmPieChart()
      chart.dataProvider = chartData
      chart.titleField = "country"
      chart.valueField = "value"
      chart.outlineColor = "#FFFFFF"
      chart.outlineAlpha = 0.8
      chart.outlineThickness = 2

      # this makes the chart 3D
      chart.depth3D = 15
      chart.angle = 30

      # WRITE
      chart.write "user_transaction_graph"




  if $("#daily_graph").size() > 0
    reportChartData = eval($("#report_chart_data").html())
    chart = undefined
    legend = undefined
    chartData = []
    for  each in  reportChartData
      chartData.push({User: each.email, value: each.cant_api_calls})

    AmCharts.ready ->
      # PIE CHART
      chart = new AmCharts.AmPieChart()
      chart.dataProvider = chartData
      chart.titleField = "User"
      chart.valueField = "value"
      chart.outlineColor = "#FFFFFF"
      chart.outlineAlpha = 0.8
      chart.outlineThickness = 2

      # this makes the chart 3D
      chart.depth3D = 15
      chart.angle = 30

      # WRITE
      chart.write "daily_graph"

  $(".modal").click (event) ->
    event.preventDefault()
    openModal $(this).attr 'href'


openModal = (url) ->
  jQuery("#content-ajax").load url, ->
    jQuery("#myModal").dialog
      dialogClass: "no-close"
      autoOpen: true
      height: 300
      width: 500
      modal: true
      resizable: false

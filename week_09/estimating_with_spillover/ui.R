shinyUI(fluidPage(
  titlePanel("Geographic Spillovers"),
  sidebarLayout(
    sidebarPanel(
      helpText("Estimates of causal effects depend on the assumed spillover structure.
               In this example, you can choose the radius beyond which spillovers are assumed to be zero.
               Units are in a spillover condition if there is a treated unit within the specified radius.
               Outcomes were generated under a true radius of 5km."),
      
      sliderInput("radius", 
                  label = "Spillover Radius",
                  min = 0, max = 20, value = 3, step=1),
      helpText("Choose the magnitude of the true causal effects:"),
      numericInput("direct", label = "Direct Effect", value = 2, min = -10, max = 10),
      numericInput("indirect", label = "Indirect Effect", value = -2, min = -10, max = 10),
      numericInput("directplusindirect", label = "Direct + Indirect Effect", value = -7, min = -10, max = 10)
    ),
    mainPanel(
      plotOutput("radiusmap"),
      helpText("The table below shows the true causal effects, and the average of the 1000 estimates that would be obtained under the assumed radius. The estimates are biased unless the assumed radius is the correct radius (5km)."),
      tableOutput("esttable")
    )
  )
)
)
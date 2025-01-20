library(shiny)
library(ggplot2)
library(sf)
library(tidyverse)

ui <- fluidPage(
  h1("An Overview of US Health Insurance Trends as of 2019"),
  
  # Different Tabs
  tabsetPanel(
    
    # Visualisation Number 1
    tabPanel(
      "Choropleth Map", # Tab Title
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "insurancetype",
            label = "Select Insurance Type",
            choices = c("Uninsured Rate (%)", "Privately Insured (%)", "Publicly Insured (%)"),
            selected = "Uninsured Rate (%)"
          )
        ),
        
        mainPanel(
          plotOutput("plot1")
        )
      )
    ),
    
    # Visualisation Number 2
    tabPanel(
      "Line Chart", # Tab Title 
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "state_line",
            label = "Select State",
            choices = unique(insurance_data_over_time$state),
            selected = "Alabama"
          )
        ),
        
        mainPanel(
          plotOutput("plot2")
        )
      )
    ),
    
    # Visualisation Number 3
    tabPanel(
      "Stacked Bar Chart", # Tab Title 
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "state_bar",
            label = "Select State",
            choices = unique(state_insurance$state),
            selected = "Alabama"
          )
        ),
        
        mainPanel(
          plotOutput("plot3")
        )
      )
    )
  )
)


# SERVER ----
server <- function(input, output) {
  
  # Render plot1 for Choropleth Map (Tab 1 - Visualisation Number 1)
  output$plot1 <- renderPlot({
    selected_column <- switch(input$insurancetype,
                              "Uninsured Rate (%)" = "uninsured_rate",
                              "Privately Insured (%)" = "private_insurance_rate",
                              "Publicly Insured (%)" = "public_insurance_rate")
    
    ggplot(state_insurance) +
      geom_sf(aes(fill = get(selected_column)), color = "white") + # using spatial data from US Census
      scale_fill_viridis_c(name = input$insurancetype) + # Using Pre-Made R Colour Palettes
      coord_sf(
        xlim = c(-125, -66),  # Longitude limits for the continental US 
        ylim = c(24, 49),     # Latitude limits for the continental US
        expand = FALSE         # Ensure Map is zoomed in on the US
      ) +
      theme_minimal() +
      labs(
        title = paste(input$insurancetype, "in US States (2019)"),
        caption = "Source: ACS 2019, UK Census"
      )
  })
  
  # Render plot2 for Line Chart (Tab 2 - Visualisation Number 2)
  output$plot2 <- renderPlot({
    selected_state <- input$state_line
    state_data <- insurance_data_over_time %>% filter(state == selected_state)
    
    ggplot(state_data) +
      geom_line(aes(x = year, y = uninsured, color = "Uninsured"), size = 1.2) +
      geom_line(aes(x = year, y = privately_insured, color = "Privately Insured"), size = 1.2) +
      geom_line(aes(x = year, y = publicly_insured, color = "Publicly Insured"), size = 1.2) +
      scale_color_manual(name = "Insurance Type", 
                         values = c("Uninsured" = "lightblue", "Privately Insured" = "royalblue", "Publicly Insured" = "darkblue")) +
      theme_minimal() +
      labs(
        title = paste("Insurance Coverage Trends in", selected_state, "(2015-2019)"),
        x = "Year",
        y = "Number of Individuals",
        caption = "Source: ACS 2015-2019, UK Census"
      )
  })
  
  # Render plot3 for Stacked Bar Chart (Tab 3 - Visualisation Number 3)
  output$plot3 <- renderPlot({
    selected_state <- input$state_bar
    state_data <- age_insurance %>% filter(state == selected_state)
    
    ggplot(state_data, aes(x = insurance_type, y = population, fill = age_group)) +
      geom_bar(stat = "identity", position = "stack") +
      scale_fill_manual(
        name = "Age Group",
        values = c("under" = "lightblue", "18" = "royalblue", "65" = "darkblue"),
        labels = c("under" = "Under 18", "18" = "18-64", "65" = "65+")
      ) +
      theme_minimal() +
      labs(
        title = paste("Stacked Bar Chart of Insurance Coverage by Age Group in", selected_state, "2019"),
        x = "Insurance Type",
        y = "Population",       
        caption = "Source: ACS 2019, UK Census"
      )
  })
}

# RUN APP ----
shinyApp(ui = ui, server = server)

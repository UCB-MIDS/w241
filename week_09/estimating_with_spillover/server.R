# server.R
source("helpers.R")

N <- 50  # total units
m <- 10  # Number to be treated

# Generate coordinates
set.seed(343)
coords <- matrix(rnorm(N*2)*10, ncol = 2)

# Generate distance matrix
distmat <- as.matrix(dist(coords))

# Potential outcomes are a function of position
# We write treatment effects Yij 
Y00 <- rep(0, N)

# Randomly generate treatment assignment
assign <- complete_ra(N, m)

# True basis for spillovers
true_radius <- 5
true_adjmat <- 1 * (distmat<=true_radius)
diag(true_adjmat) <-0

# Reveal true conditions
true_cond <- get_condition(assign = assign, adjmat = true_adjmat)

# Generate outcomes under all random assignments (using true spillover radius)
Z_mat <- replicate(1000, complete_ra(N,m))
true_cond_mat <- apply(Z_mat, 2, get_condition, adjmat=true_adjmat)

cols <- c("#E7C545","#948E45","#AE3D00",   "#310708")

shinyServer(
  function(input, output) {
    
    estimates_fun <- reactive({
      
      # Treatment Effects 
      t10 <- input$direct   # direct effect
      t01 <- input$indirect   # indirect effect
      t11 <- input$directplusindirect    # direct + indirect
      
      Y01 <- Y00 + t01
      Y10 <- Y00 + t10
      Y11 <- Y00 + t11
      
      # Generate observed outcomes
      Y <- get_Y(cond = true_cond, Y00 = Y00, Y01=Y01, Y10=Y10, Y11=Y11)
      Y_mat <- apply(true_cond_mat, 2, FUN = get_Y, Y00 = Y00, Y01=Y01, Y10=Y10, Y11=Y11)
      
      # Radius for spillover
      radius <- input$radius
      
      # Generate numeric adjacency matrix
      adjmat <-  1 * (distmat<=radius)
      diag(adjmat) <- 0
      
      cond <- get_condition(assign=assign, adjmat=adjmat)
      
      # Generate probabilies of assignment
      cond_mat <- apply(Z_mat, 2, get_condition, adjmat=adjmat)
      prob00 <- rowMeans(cond_mat=="00")
      prob01 <- rowMeans(cond_mat=="01")
      prob10 <- rowMeans(cond_mat=="10")
      prob11 <- rowMeans(cond_mat=="11")
      
      # Generate probabilities that units are in the condition that they are in
      prob <- get_prob(cond = cond, prob00=prob00,prob01=prob01,prob10=prob10, prob11=prob11)
      prob_mat <- apply(X = cond_mat, 2, FUN = get_prob, prob00=prob00,prob01=prob01,prob10=prob10, prob11=prob11)
      
      # Estimate Treatment effects
      estimates <- mapply(FUN = estimator_ipw, split(Y_mat, col(Y_mat)), split(cond_mat, col(cond_mat)), split(prob_mat, col(prob_mat)), MoreArgs = list(prob00=prob00,prob01=prob01,prob10=prob10, prob11=prob11))
      estimates[is.nan(estimates)] <-NA
      means <- apply(estimates, 1, mean, na.rm=TRUE)
      means <- means[c(2,1,3)]
      list(means=means)
    })
    
    output$radiusmap <- renderPlot({    
      # Radius for spillover
      radius <- input$radius
      adjmat <-  1 * (distmat<=radius)
      diag(adjmat) <- 0
      
      t10 <- input$direct   # direct effect
      t01 <- input$indirect   # indirect effect
      t11 <- input$directplusindirect    # direct + indirect
      cond <- get_condition(assign=assign, adjmat=adjmat)
      
      # plot exposure
      exposure_cols <-ifelse(assign==1, cols[3], NA)
      treat_cols <-ifelse(assign==1, cols[3], cols[1])
      exposure_pchs <- ifelse(cond %in% c("01", "11"), 19, 1)
      
      plot(coords,type="n", xlim=c(-25,25), ylim= c(-40,25),xlab="",ylab="",main=paste0("Geographic Spillovers with Radius = ", radius, "km"))
      symbols(coords,circles=rep(radius,N),inches=FALSE,fg=exposure_cols, add=TRUE)
      points(coords,cex=1.5, pch=exposure_pchs, col=treat_cols)
      legend("bottom", legend = c("Control, No Spill","Treated, No Spill", "Control, Spill", "Treated, Spill"),ncol = 2,
             col=c(cols[1], cols[3], cols[1], cols[3]), pch=c(1,1,19,19))     
    })
    output$esttable <- renderTable({
      t10 <- input$direct   # direct effect
      t01 <- input$indirect   # indirect effect
      t11 <- input$directplusindirect    # direct + indirect
      results <- estimates_fun()
      resultstable <- cbind(c(t10, t01, t11), results$means, c(t10, t01,t11) - results$means)
      rownames(resultstable) <- c( "Direct", "Indirect", "Direct + Indirect")
      colnames(resultstable) <- c("True", "Average Estimated", "Bias")
      resultstable
    })
  })
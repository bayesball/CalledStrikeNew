compare_contour<- function(df, L = 0.5,
                                 type = "ms",
                                 Ncol = 2,
                                 etitle = ""){
  # handle if df is a data frame for a single player
  if(is.data.frame(df) == TRUE) {
    df <- list(df)
    names(df) <- "Player"
  }
  N_df <- length(df)
  if(is.list(df) == TRUE){
    if(length(names(df)) == 0){
      names(df) <- paste("Player", 1:N_df)
    }
  }
#  flag <- TRUE
  if(type %in% c("ms", "cs", "h", "hr", "sw",
                 "la", "ls", "sa", "mc") == FALSE){
    stop("Wrong type")
#    flag <- FALSE
  }
#  if(flag == TRUE){
  fit <- vector(mode = "list", length = N_df)
  if (type == "sw"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_all() %>%
        swing_gam_fit() -> fit[[j]]
      title <- "Swing Rate"
      if(missing(L) == TRUE) L <- seq(0, 1, by = 0.1)
    }
  }
  if (type == "ms"){
    for(j in 1:N_df){
      df[[j]] %>%
      setup_swing() %>%
      miss_gam_fit() -> fit[[j]]
      title <- "Missed on Swing Rate"
     if(missing(L) == TRUE) L <- seq(0, 1, by = 0.1)
    }
  }
  if (type == "mc"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_swing() %>%
        contact_gam_fit() -> fit[[j]]
      title <- "Make Contact on Swing Rate"
      if(missing(L) == TRUE) L <- seq(0, 1, by = 0.1)
    }
  }
  if (type == "cs"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_called() %>%
        strike_gam_fit() -> fit[[j]]
        title <- "Called Strike Rate"
        if(missing(L) == TRUE) L <- c(0.5, 0.9)
    }
  }
  if (type == "h"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_inplay() %>%
        hr_h_gam_fit(HR = FALSE) -> fit[[j]]
        title <- "In-Play Hit Rate"
        if(missing(L) == TRUE) L <- seq(0, 1, by = 0.1)
    }
  }
  if (type == "hr"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_inplay() %>%
        hr_h_gam_fit(HR = TRUE) -> fit[[j]]
        title <- "In-Play Home Run Rate"
       if(missing(L) == TRUE) L <- seq(.04, .16, by = 0.04)
    }
  }
  if (type == "ls"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_inplay() %>%
        ls_gam_fit() -> fit[[j]]
      title <- "Launch Speed"
      if(missing(L) == TRUE) L <- seq(75, 105, by = 5)
    }
  }
  if (type == "la"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_inplay() %>%
        la_gam_fit() -> fit[[j]]
      title <- "Launch Angle"
      if(missing(L) == TRUE) L <- c(-10, 0, 20, 30, 40)
    }
  }
  if (type == "sa"){
    for(j in 1:N_df){
      df[[j]] %>%
        setup_inplay() %>%
        sa_gam_fit() -> fit[[j]]
      title <- "Spray Angle"
      if(missing(L) == TRUE) L <- seq(-40, 40, by = 10)
    }
  }

  ####################################
  grid <- expand.grid(plate_x = seq(-1.5, 1.5, length=50),
                      plate_z = seq(1, 4, length=50))
  df_p <- NULL
  for(j in 1:N_df){
    df_c <- grid
    df_c$lp <- predict(fit[[j]], df_c)
    if (type %in% c("ms", "cs", "h", "hr", "sw", "mc")){
    df_c$lp <- exp(df_c$lp) / (1 + exp(df_c$lp))
    }
    df_c$Group <- names(df)[j]
    df_p <- rbind(df_p, df_c)
  }

  topKzone <- 3.5
  botKzone <- 1.6
  inKzone <- -0.85
  outKzone <- 0.85
  kZone <- data.frame(
    x=c(inKzone, inKzone, outKzone, outKzone, inKzone),
    y=c(botKzone, topKzone, topKzone, botKzone, botKzone)
  )
  ggplot(df_p)  +
      geom_contour_fill(aes(x=.data$plate_x,
                            y=.data$plate_z,
                            z=.data$lp),
                   breaks=c(L),
                   size=1.5) +
    scale_fill_distiller(palette="Spectral")  +
      geom_path(aes(.data$x, .data$y), data=kZone,
                lwd=1, col="black") +
      xlim(-1.5, 1.5) +
      ylim(1.0, 4.0)  +
      coord_fixed() +
    facet_wrap(~ Group, ncol = Ncol) +
    ggtitle(paste(title, etitle)) +
    centertitle() +
    increasefont()
#  }
}

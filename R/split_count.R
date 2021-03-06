split_count <- function(sc){
  sc %>%
    mutate(Count = paste(balls, strikes, sep="-"),
           Count_Type = ifelse(Count %in%
               c("2-0", "3-1", "3-0"), "Ahead in Count",
            ifelse(Count %in%
               c("0-1", "0-2", "1-2", "2-2"),
              "Behind in Count", "Neutral Count"))) -> sc
  split(sc, sc$Count_Type)
}
